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
    // 월별 배차 정보 가져오는 API
    private(set) var loadMonthlyDispatchRequest: DataRequest?
    // 배차확인 patch API
    private(set) var sendRunningDataRequest: DataRequest?
    // 운행일보 get API
    private(set) var loadRunningDiaryDataRequest: DataRequest?
    // 운행일보 patch API
    private(set) var sendRunningDiaryDataRequest: DataRequest?
    
    
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
    
    func sendRunningDataRequest(checkType: String, time: String, regularlyId: String = "", orderId: String = "", success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/check"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "check_type": checkType,
            "time": time,
            "regularly_id": regularlyId,
            "order_id": orderId,
        ]
        
        self.sendRunningDataRequest = AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendRunningDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendRunningDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendRunningDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendRunningDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendRunningDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
            
        }
        
    }
    
    func loadMonthlyDispatchRequest(month: String, success: ((MonthlyDispatchItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/monthly/\(month)"
        
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
                
                if let decodedData = try? JSONDecoder().decode(MonthlyDispatch.self, from: data) {
                    print("loadMonthlyDispatchRequest succeeded")
                    success?(decodedData.data)
                                        
                } else {
                    print("loadMonthlyDispatchRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error): // error
                print("loadMonthlyDispatchRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadRunningDiaryDataRequest(regularlyId: String, orderId: String, success: ((RunningDiaryItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/drivinghistory"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "regularly_connect_id": regularlyId,
            "order_connect_id": orderId,
        ]
        
        self.loadRunningDiaryDataRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadRunningDiaryDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadRunningDiaryDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadRunningDiaryDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(RunningDiary.self, from: data) {
                    print("loadRunningDiaryDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadRunningDiaryDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadRunningDiaryDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendRunningDiaryDataRequest(regularlyId: String = "", orderId: String = "", departureDate: String, arrivalDate: String, departureKM: String, arrivalKM: String, passengerNumber: String, specialNotes: String, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/drivinghistory"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "regularly_connect_id": regularlyId,
            "order_connect_id": orderId,
            "departure_date": departureDate,
            "arrival_date": arrivalDate,
            "departure_km": departureKM,
            "arrival_km": arrivalKM,
            "passenger_num": passengerNumber,
            "special_notes": specialNotes
        ]
        
        self.sendRunningDiaryDataRequest = AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendRunningDiaryDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendRunningDiaryDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendRunningDiaryDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendRunningDiaryDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendRunningDiaryDataRequest error: \(error.localizedDescription)")
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

// MARK: 일일 배차 가져오는 API Model
struct DailyDispatch: Codable {
    let data: DailyDispatchItem
}

struct DailyDispatchItem: Codable {
    let regularly: [DailyDispatchDetailItem]
    let order: [DailyDispatchDetailItem]
}

struct DailyDispatchDetailItem: Codable {
    // common
    let id: Int // 배차 번호
    let busId: String // 버스 번호
    let departure: String // 출발지
    let arrival: String // 도착지
    let departureDate: String // 출발 시간
    let arrivalDate: String // 도착 시간
    let references: String // 참고 사항
    
    // regularly
    let group: String? // 그룹
    let route: String? // 노선 분류
    let checkRegularlyConnect: ConnectCheck? // 운행 수락 여부 및 실시간 운행 정보
    let maplink: String? // 카카오맵 링크
    let detailedRoute: String? // 정류장
    
    // order
    let checkOrderConnect: ConnectCheck? // 운행 수락 여부 및 실시간 운행 정보
    let operationType: String? // 왕복 or 편도 or 셔틀
    let busType: String? // 몇인승 어떤 버스인지
    let busCount: String? // 버스 대수
    let customer: String? // 신청 고객
    let customerPhone: String? // 신청 고객 전화번호
    
    
    enum CodingKeys: String, CodingKey {
        // common
        case id
        case busId = "bus_id"
        case departure
        case arrival
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case references
        
        // regularly
        case group
        case route
        case checkRegularlyConnect = "check_regularly_connect"
        case maplink
        case detailedRoute = "detailed_route"
        
        // order
        case checkOrderConnect = "check_order_connect"
        case operationType = "operation_type"
        case busType = "bus_type"
        case busCount = "bus_cnt"
        case customer
        case customerPhone = "customer_phone"
        
    }
    
}

// MARK: 월별 배차 API Model
struct MonthlyDispatch: Codable {
    let data: MonthlyDispatchItem
}

struct MonthlyDispatchItem: Codable {
    let order: [Int]
    let attendance: [Int]
    let leaveWork: [Int]
    
    enum CodingKeys: String, CodingKey {
        case order
        case attendance = "regularly_c"
        case leaveWork = "regularly_t"
    }
}

// MARK: 운행 일보 API Model
struct RunningDiary: Codable {
    let data: RunningDiaryItem
}

struct RunningDiaryItem: Codable {
    let date: String
    let member: String
    let regularlyId: Int?
    let orderId: Int?
    let departureKM: String
    let arrivalKM: String
    let passengerNum: String
    let specialNotes: String
    let departureDate: String
    let arrivalDate: String
    let connect: RunningDiaryConnect
    let submitCheck: Bool
    
    enum CodingKeys: String, CodingKey {
        case date
        case member
        case regularlyId = "regularly_connect_id"
        case orderId = "order_connect_id"
        case departureKM = "departure_km"
        case arrivalKM = "arrival_km"
        case passengerNum = "passenger_num"
        case specialNotes = "special_notes"
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case connect
        case submitCheck = "submit_check"
    }
}

struct RunningDiaryConnect: Codable {
    let bus: String
    let departure: String
    let arrival: String
    let departureDate: String
    let arrivalDate: String
    
    enum CodingKeys: String, CodingKey {
        case bus
        case departure
        case arrival
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
    }
}
