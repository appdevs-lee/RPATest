//
//  Server.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/08.
//

import Foundation

enum URL: String {
    case DEV = "http://34.121.50.23:8000"
    case PROD = "http://api.kingbuserp.link"
}

struct ReferenceValues {
    static let shared = ReferenceValues()
    
    var currentURL: URL?
    
    private init() {}
}
