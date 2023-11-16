//
//  OrganizationViewPagerCollectionViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 11/16/23.
//

import UIKit

final class OrganizationViewPagerCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
extension OrganizationViewPagerCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.indicatorView)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // indicatorView
        NSLayoutConstraint.activate([
            self.indicatorView.heightAnchor.constraint(equalToConstant: 2),
            self.indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension OrganizationViewPagerCollectionViewCell {
    func setCell(title: String) {
        self.titleLabel.text = title
        
    }
}
