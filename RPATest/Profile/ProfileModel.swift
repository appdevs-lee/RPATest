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
    
    func loadSalaryStatementRequest(date: Date, success: ((String) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/salary/detail"
        
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
}
