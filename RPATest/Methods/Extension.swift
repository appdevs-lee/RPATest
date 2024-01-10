//
//  Extension.swift
//  RPATest
//
//  Created by Awesomepia on 1/10/24.
//

import Foundation
import UIKit

extension String {
    func sliceString() -> String {
        let startIndex = self.index(self.startIndex, offsetBy: 11)// 사용자지정 시작인덱스
        let endIndex = self.index(self.startIndex, offsetBy: 16)// 사용자지정 끝인덱스
        
        return String(self[startIndex..<endIndex])
    }
}

extension UIView {
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
