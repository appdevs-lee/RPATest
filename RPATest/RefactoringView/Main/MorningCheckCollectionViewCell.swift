//
//  MorningCheckCollectionViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/10/24.
//

import UIKit

final class MorningCheckCollectionViewCell: UICollectionViewCell {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitleColor(.useRGB(red: 49, green: 49, blue: 49), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.useRGB(red: 204, green: 204, blue: 204).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
extension MorningCheckCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.addSubview(self.button)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // button
        NSLayoutConstraint.activate([
            self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.button.topAnchor.constraint(equalTo: self.topAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension MorningCheckCollectionViewCell {
    func setCell() {
        
    }
}

