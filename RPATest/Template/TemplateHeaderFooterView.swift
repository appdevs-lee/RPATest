//
//  TemplateHeaderFooterView.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/02.
//

import UIKit

final class TemplateHeaderFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extension for essential methods
extension TemplateHeaderFooterView: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.layer.backgroundColor = UIColor.white.cgColor
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        //
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Extension for methods added
extension TemplateHeaderFooterView {
    func setHeaderView() {
        
    }
}
