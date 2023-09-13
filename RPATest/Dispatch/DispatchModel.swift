//
//  DispatchModel.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/02.
//

import Foundation
import Alamofire

final class DispatchModel {
    private(set) var loadDailyDispatchRequest: DataRequest?
    private(set) var loadMonthlyDispatchRequest: DataRequest?
    
    func loadDailyDispatchRequest(date: String, success: ((DispatchDailyItem) -> ())?, dispatchFailure: ((Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/daily/\(date)"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadDailyDispatchRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadDailyDispatchRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDailyDispatchRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDailyDispatchRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(DispatchDaily.self, from: data) {
                            print("loadDailyDispatchRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("loadDailyDispatchRequest failure: API 성공, Parsing 실패")
                            print(decodedData)
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        if let decodedData = try? JSONDecoder().decode(FailureResponse.self, from: data) {
                            // parsing failure
                            print("loadDailyDispatchRequest succeeded: LoginFailure")
                            dispatchFailure?(decodedData.data)
                        } else {
                            print("loadDailyDispatchRequest failure: \(decodedData.result)")
                            failure?(decodedData.result)
                        }
                    }
                    
                } else { // improper structure
                    print("loadDailyDispatchRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadDailyDispatchRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadMonthlyDispatchRequest(month: String, success: ((DispatchMonthlyItem) -> ())?, dispatchFailure: ((Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/monthly/\(month)"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadMonthlyDispatchRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadMonthlyDispatchRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadMonthlyDispatchRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadMonthlyDispatchRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(DispatchMonthly.self, from: data) {
                            print("loadMonthlyDispatchRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("loadMonthlyDispatchRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        if let decodedData = try? JSONDecoder().decode(FailureResponse.self, from: data) {
                            // parsing failure
                            print("loadMonthlyDispatchRequest succeeded: LoginFailure")
                            dispatchFailure?(decodedData.data)
                        } else {
                            print("loadMonthlyDispatchRequest failure: \(decodedData.result)")
                            failure?(decodedData.result)
                        }
                    }
                    
                } else { // improper structure
                    print("loadMonthlyDispatchRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadMonthlyDispatchRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
}

struct DispatchMonthly: Codable {
    let result: String
    let data: DispatchMonthlyItem
}

struct DispatchMonthlyItem: Codable {
    let order: [Int]
    let attendance: [Int]
    let leaveWork: [Int]
    
    enum CodingKeys: String, CodingKey {
        case order
        case attendance = "regularly_c"
        case leaveWork = "regularly_t"
    }
}

struct DispatchDaily: Codable {
    let result: String
    let data: DispatchDailyItem
}

struct DispatchDailyItem: Codable {
    let regularly: [DispatchRegularlyItem]
    let order: [DispatchRegularlyItem]?
}

struct DispatchRegularlyItem: Codable {
    let id: Int
    let price: String
    let driverAllowance: String
    let workType: String
    let route: String
    let location: String
    let checkRegularlyConnect: CheckRegularlyConnect
    let detailedRoute: String
    let maplink: String
    let group: String
    let references: String
    let departure: String
    let arrival: String
    let week: String
    let departureDate: String
    let arrivalDate: String
    let busId: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case driverAllowance = "driver_allowance"
        case workType = "work_type"
        case route
        case location
        case checkRegularlyConnect = "check_regularly_connect"
        case detailedRoute = "detailed_route"
        case maplink
        case group
        case references
        case departure
        case arrival
        case week
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case busId = "bus_id"
    }
}

struct CheckRegularlyConnect: Codable {
    let wakeTime: String
    let driveTime: String
    let departureTime: String
    let connectCheck: String
    
    enum CodingKeys: String, CodingKey {
        case wakeTime = "wake_time"
        case driveTime = "drive_time"
        case departureTime = "departure_time"
        case connectCheck = "connect_check"
    }
}
