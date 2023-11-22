//
//  ViewPagerCollectionViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 11/22/23.
//

import UIKit

final class ViewPagerCollectionViewCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
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
extension ViewPagerCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.indicatorView)
        self.addSubview(self.newView)
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
            self.indicatorView.heightAnchor.constraint(equalToConstant: 4),
            self.indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
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
extension ViewPagerCollectionViewCell {
    func setCell(title: String) {
        self.titleLabel.text = title
        
    }
}
