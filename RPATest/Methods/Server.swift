//
//  Server.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/08.
//

import Foundation

enum ServerURL: String {
    case DEV = "http://34.121.50.23:8000"
    case NH = "http://34.125.128.74:5000/"
    case PROD = "http://api.kingbuserp.link"
}

class Server {
    static let shared = Server()
    
    var currentURL: String?
    
    private init() {
        self.currentURL = UserDefaults.standard.string(forKey: "currentURL")
    }
}
