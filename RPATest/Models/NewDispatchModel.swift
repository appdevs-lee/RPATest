//
//  NewDispatchModel.swift
//  RPATest
//
//  Created by 이주성 on 10/1/24.
//

import UIKit
import Alamofire

// MARK: Enum for DispatchModel
enum Check: Int {
    case accept = 1
    case refusal = 0
}

final class NewDispatchModel {
    
    // 배차 확인 했는지 가져오는 API(명일)
    private(set) var loadWhetherOrNotDispatchCheckRequest: DataRequest?
    // 일일 배차 가져오는 API
    private(set) var loadDailyDispatchRequest: DataRequest?
    // 배차 확인 및 거부 API
    private(set) var sendDispatchCheckDataRequest: DataRequest?
    
    func loadWhetherOrNotDispatchCheckRequest(date: String, success: ((DispatchCheckItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/daily/\(date)"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadWhetherOrNotDispatchCheckRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadWhetherOrNotDispatchCheckRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadWhetherOrNotDispatchCheckRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadWhetherOrNotDispatchCheckRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DispatchCheck.self, from: data) {
                    print("loadWhetherOrNotDispatchCheckRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadWhetherOrNotDispatchCheckRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadWhetherOrNotDispatchCheckRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadDailyDispatchRequest(date: String, success: ((DailyDispatchItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/daily/\(date)"
        
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
                
                if let decodedData = try? JSONDecoder().decode(DailyDispatch.self, from: data) {
                    print("loadDailyDispatchRequest succeeded")
                    success?(decodedData.data)
                                        
                } else {
                    print("loadDailyDispatchRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error): // error
                print("loadDailyDispatchRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendDispatchCheckDataRequest(check: Check, refusal: String = "", regularlyId: String, orderId: String, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/connect/check"
        print(url)
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "check": check.rawValue,
            "refusal": refusal,
            "regularly_id": "\(regularlyId)",
            "order_id": "\(orderId)",
        ]
        
        self.sendDispatchCheckDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendDispatchCheckDataRequest?.responseData { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendDispatchCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendDispatchCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                success?()
                
            case .failure(let error): // error
                print("sendDispatchCheckDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
        
    }
}

// MARK: 배차 확인 여부(당일 + 명일) API Model
struct DispatchCheck: Codable {
    let data: DispatchCheckItem
}

struct DispatchCheckItem: Codable {
    let regularly: [DispatchCheckDetailItem]
    let order: [DispatchCheckDetailItem]
}

struct DispatchCheckDetailItem: Codable {
    let checkRegularlyConnect: ConnectCheck?
    
    let checkOrderConnect: ConnectCheck?
    
    enum CodingKeys: String, CodingKey {
        case checkRegularlyConnect = "check_regularly_connect"
        case checkOrderConnect = "check_order_connect"
    }
}

struct ConnectCheck: Codable {
    let connectCheck: String
    
    enum CodingKeys: String, CodingKey {
        case connectCheck = "connect_check"
    }
}

// MARK: 일일 배차 가져오는 API Model
struct DailyDispatch: Codable {
    let data: DailyDispatchItem
}

struct DailyDispatchItem: Codable {
    let regularly: [DailyDispatchDetailItem]
    let order: [DailyDispatchDetailItem]
}

struct DailyDispatchDetailItem: Codable {
    let id: Int
    let group: String?
    let route: String?
    let checkRegularlyConnect: ConnectCheck?
    let checkOrderConnect: ConnectCheck?
    let busId: String
    let departure: String
    let arrival: String
    let departureDate: String
    let arrivalDate: String
    let maplink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case group
        case route
        case checkRegularlyConnect = "check_regularly_connect"
        case checkOrderConnect = "check_order_connect"
        case busId = "bus_id"
        case departure
        case arrival
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case maplink
    }
    
}

