//
//  CommonModel.swift
//  RPATest
//
//  Created by 이주성 on 2023/07/22.
//

import Foundation
import UserNotifications
import Photos
import Alamofire

struct ServerInspection: Codable {
    let result: String
    let data: String
}

struct DefaultResponse: Codable {
    let result: String
}

enum CommentType: String {
    case inspector
    case consulting
}

final class CommonModel {
    private(set) var writeRequest: DataRequest?
    private(set) var serverInspectionRequest: DataRequest?
    
    func writeRequest(type: CommentType, content: String, vehicleId: Int?, imageData: [Data]?, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        var subApiString = ""
        switch type {
        case .consulting:
            subApiString = "/complaint/consulting"
        case .inspector:
            subApiString = "/complaint/inspection"
        }
        
        let url = (Server.shared.currentURL ?? "") + subApiString
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.writeRequest = AF.upload(multipartFormData: { multipartFormData in
            
            if let imageData = imageData {
                for index in 0..<imageData.count {
                    multipartFormData.append(imageData[index], withName: "files", fileName: "image_\(index)_img.jpg", mimeType: "image/jpeg")
                }
            }
            
            multipartFormData.append(content.data(using: .utf8)!, withName: "content")
            if vehicleId != nil {
                multipartFormData.append("\(vehicleId!)".data(using: .utf8)!, withName: "vehicle_id")
            }
            
        }, to: url, headers: headers)
        .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        })
        
        self.writeRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("writeRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("writeRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Temporary.self, from: data) {
                    if decodedData.success {
                        success?()
                        
                    } else {
                        // false
                        print("checkPatchDispatchRequest failure: \(decodedData.success)")
                        failure?("\(decodedData.success)")
                        
                    }
                    
                } else { // improper structure
                    print("writeRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("writeRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func serverInspectionRequest(success: ((String) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/maintenance"
        
        let headers: HTTPHeaders = [
            "access": "application/json"
        ]
        
        self.serverInspectionRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.serverInspectionRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("serverInspectionRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("serverInspectionRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(ServerInspection.self, from: data) {
                            print("serverInspectionRequest succeeded")
                            success?(decodedData.data)
                                                
                        } else {
                            print("serverInspectionRequest failure: API 성공, Parsing 실패")
                            print(decodedData)
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        print("serverInspectionRequest failure: \(decodedData.result)")
                        failure?(decodedData.result)
                    }
                    
                } else { // improper structure
                    print("serverInspectionRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("serverInspectionRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func getCompanyCheck() -> String {
        guard let companyCheck = UserDefaults.standard.string(forKey: "CompanyCheck") else { return "" }
        return companyCheck
    }
    
    func getPermissionCheck() -> String {
        guard let permissionCheck = UserDefaults.standard.string(forKey: "CheckPermission") else { return "" }
        return permissionCheck
    }
    
    func registerForPushNotifications(completion: (() -> ())?) {
        // 1 - UNUserNotificationCenter는 푸시 알림을 포함하여 앱의 모든 알림 관련 활동을 처리합니다.
        UNUserNotificationCenter.current()
        // 2 -알림을 표시하기 위한 승인을 요청합니다. 전달된 옵션은 앱에서 사용하려는 알림 유형을 나타냅니다. 여기에서 알림(alert), 소리(sound) 및 배지(badge)를 요청합니다.
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                // 3 - 완료 핸들러는 인증이 성공했는지 여부를 나타내는 Bool을 수신합니다. 인증 결과를 표시합니다.
                print("Permission granted: \(granted)")
                completion?()
            }
    }
    
    func checkAlbumPermission(completionHandler: @escaping (String) -> Void){
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status{
            case .limited:
                completionHandler("일부 허용")
                print("Album: 일부 허용")
            case .authorized:
                completionHandler("허용")
                print("Album: 권한 허용")
            case .denied:
                completionHandler("거부")
                print("Album: 권한 거부")
            case .restricted, .notDetermined:
                completionHandler("선택하지 않음")
                print("Album: 선택하지 않음")
            default:
                completionHandler("default")
            }
        }
    }
}

extension Int {
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String? {
        let numberFommater: NumberFormatter = NumberFormatter()
        numberFommater.numberStyle = numberStyle
        return numberFommater.string(for: self)
    }
}
