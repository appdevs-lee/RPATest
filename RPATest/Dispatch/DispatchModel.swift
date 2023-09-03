//
//  DispatchModel.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/02.
//

import Foundation

final class DispatchModel {
    
}

struct DispatchMonthly: Codable {
    let result: String
    let data: DispatchMonthlyItem
}

struct DispatchMonthlyItem: Codable {
    let order: [Int]
    let regularly_c: [Int]
    let regularly_t: [Int]
}

struct DispatchDaily: Codable {
    let result: String
    let data: DispatchDailyItem
}

struct DispatchDailyItem: Codable {
    let regularly: [Int]
    let order: [Int]
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
