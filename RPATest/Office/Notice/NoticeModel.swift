//
//  NoticeModel.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import Foundation
import Alamofire

final class NoticeModel {
    private(set) var loadNoticeListRequest: DataRequest?
    private(set) var loadNoticeDetailRequest: DataRequest?
    
    func loadNoticeListRequest(page: Int, success: ((Notice) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/notice"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        let parameters: Parameters = [
            "page": page
        ]
        
        self.loadNoticeListRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadNoticeListRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadNoticeListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadNoticeListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Notice.self, from: data) {
                    success?(decodedData)
                    
                } else { // improper structure
                    print("loadNoticeListRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadNoticeListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadNoticeDetailRequest(id: Int, success: ((NoticeDetail) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = (Server.shared.currentURL ?? "") + "/notice/\(id)"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": UserInfo.shared.access!
        ]
        
        self.loadNoticeDetailRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadNoticeDetailRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadNoticeDetailRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadNoticeDetailRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(NoticeDetail.self, from: data) {
                    success?(decodedData)
                    
                } else { // improper structure
                    print("loadNoticeDetailRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loadNoticeDetailRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func saveReadStatus(noticeId: Int) {
        if var status = UserDefaults.standard.dictionary(forKey: "saveReadStatus") as? [String: Bool] {
            status.updateValue(true, forKey: "\(noticeId)")
            UserDefaults.standard.set(status, forKey: "saveReadStatus")
            
        } else {
            UserDefaults.standard.set(["\(noticeId)": true], forKey: "saveReadStatus")
        }
    }
    
    func getReadStatus(noticeId: Int) -> Bool? {
        if let status = UserDefaults.standard.dictionary(forKey: "saveReadStatus") as? [String: Bool], let readStatus = status["\(noticeId)"], readStatus {
            return readStatus
        }
        
        return nil
    }
}

struct Notice: Codable {
    let count: Int
    let next: String?
    let results: [NoticeItem]
}

struct NoticeItem: Codable {
    let id: Int
    let title: String
    let viewCount: Int
    let pubDate: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case viewCount = "view_cnt"
        case pubDate = "pub_date"
        case creator
    }
}

struct NoticeDetail: Codable {
    let id: Int
    let noticeFile: [NoticeFileItem]
    let title: String
    let content: String
    let kinds: String
    let viewCount: Int
    let pubDate: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case noticeFile = "notice_file"
        case title
        case content
        case kinds
        case viewCount = "view_cnt"
        case pubDate = "pub_date"
        case creator
    }
}

struct NoticeFileItem: Codable {
    let file: String
    let filename: String
}
