//
//  CommonModel.swift
//  RPATest
//
//  Created by 이주성 on 2023/07/22.
//

import Foundation

struct DefaultResponse: Codable {
    let result: String
}

final class CommonModel {
    func getCompanyCheck() -> String {
        guard let companyCheck = UserDefaults.standard.string(forKey: "CompanyCheck") else { return "" }
        return companyCheck
    }
}

extension Int {
    func formatterStyle(_ numberStyle: NumberFormatter.Style) -> String? {
        let numberFommater: NumberFormatter = NumberFormatter()
        numberFommater.numberStyle = numberStyle
        return numberFommater.string(for: self)
    }
}
