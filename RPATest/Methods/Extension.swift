//
//  Extension.swift
//  RPATest
//
//  Created by Awesomepia on 1/10/24.
//

import Foundation

extension String {
    func sliceString() -> String {
        let startIndex = self.index(self.startIndex, offsetBy: 11)// 사용자지정 시작인덱스
        let endIndex = self.index(self.startIndex, offsetBy: 16)// 사용자지정 끝인덱스
        
        return String(self[startIndex..<endIndex])
    }
}
