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

extension UITextField {
    func setBorder() {
        self.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8
        self.addLeftPadding()
    }
    
    func addLeftPadding() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = view
        self.leftViewMode = ViewMode.always
    }
}
