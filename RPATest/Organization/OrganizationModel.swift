//
//  OrganizationModel.swift
//  RPATest
//
//  Created by 이주성 on 10/29/23.
//

import Foundation
import Alamofire

final class OrganizationModel {
    private(set) var memberSearchRequest: DataRequest?
    private(set) var memberInfoRequest: DataRequest?
    
    func memberSearchRequest(search: String, success: (([MemberDetailItem]) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/member/list"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "search": search
        ]
        
        self.memberSearchRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.memberSearchRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("memberSearchRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("memberSearchRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(Member.self, from: data) {
                            print("memberSearchRequest succeeded")
                            success?(decodedData.data.memberList)
                                                
                        } else {
                            print("memberSearchRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("memberSearchRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("memberSearchRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("memberSearchRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}

struct Member: Codable {
    let result: String
    let data: MemberItem
    
    enum CodingKeys: CodingKey {
        case result
        case data
    }
}

struct MemberItem: Codable {
    let memberList: [MemberDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case memberList = "member_list"
    }
}

struct MemberDetailItem: Codable {
    let name: String
    let role: String
    let phoneNum: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case role
        case phoneNum = "phone_num"
    }
    
}
