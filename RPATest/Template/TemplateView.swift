//
//  TemplateView.swift
//  RPATest
//
//  Created by Awesomepia on 11/22/23.
//

import UIKit

class TemplateView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TemplateView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            
        ], to: self)
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Extension for methods added
extension TemplateView {
    
}

// MARK: - Extension for selector added
extension TemplateView {
    
}
