//
//  ConsultingModel.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import Foundation
import Alamofire

final class ConsultingModel {
    private(set) var loadConsultingListRequest: DataRequest?
    
    func loadConsultingListRequest(page: Int, success: ((ConsultingList) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = Server.server.URL + "/complaint/consulting"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "page": page
        ]
        
        self.loadConsultingListRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadConsultingListRequest?.responseData { response in
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
                
                if let decodedData = try? JSONDecoder().decode(ConsultingList.self, from: data) {
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

struct Consulting: Codable {
    let success: String
    let data: ConsultingItem
}

struct ConsultingItem: Codable {
    let id: Int
    let content: String
    let date: String
    let status: String
}

struct ConsultingList: Codable {
    let count: Int
    let next: String?
    let results: [ConsultingItem]
}
