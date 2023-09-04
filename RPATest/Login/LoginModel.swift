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
    
    func loginRequest(id: String, pwd: String, success: ((LoginDetail) -> ())?, loginFailure: ((_ reason: Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/login"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
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
                        if let decodedData = try? JSONDecoder().decode(Login.self, from: data) {
                            print("loginRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("loginRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        if let decodedData = try? JSONDecoder().decode(LoginFailure.self, from: data) {
                            // parsing failure
                            print("loginRequest succeeded: LoginFailure")
                            loginFailure?(decodedData.data)
                        } else {
                            print("loginRequest failure: \(decodedData.result)")
                            failure?(decodedData.result)
                        }
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
    
    func tokenRefreshRequest(success: ((Token) -> ())?, refreshFailure: ((Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/token/refresh"
        print(url)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "refresh": "\(getRefreshToken())"
        ]
        
        self.tokenRefreshRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.tokenRefreshRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("tokenRefreshRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("tokenRefreshRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(Refresh.self, from: data) {
                            print("tokenRefreshRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("tokenRefreshRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        if let decodedData = try? JSONDecoder().decode(FailureResponse.self, from: data) {
                            // parsing failure
                            print("tokenRefreshRequest succeeded: LoginFailure")
                            refreshFailure?(decodedData.data)
                        } else {
                            print("tokenRefreshRequest failure: \(decodedData.result)")
                            failure?(decodedData.result)
                        }
                    }
                    
                } else { // improper structure
                    print("tokenRefreshRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("tokenRefreshRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
}

struct Login: Codable {
    let result: String
    let data: LoginDetail
}

struct LoginFailure: Codable {
    let result: String
    let data: Int
}

struct LoginDetail: Codable {
    let access: String
    let refresh: String
    let authenticatedUser: UserInfoDetail
}

struct UserInfoDetail: Codable {
    let user_id: String
    let name: String
    let role: String
}


struct Refresh: Codable {
    let result: String
    let data: Token
}

struct Token: Codable {
    let access: String
    let refresh: String
}

struct FailureResponse: Codable {
    let result: String
    let data: Int
}
