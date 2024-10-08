//
//  InspectionModel.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import Foundation
import Alamofire

final class InspectionModel {
    private(set) var loadInspectionListRequest: DataRequest?
    
    func loadInspectionListRequest(page: Int, success: ((InspectionList) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/complaint/inspection"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "page": page
        ]
        
        self.loadInspectionListRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadInspectionListRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadInspectionListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadInspectionListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(InspectionList.self, from: data) {
                    success?(decodedData)
                    
                } else { // improper structure
                    print("loadInspectionListRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadInspectionListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}
// /complaint/inspection

struct Inspection: Codable {
    let success: String
    let data: InspectionItem
}

struct InspectionItem: Codable {
    let id: Int
    let content: String
    let date: String
    let status: String
    let vehicleId: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case date
        case status
        case vehicleId = "vehicle_id"
    }
}

struct InspectionList: Codable {
    let count: Int
    let next: String?
    let results: [InspectionItem]
}

struct VehicleList: Codable {
    let driverVehicleList: [VehicleListItem]
    let vehicleList: [VehicleListItem]
    
    enum CodingKeys: String, CodingKey {
        case driverVehicleList = "driver_vehicle_list"
        case vehicleList = "vehicle_list"
    }
}

struct VehicleListItem: Codable {
    let id: Int
    let vehicleNameKr: String
    let vehicleNum: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case vehicleNameKr = "vehicle_num0"
        case vehicleNum = "vehicle_num"
    }
}
