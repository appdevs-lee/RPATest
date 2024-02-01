//
//  ProfileMyInfoViewPagerCollectionViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2/1/24.
//

import UIKit

final class ProfileMyInfoViewPagerCollectionViewCell: UICollectionViewCell {
    
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Bold)
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
    
    lazy var newView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 255, green: 106, blue: 106)
        view.layer.cornerRadius = 2.5
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
extension ProfileMyInfoViewPagerCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
        
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.addSubview(self.backGroundView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.indicatorView)
        self.addSubview(self.newView)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // backGroundView
        NSLayoutConstraint.activate([
            self.backGroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backGroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backGroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backGroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.backGroundView.centerYAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.backGroundView.centerXAnchor)
        ])
        
        // indicatorView
        NSLayoutConstraint.activate([
            self.indicatorView.heightAnchor.constraint(equalToConstant: 1),
            self.indicatorView.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor),
            self.indicatorView.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor),
            self.indicatorView.bottomAnchor.constraint(equalTo: self.backGroundView.bottomAnchor)
        ])
        
        // newView
        NSLayoutConstraint.activate([
            self.newView.widthAnchor.constraint(equalToConstant: 5),
            self.newView.heightAnchor.constraint(equalToConstant: 5),
            self.newView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 4),
            self.newView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension ProfileMyInfoViewPagerCollectionViewCell {
    func setCell(title: String) {
        self.titleLabel.text = title
        
    }
}
