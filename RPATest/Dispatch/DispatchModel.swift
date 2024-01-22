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
    private(set) var checkDispatchRequest: DataRequest?
    private(set) var checkPatchDispatchRequest: DataRequest?
    private(set) var loadDispatchGroupListRequest: DataRequest?
    private(set) var loadDispatchPathRequest: DataRequest?
    private(set) var pathKnowRequest: DataRequest?
    private(set) var pathKnowDeleteRequest: DataRequest?
    private(set) var loadVehicleListRequest: DataRequest?
    private(set) var sendMorningRollCallDataRequest: DataRequest?
    private(set) var loadMorningRollCallDataRequest: DataRequest?
    private(set) var sendEveningRollCallDataRequest: DataRequest?
    private(set) var loadEveningRollCallDataRequest: DataRequest?
    private(set) var loadGarageRequest: DataRequest?
    private(set) var loadDispatchNoteDetailRequest: DataRequest?
    private(set) var sendDispatchNoteDetailRequest: DataRequest?
    private(set) var loadDispatchScheduleListRequest: DataRequest?
    private(set) var loadDispatchScheduleDetailRequest: DataRequest?
    
    
    func loadDailyDispatchRequest(date: String, success: ((DispatchDailyItem) -> ())?, dispatchFailure: ((Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/daily/\(date)"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        print(UserInfo.shared.access!)
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
    
    func checkDispatchRequest(check: String, refusal: String = "", regularlyId: String, orderId: String, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/connect/check"
        print(url)
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "check": check,
            "refusal": refusal,
            "regularly_id": regularlyId,
            "order_id": orderId
        ]
        
        self.checkDispatchRequest = AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.checkDispatchRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("checkDispatchRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("checkDispatchRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let _ = try? JSONDecoder().decode(Temporary.self, from: data) {
                    success?()
                    
                } else { // improper structure
                    print("checkDispatchRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("checkDispatchRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
        
    }
    
    func checkPatchDispatchRequest(checkType: String, time: String, regularlyId: String, orderId: String, success: ((CheckDriveItem) -> ())?, dispatchFailure: ((Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/check"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "check_type": checkType,
            "time": time,
            "regularly_id": regularlyId,
            "order_id": orderId
        ]
        
        self.checkPatchDispatchRequest = AF.request(url, method: .patch, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.checkPatchDispatchRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("checkPatchDispatchRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("checkPatchDispatchRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(CheckDrive.self, from: data) {
                            print("checkPatchDispatchRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("checkPatchDispatchRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        if let decodedData = try? JSONDecoder().decode(FailureResponse.self, from: data) {
                            // parsing failure
                            print("checkPatchDispatchRequest succeeded: LoginFailure")
                            dispatchFailure?(decodedData.data)
                        } else {
                            print("checkPatchDispatchRequest failure: \(decodedData.result)")
                            failure?(decodedData.result)
                        }
                    }
                    
                } else { // improper structure
                    print("checkPatchDispatchRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("checkPatchDispatchRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
        
        
    }
    
    func loadDispatchGroupListRequest(success: (([DispatchSearchItemGroupList]) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/regularly/group"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadDispatchGroupListRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchGroupListRequest?.responseData { response in
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
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(DispatchSearch.self, from: data) {
                            print("loadDispatchGroupListRequest succeeded")
                            success?(decodedData.data.groupList)
                                                
                        } else {
                            print("loadDispatchGroupListRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("loadDispatchGroupListRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("loadDispatchGroupListRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadDispatchGroupListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadDispatchPathRequest(page: Int, search: String, id: Int, success: ((DispatchPathItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/regularly"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "page": page,
            "search": search,
            "group": id
        ]
        
        self.loadDispatchPathRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchPathRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchPathRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchPathRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(DispatchPath.self, from: data) {
                            print("loadDispatchPathRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("loadDispatchPathRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("loadDispatchPathRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("loadDispatchPathRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadDispatchPathRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func pathKnowRequest(id: Int, success: ((DispatchPathKnowItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/regularly/know"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "regularly_id": id
        ]
        
        self.pathKnowRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.pathKnowRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("pathKnowRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("pathKnowRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(DispatchPathKnow.self, from: data) {
                            print("pathKnowRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("pathKnowRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("pathKnowRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("pathKnowRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("pathKnowRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func pathKnowDeleteRequest(id: Int, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/regularly/know"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "regularly_id": id
        ]
        
        self.pathKnowDeleteRequest = AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.pathKnowDeleteRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("pathKnowDeleteRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("pathKnowDeleteRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        success?()
                        
                    } else { // result == false
                        print("pathKnowDeleteRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                        
                    }
                    
                } else { // improper structure
                    print("pathKnowDeleteRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("pathKnowDeleteRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    // MARK: - 차량 목록 가져오기
    func loadVehicleListRequest(success: (([VehicleListItem]) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/vehicle"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadVehicleListRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadVehicleListRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadVehicleListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadVehicleListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(VehicleList.self, from: data) {
                    success?(decodedData.vehicleList)
                    
                } else { // improper structure
                    print("loadVehicleListRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadVehicleListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendMorningRollCallDataRequest(date: String, time: String, health: String, clean: String, pathKnow: String, alcohol: String, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        // 2023-12-04
        let url = Server.shared.currentURL! + "/dispatch/checklist/morning/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "arrival_time": time,
            "health_condition": health,
            "cleanliness_condition": clean,
            "route_familiarity": pathKnow,
            "alcohol_test": alcohol,
        ]
        
        self.sendMorningRollCallDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendMorningRollCallDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendMorningRollCallDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendMorningRollCallDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        print("sendMorningRollCallDataRequest succeeded")
                        success?()
                        
                    } else {
                        print("sendMorningRollCallDataRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("sendMorningRollCallDataRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("sendMorningRollCallDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadMorningRollCallDataRequest(date: String, success: ((MorningRollCallItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.shared.currentURL! + "/dispatch/checklist/morning/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadMorningRollCallDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadMorningRollCallDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadMorningRollCallDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadMorningRollCallDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        if let decodedData = try? JSONDecoder().decode(MorningRollCall.self, from: data) {
                            print("loadMorningRollCallDataRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("loadMorningRollCallDataRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else {
                        print("loadMorningRollCallDataRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("loadMorningRollCallDataRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("loadMorningRollCallDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendEveningRollCallDataRequest(locationId: Int, batteryCondition: String, driveDistance: String, fuel: String, urea: String, suitGauge: String, specialNotes: String, date: String, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.shared.currentURL! + "/dispatch/checklist/evening/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "garage_location": "\(locationId)",
            "battery_condition": "\(batteryCondition)",
            "drive_distance": "\(driveDistance)",
            "fuel_quantity": "\(fuel)",
            "urea_solution_quantity": "\(urea)",
            "suit_gauge": "\(suitGauge)",
            "special_notes": "\(specialNotes)",
        ]
        
        self.sendEveningRollCallDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendEveningRollCallDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendEveningRollCallDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendEveningRollCallDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        print("sendEveningRollCallDataRequest succeeded")
                        success?()
                        
                    } else {
                        print("sendEveningRollCallDataRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("sendEveningRollCallDataRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("sendEveningRollCallDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadEveningRollCallDataRequest(date: String, success: ((EveningRollCallItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.shared.currentURL! + "/dispatch/checklist/evening/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadEveningRollCallDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadEveningRollCallDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadEveningRollCallDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadEveningRollCallDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        if let decodedData = try? JSONDecoder().decode(EveningRollCall.self, from: data) {
                            print("loadEveningRollCallDataRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("loadEveningRollCallDataRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else {
                        print("loadEveningRollCallDataRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("loadEveningRollCallDataRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("loadEveningRollCallDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadGarageRequest(page: Int, search: String, success: ((GarageItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.shared.currentURL! + "/garage"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "page": page,
            "search": search
        ]
        
        self.loadGarageRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadGarageRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadGarageRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadGarageRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        if let decodedData = try? JSONDecoder().decode(Garage.self, from: data) {
                            print("loadGarageRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("loadGarageRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else {
                        print("loadGarageRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("loadGarageRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("loadGarageRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadDispatchNoteDetailRequest(regularlyId: String = "", orderId: String = "", success: ((DispatchNoteDetailItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/drivinghistory"
        
        let headers: HTTPHeaders = [
            "Authorization": UserInfo.shared.access!,
            "access": "application/json"
        ]
        
        let parameters: Parameters = [
            "regularly_connect_id": regularlyId,
            "order_connect_id": orderId
        ]
        
        self.loadDispatchNoteDetailRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchNoteDetailRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchNoteDetailRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchNoteDetailRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        if let decodedData = try? JSONDecoder().decode(DispatchNoteDetail.self, from: data) {
                            print("loadDispatchNoteDetailRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("loadDispatchNoteDetailRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else {
                        print("loadDispatchNoteDetailRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("loadDispatchNoteDetailRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("loadDispatchNoteDetailRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendDispatchNoteDetailRequest(type: DispatchKindType, regularlyId: String, orderId: String, departureTime: String, arrivalTime: String, departureFigure: String, arrivalFigure: String, passengerNumber: String, specialNotes: String, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/drivinghistory"
        
        let headers: HTTPHeaders = [
            "Authorization": UserInfo.shared.access!,
            "access": "application/json"
        ]
        
        var parameters: Parameters = [
            "departure_date": departureTime,
            "arrival_date": arrivalTime,
            "departure_km": departureFigure,
            "arrival_km": arrivalFigure,
            "passenger_num": passengerNumber,
            "special_notes": specialNotes
        ]
        
        switch type {
        case .regularly:
            parameters.updateValue(regularlyId, forKey: "regularly_connect_id")
            parameters.updateValue("", forKey: "order_connect_id")
            
        case .order:
            parameters.updateValue("", forKey: "regularly_connect_id")
            parameters.updateValue(orderId, forKey: "order_connect_id")
            
        }
        
        self.sendDispatchNoteDetailRequest = AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendDispatchNoteDetailRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendDispatchNoteDetailRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendDispatchNoteDetailRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        print("sendDispatchNoteDetailRequest succeeded")
                        success?()
                        
                    } else {
                        print("sendDispatchNoteDetailRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else {
                    print("sendDispatchNoteDetailRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("sendDispatchNoteDetailRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    // MARK: - 팀원 배차 리스트 가져오기
    func loadDispatchScheduleListRequest(success: (([TeamScheduleItem]) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/team/list"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadDispatchScheduleListRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchScheduleListRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchScheduleListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchScheduleListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        if let decodedData = try? JSONDecoder().decode(TeamSchedule.self, from: data) {
                            print("loadDispatchScheduleListRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("loadDispatchScheduleListRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else {
                        print("loadDispatchScheduleListRequest failure: false")
                        failure?("false")
                    }
                    
                } else {
                    print("loadDispatchScheduleListRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("loadDispatchScheduleListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    // MARK: - 팀원 배차 상세 정보 가져오기
    func loadDispatchScheduleDetailRequest(id: Int, success: ((TeamScheduleDetailItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/dispatch/team/\(id)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadDispatchScheduleDetailRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchScheduleDetailRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchScheduleDetailRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchScheduleDetailRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" {
                        if let decodedData = try? JSONDecoder().decode(TeamScheduleDetail.self, from: data) {
                            print("loadDispatchScheduleDetailRequest succeeded")
                            success?(decodedData.data)
                            
                        } else {
                            print("loadDispatchScheduleDetailRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else {
                        print("loadDispatchScheduleDetailRequest failure: false")
                        failure?("false")
                    }
                    
                } else {
                    print("loadDispatchScheduleDetailRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error):
                print("loadDispatchScheduleDetailRequest error: \(error.localizedDescription)")
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
    let order: [DispatchOrderItem]
}

struct CheckDrive: Codable {
    let result: String
    let data: CheckDriveItem
}

struct CheckDriveItem: Codable {
    let id: Int
    let wakeTime: String
    let driveTime: String
    let departureTime: String
    let connectCheck: String
    let regularlyId: Int
    let orderId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case wakeTime = "wake_time"
        case driveTime = "drive_time"
        case departureTime = "departure_time"
        case connectCheck = "connect_check"
        case regularlyId = "regularly_id"
        case orderId = "order_id"
    }
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

struct DispatchOrderItem: Codable {
    let id: Int
    let operationType: String
    let busType: String
    let busCount: String
    let price: String // 계약금액
    let driverAllowance: String //  기사수당
    let costType: String
    let customer: String
    let customerPhone: String
    let collectionType: String
    let paymentMethod: String
    let VAT: String
    let option: String
    let ticketingInfo: String
    let orderType: String
    let checkOrderConnect: CheckRegularlyConnect
    let references: String // 참조사항
    let departure: String // 출발지
    let arrival: String // 도착지
    let departureDate: String // 출발일자
    let arrivalDate: String // 도착일자
    let busId: String // 버스번호
    
    enum CodingKeys: String, CodingKey {
        case id
        case operationType = "operation_type"
        case busType = "bus_type"
        case busCount = "bus_cnt"
        case price
        case driverAllowance = "driver_allowance"
        case costType = "cost_type"
        case customer
        case customerPhone = "customer_phone"
        case collectionType = "collection_type"
        case paymentMethod = "payment_method"
        case VAT
        case option
        case ticketingInfo = "ticketing_info"
        case orderType = "order_type"
        case checkOrderConnect = "check_order_connect"
        case references
        case departure
        case arrival
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

struct Temporary: Codable {
    let success: Bool
}

struct DispatchSearch: Codable {
    let result: String
    let data: DispatchSearchItem
}

struct DispatchSearchItem: Codable {
    let groupList: [DispatchSearchItemGroupList]
    
    enum CodingKeys: String, CodingKey {
        case groupList = "group_list"
    }
}

struct DispatchSearchItemGroupList: Codable {
    let id: Int
    let name: String
}

struct DispatchPath: Codable {
    let result: String
    let data: DispatchPathItem
}

struct DispatchPathItem: Codable {
    let count: Int
    let next: String?
    let regularlyList: [DispatchPathRegularlyList]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case regularlyList = "regularly_list"
    }
}

class DispatchPathRegularlyList: Codable {
    let id: Int
    var know: String
    let references: String
    let departure: String
    let arrival: String
    let departureTime: String
    let arrivalTime: String
    let price: String
    let driverAllowance: String
    let number1: String
    let number2: String
    let num1: Int
    let num2: Int
    let week: String
    let workType: String
    let route: String
    let location: String
    let detailedRoute : String
    let maplink: String
    let use: String
    let creator: Int
    
    var isBookmark: Bool = false
    
    enum CodingKeys: String ,CodingKey {
        case id
        case know
        case references
        case departure
        case arrival
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case price
        case driverAllowance = "driver_allowance"
        case number1
        case number2
        case num1
        case num2
        case week
        case workType = "work_type"
        case route
        case location
        case detailedRoute = "detailed_route"
        case maplink
        case use
        case creator
    }
}

struct DispatchPathKnow: Codable {
    let result: String
    let data: DispatchPathKnowItem
}

struct DispatchPathKnowItem: Codable {
    let id: Int
    let regularlyId: Int
    let driverId: Int
    
    enum CodingKeys: String ,CodingKey {
        case id
        case regularlyId = "regularly_id"
        case driverId = "driver_id"
    }
}

struct MorningRollCall: Codable {
    let result: String
    let data: MorningRollCallItem
}

struct MorningRollCallItem: Codable {
    let member: String
    let date: String
    let arrivalTime: String
    let health: String
    let clean: String
    let pathKnow: String
    let alcohol: String
    let bus: [String]
    
    enum CodingKeys: String, CodingKey {
        case member
        case date
        case arrivalTime = "arrival_time"
        case health = "health_condition"
        case clean = "cleanliness_condition"
        case pathKnow = "route_familiarity"
        case alcohol = "alcohol_test"
        case bus
    }
}

struct EveningRollCall: Codable {
    let result: String
    let data: EveningRollCallItem
}

struct EveningRollCallItem: Codable {
    let member: String
    let date: String
    let batteryCondition: String
    let driveDistance: String
    let fuelQuantity: String
    let ureaSolutionQuantity: String
    let suitGauge: String
    let specialNotes: String
    let bus: String
    let garageLocation: String?
    let submitCheck: Bool
    
    enum CodingKeys: String, CodingKey {
        case member
        case date
        case batteryCondition = "battery_condition"
        case driveDistance = "drive_distance"
        case fuelQuantity = "fuel_quantity"
        case ureaSolutionQuantity = "urea_solution_quantity"
        case suitGauge = "suit_gauge"
        case specialNotes = "special_notes"
        case bus
        case garageLocation = "garage_location"
        case submitCheck = "submit_check"

    }
}

struct Garage: Codable {
    let result: String
    let data: GarageItem
}

struct GarageItem: Codable {
    let count: Int
    let next: String?
    let garageList: [GarageDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case garageList = "garage_list"
    }
}

struct GarageDetailItem: Codable {
    let id: Int
    let type: String
    let category: String
}


// MARK: 운행일보 Model
struct DispatchNoteDetail: Codable {
    let result: String
    let data: DispatchNoteDetailItem
}

struct DispatchNoteDetailItem: Codable {
    let date: String
    let member: String
    let regularlyId: Int?
    let orderId: Int?
    let departureFigure: String
    let arrivalFigure: String
    let passengerNumber: String
    let specialNotes: String
    let departureTime: String
    let arrivalTime: String
    let creator: Int
    let connect: DispatchNoteDetailSubItem
    let submitCheck: Bool
    
    enum CodingKeys: String, CodingKey {
        case date
        case member
        case regularlyId = "regularly_connect_id"
        case orderId = "order_connect_id"
        case departureFigure = "departure_km"
        case arrivalFigure = "arrival_km"
        case passengerNumber = "passenger_num"
        case specialNotes = "special_notes"
        case creator
        case connect
        case submitCheck = "submit_check"
        case departureTime = "departure_date"
        case arrivalTime = "arrival_date"
    }
}


struct DispatchNoteDetailSubItem: Codable {
    let bus: String
    let departure: String
    let arrival: String
    
    enum CodingKeys: String, CodingKey {
        case bus
        case departure
        case arrival
    }
}

// MARK: - 팀원 배차 Model
struct TeamSchedule: Codable {
    let result: String
    let data: [TeamScheduleItem]
}

struct TeamScheduleItem: Codable {
    let member: String
    let memberId: Int
    let currentCount: Int
    let totalCount: Int
    let bus: String
    let route: String
    let departureTime: String
    let wakeCheck: String
    let boardingCheck: String
    let drivingCheck: String
    
    func isProblem() -> Bool {
        if self.wakeCheck == "false" || self.boardingCheck == "false" || self.drivingCheck == "false" {
            return true
        }
        
        return false
    }
    
    enum CodingKeys: String, CodingKey {
        case member
        case memberId = "member_id"
        case currentCount = "current_count"
        case totalCount = "total_count"
        case bus
        case route
        case departureTime = "departure_time"
        case wakeCheck = "check1"
        case boardingCheck = "check2"
        case drivingCheck = "check3"
    }
}

// MARK: - 팀원 배차 상세 정보 Model
struct TeamScheduleDetail: Codable {
    let result: String
    let data: TeamScheduleDetailItem
}

struct TeamScheduleDetailItem: Codable {
    let phone: String
    let alcoholTest: String
    let regularly: [TeamScheduleDispatchItem]
    let order: [TeamScheduleDispatchItem]
    
    func combineData() -> [TeamScheduleDispatchItem] {
        return self.regularly + self.order
        
    }
    
    enum CodingKeys: String, CodingKey {
        case phone
        case alcoholTest = "alcohol_test"
        case regularly
        case order
    }
}

struct TeamScheduleDispatchItem: Codable {
    let id: Int
    let bus: String // 버스 번호
    let route: String // 노선명
    let departureTime: String // 출발 시간
    let arrivalName: String // 도착지
    let note: String // 비고
    
    enum CodingKeys: String, CodingKey {
        case id
        case bus
        case route
        case departureTime = "departure_time"
        case arrivalName = "" // FIXME: 도착지 Key 추가
        case note
    }
}
