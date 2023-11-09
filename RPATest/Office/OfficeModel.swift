//
//  OfficeModel.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import Foundation

final class OfficeModel {
    
}

class DispatchScheduleItem {
    let name: String
    let vehicleNumber: String
    let separateRole: String
    let phoneNumber: String
    let time: String
    let path: String
    let checkVehicleStatusPlace: String
    let gate: String
    let note: String
    var check: Bool
    // 셔틀?
    
    init(name: String, vehicleNumber: String, separateRole: String, phoneNumber: String, time: String, path: String, checkVehicleStatusPlace: String, gate: String, note: String, check: Bool) {
        self.name = name
        self.vehicleNumber = vehicleNumber
        self.separateRole = separateRole
        self.phoneNumber = phoneNumber
        self.time = time
        self.path = path
        self.checkVehicleStatusPlace = checkVehicleStatusPlace
        self.gate = gate
        self.note = note
        self.check = check
    }
}
