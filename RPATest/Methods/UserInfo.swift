//
//  UserInfo.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/04.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()

    var id: String?
    var password: String?
    var access: String?
    var name: String?
    var fcmToken: String?
    
    private init() {
        self.name = UserDefaults.standard.string(forKey: "name")
    }
}

func getRefreshToken() -> String {
    guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return "" }
    return refreshToken
}
