//
//  ReferenceValues.swift
//  RPATest
//
//  Created by 이주성 on 2023/07/29.
//

import Foundation
import UIKit

struct ReferenceValues {
    static weak var keyWindow: UIWindow!
    
    static weak var firstVC: LoginViewController?
    
    static var isDoingAccidentResponse: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isDoingAccidentResponse")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "isDoingAccidentResponse")
        }
    }
    
    static var currentCompany: String {
        get {
            return UserDefaults.standard.string(forKey: "CompanyName") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "CompanyName")
        }
    }
    
    static var peopleCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "PeopleCount")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "PeopleCount")
        }
    }
    
    static var drivingDone: [Int] {
        get {
            return UserDefaults.standard.array(forKey: "DrivingDone") as? [Int] ?? []
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "DrivingDone")
        }
    }
    
    static var driveType: DriveCheckType {
        get {
            let decoder: JSONDecoder = JSONDecoder()
            let data = UserDefaults.standard.object(forKey: "DriveType") as! Data
            let driveType = try? decoder.decode(DriveCheckType.self, from: data)
            
            return driveType ?? .wake
            
        }
        
        set {
            let encoder: JSONEncoder = JSONEncoder()
            if let driveType = try? encoder.encode(newValue) {
                UserDefaults.standard.set(driveType, forKey: "DriveType")
                
            }
            
        }
    }
    
    static var isCheckPermission: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isCheckPermission")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "isCheckPermission")
        }
    }
    
    static var isLoginCheck: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLoginCheck")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoginCheck")
        }
    }
    
    static var refreshToken: String {
        get {
            return UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "refreshToken")
        }
    }
    
    static var fcmToken: String {
        get {
            return UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "fcmToken")
        }
    }
    
    static var role: String {
        get {
            return UserDefaults.standard.string(forKey: "role") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "role")
        }
    }
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: "name") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
    
}

// MARK: - Extension of referenceValues
extension ReferenceValues {
    struct Size {
        struct Device {
            static let width: CGFloat = ReferenceValues.keyWindow.screen.bounds.width
            static let height: CGFloat = ReferenceValues.keyWindow.screen.bounds.height
        }
        
        struct SafeAreaInsets {
            static let top: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.top
            static let bottom: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.bottom
            static let left: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.left
            static let right: CGFloat = ReferenceValues.keyWindow.safeAreaInsets.right
        }
        
        struct Ratio {
            static let bannerHeightRatio: CGFloat = 100/343
        }
    }
    
    struct Velocity {
        static let hideBottomView: CGFloat = 650
    }
    
    struct TextCount {
        struct Comment {
            static let comment: Int = 150
            static let subComment: Int = 150
        }
    }
}
