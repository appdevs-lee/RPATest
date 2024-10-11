//
//  VehicleModel.swift
//  RPATest
//
//  Created by Awesomepia on 10/10/24.
//

import UIKit
import Alamofire

final class VehicleModel {
    private(set) var loadMonrningCheckDataRequest: DataRequest?
    private(set) var loadVehicleListDataRequest: DataRequest?
    private(set) var sendDailyCheckDataRequest: DataRequest?
    private(set) var sendMorningCheckDataRequest: DataRequest?
    
    func loadMonrningCheckDataRequest(date: String? = nil, success: ((MorningCheckItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/checklist/morning/\(date == nil ? SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd") : date!)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadMonrningCheckDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadMonrningCheckDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadMonrningCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadMonrningCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(MorningCheck.self, from: data) {
                    print("loadMonrningCheckDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadMonrningCheckDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }

                
            case .failure(let error):
                print("loadMonrningCheckDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadVehicleListDataRequest(success: ((Vehicle) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/vehicle"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadVehicleListDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadVehicleListDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadVehicleListDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadVehicleListDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Vehicle.self, from: data) {
                    print("loadVehicleListDataRequest succeeded")
                    success?(decodedData)
                    
                } else {
                    print("loadVehicleListDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadVehicleListDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendDailyCheckDataRequest(date: String? = nil, busId: Int, engineOil: CheckResult, powerClutch: CheckResult, washer: CheckResult, externalBody: CheckResult, lightingDevice: CheckResult, blackbox: CheckResult, tire: CheckResult, interior: CheckResult, safetyBelt: CheckResult, uniform: CheckResult, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/vehicle/checklist/daily/\(date == nil ? SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd") : date!)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "bus_id": busId,
            "oil_engine_condition": engineOil.value,
            "oil_power_clutch_condition": powerClutch.value,
            "coolant_washer_condition": washer.value,
            "external_body_condition": externalBody.value,
            "lighting_device_condition": lightingDevice.value,
            "blackbox_condition": blackbox.value,
            "tire_condition": tire.value,
            "interior_condition": interior.value,
            "safety_belt_slide_condition": safetyBelt.value,
            "uniform_worn_condition": uniform.value,
        ]
        
        self.sendDailyCheckDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendDailyCheckDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendDailyCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendDailyCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                success?()
                
            case .failure(let error):
                print("sendDailyCheckDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendMorningCheckDataRequest(date: String? = nil, time: String, health: CheckResult, clean: CheckResult, route: CheckResult, alcoholValue: Double, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = Server.server.URL + "/dispatch/checklist/morning/\(date == nil ? SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd") : date!)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "arrival_time": time,
            "health_condition": health.value,
            "cleanliness_condition": clean.value,
            "route_familiarity": route.value,
            "alcohol_test": alcoholValue,
        ]
        
        self.sendMorningCheckDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendMorningCheckDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendMorningCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendMorningCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendMorningCheckDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendMorningCheckDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}

enum CheckResult: Int {
    case good = 1
    case notGood = 0
    
    var value: String {
        switch self {
        case .good:
            return "양호"
            
        case .notGood:
            return "이상"
            
        }
    }
}

struct MorningCheck: Codable {
    let data: MorningCheckItem
}

struct MorningCheckItem: Codable {
    let submitCheck: Bool
    
    enum CodingKeys: String, CodingKey {
        case submitCheck = "submit_check"
    }
}

struct Vehicle: Codable {
    let driverVehicleList: [VehicleItem]
    let vehicleList: [VehicleItem]
    
    enum CodingKeys: String, CodingKey {
        case driverVehicleList = "driver_vehicle_list"
        case vehicleList = "vehicle_list"
    }
}

struct VehicleItem: Codable {
    let id: Int
    let vehicleSubNum: String
    let vehicleMainNum: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case vehicleSubNum = "vehicle_num0"
        case vehicleMainNum = "vehicle_num"
    }
}
