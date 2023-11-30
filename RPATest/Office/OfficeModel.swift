//
//  OfficeModel.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import Foundation
import Alamofire

final class OfficeModel {
    private(set) var sendRefuelingDataRequest: DataRequest?
    private(set) var loadGasStationRequest: DataRequest?
    
    func sendRefuelingDataRequest(date: String, vehicle: Int, driver: Int, km: Double, refuelingAmount: Double, ureaSolution: Double, gasStation: Int, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/vehicle/refueling"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "refueling_date": date,
            "vehicle": vehicle,
            "driver": driver,
            "km": km,
            "refueling_amount": refuelingAmount,
            "urea_solution": ureaSolution,
            "gas_station": gasStation,
        ]
        
        self.sendRefuelingDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.sendRefuelingDataRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendRefuelingDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendRefuelingDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        print("sendRefuelingDataRequest succeeded")
                        success?()
                        
                    } else { // result == false
                        print("sendRefuelingDataRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("sendRefuelingDataRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("sendRefuelingDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
        
        
    }
    
    // MARK: - 주유장소 가져오기
    func loadGasStationRequest(page: Int, search: String, success: ((GasStationItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/gasstation"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "page": page,
            "search": search
        ]
        
        self.loadGasStationRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadGasStationRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadGasStationRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadGasStationRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        if let decodedData = try? JSONDecoder().decode(GasStation.self, from: data) {
                            print("loadGasStationRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("loadGasStationRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else {
                        print("loadGasStationRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("loadGasStationRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("loadGasStationRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}

class DispatchScheduleItem {
    let name: String
    let vehicleNumber: String
    let separateRole: String
    let phoneNumber: String
    let time: String
    let path: String
    let checkVehicleStatusPlace: String
    let gate: String
    let note: String
    var check: Bool
    // 셔틀?
    
    init(name: String, vehicleNumber: String, separateRole: String, phoneNumber: String, time: String, path: String, checkVehicleStatusPlace: String, gate: String, note: String, check: Bool) {
        self.name = name
        self.vehicleNumber = vehicleNumber
        self.separateRole = separateRole
        self.phoneNumber = phoneNumber
        self.time = time
        self.path = path
        self.checkVehicleStatusPlace = checkVehicleStatusPlace
        self.gate = gate
        self.note = note
        self.check = check
    }
}

struct GasStation: Codable {
    let result: String
    let data: GasStationItem
}

struct GasStationItem: Codable {
    let count: Int
    let next: String?
    let gasStationList: [GasStationDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case gasStationList = "gas_station_list"
    }
}

struct GasStationDetailItem: Codable {
    let id: Int
    let type: String
    let category: String
}


