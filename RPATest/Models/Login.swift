//
//  Login.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/04.
//

import Foundation
import Alamofire

final class LoginModel {
    private(set) var loginRequest: DataRequest?
    private(set) var tokenRefreshRequest: DataRequest?
    
    func loginRequest(id: String, pwd: String, success: ()?, failure: ()?) {
        let url = ReferenceValues.shared.currentURL?.rawValue ?? ""
        
        let headers: HTTPHeaders = [
            "access": "application/json"
        ]
        
        let parameters: Parameters = [
            "user_id": id,
            "password": pwd
        ]
        
        self.loginRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.loginRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loginRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loginRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(TravelArea.self, from: data) {
                            print("loginRequest succeeded")
                            success?(decodedData.data)
                            
                        } else { // parsing failure
                            print("loginRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("loginRequest failure: \(decodedData.message)")
                        failure?(decodedData.message)
                    }
                    
                } else { // improper structure
                    print("loginRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loginRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func postLogin(id: String, pwd: String, completionHandler: @escaping (String) -> Void) {
        let url = "\(Server.serverURL)/login"
        let body =
        ["user_id":id,
         "password":pwd]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    print("Success")
                    do {
                        print("Not JSON Decoding: \(value)")
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let json = try JSONDecoder().decode(Login.self, from: jsonData)
                        print("JSON Decoding: \(json)")
                        UserInfo.shared.access = json.access
                        UserDefaults.standard.set(json.authenticatedUser.name, forKey: "name")
                        UserDefaults.standard.set(json.refresh, forKey: "refreshToken")
                        completionHandler(id)
                    } catch(let error) {
                        print("Catch Error: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print("Failure Error: \(error.localizedDescription)")
                }
            }
    }
}

struct Login: Codable {
    let success: Bool
    let statusCode: Int
    let message: String
    let access: String
    let refresh: String
    let authenticatedUser: LoginDetail
}

struct LoginDetail: Codable {
    let user_id: String
    let name: String
    let role: String
}

struct Refresh: Codable {
    let access: String
    let refresh: String
}

func postTokenRefresh(completionHandler: @escaping () -> Void) {
    let url = "\(Server.serverURL)/token/refresh"
    let body = ["refresh":"\(getRefreshToken())"]
    
    AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"])
        .validate(statusCode: 200..<300)
        .responseJSON { (response) in
            switch response.result {
            case .success(let value):
                print("Success")
                do {
                    print("Not JSON Decoding: \(value)")
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let json = try JSONDecoder().decode(Refresh.self, from: jsonData)
                    print("JSON Decoding: \(json)")
                    UserInfo.shared.access = json.access
                    UserDefaults.standard.set(json.refresh, forKey: "refreshToken")
                    completionHandler()
                } catch(let error) {
                    print("Catch Error: \(error.localizedDescription)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "LoginNav")
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: false)
                }
            case .failure(let error):
                print("Failure Error: \(error.localizedDescription)")
                // Server Error 표시 해줘야 함
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginNav")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: false)
            }
        }
}
