//
//  ProfileModel.swift
//  RPATest
//
//  Created by Awesomepia on 11/22/23.
//

import Foundation
import Alamofire

final class ProfileModel {
    private(set) var loadSalaryStatementRequest: DataRequest?
    private(set) var signSalaryStatementRequest: DataRequest?
    
    // MARK: - 급여명세서 불러오는 API
    func loadSalaryStatementRequest(date: Date, success: ((String) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/salary/detail"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "date": SupportingMethods.shared.convertDate(intoString: date, "yyyy-MM")
        ]
        
        self.loadSalaryStatementRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadSalaryStatementRequest?.responseString { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchGroupListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchGroupListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                success?(data)
                
            case .failure(let error): // error
                print("loadDispatchGroupListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    // MARK: - 급여명세서 사인 API
    func signSalaryStatementRequest(date: String, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/salary/detail"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "date": date
        ]
        
        self.signSalaryStatementRequest = AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.signSalaryStatementRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("signSalaryStatementRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("signSalaryStatementRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        print("signSalaryStatementRequest succeeded")
                        success?()
                        
                    } else {
                        print("signSalaryStatementRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("signSalaryStatementRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("signSalaryStatementRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}
