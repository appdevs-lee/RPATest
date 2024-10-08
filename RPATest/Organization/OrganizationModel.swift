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
    private(set) var clientSearchRequest: DataRequest?
    
    func memberSearchRequest(page: Int, search: String, role: String, success: ((MemberItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/member/list"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "search": search,
            "page": page,
            "separate_role": role
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
                            success?(decodedData.data)
                                                
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
    
    func memberInfoRequest(success: ((MemberInfoDetail) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/member"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.memberInfoRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.memberInfoRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("memberInfoRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("memberInfoRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(MemberInfo.self, from: data) {
                            print("memberInfoRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("memberInfoRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("memberInfoRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("memberInfoRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("memberInfoRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func clientSearchRequest(page: Int, search: String, success: ((ClientItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/client"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "search": search,
            "page": page
        ]
        
        self.clientSearchRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.clientSearchRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("clientSearchRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("clientSearchRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(Client.self, from: data) {
                            print("clientSearchRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("clientSearchRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("clientSearchRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("clientSearchRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("clientSearchRequest error: \(error.localizedDescription)")
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
    let count: Int
    let next: String?
    let memberList: [MemberDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
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

struct Client: Codable {
    let result: String
    let data: ClientItem
    
    enum CodingKeys: CodingKey {
        case result
        case data
    }
}

struct ClientItem: Codable {
    let count: Int
    let next: String?
    let clientList: [ClientDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case clientList = "client_list"
    }
}

struct ClientDetailItem: Codable {
    let name: String
    let phoneNum: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNum = "phone"
    }
    
}

struct MemberInfo: Codable {
    let result: String
    let data: MemberInfoDetail
}

struct MemberInfoDetail: Codable {
    let id: Int
    let userId: String
    let name: String
    let role: String
    let phoneNum: String
    let base: String
    let serviceAllowance: String
    let annualAllowance: String
    let performanceAllowance: String
    let meal: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case name
        case role
        case phoneNum = "phone_num"
        case base
        case serviceAllowance = "service_allowance"
        case annualAllowance = "annual_allowance"
        case performanceAllowance = "performance_allowance"
        case meal
    }
}
