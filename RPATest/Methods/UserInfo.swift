//
//  UserInfo.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/04.
//

import Foundation

class UserInfo {
    static let shared = UserInfo()

    var id: Int?
    var password: String?
    var access: String?
    var name: String?
    var role: String?
    var fcmToken: String?
    var signStatus: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "salarySignStatus")
            
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "salarySignStatus")
        }
    }
    
    private init() {
        self.name = UserDefaults.standard.string(forKey: "name")
    }
}

func getRefreshToken() -> String {
    guard let refreshToken = UserDefaults.standard.string(forKey: "refreshToken") else { return "" }
    return refreshToken
}
