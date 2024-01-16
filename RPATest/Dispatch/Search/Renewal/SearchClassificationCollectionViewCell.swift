//
//  SearchClassificationCollectionViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/16/24.
//

import UIKit

final class SearchClassificationCollectionViewCell: UICollectionViewCell {
    
    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Check_No")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
extension SearchClassificationCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.checkImageView,
            self.titleLabel
        ], to: self)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // checkImageView
        NSLayoutConstraint.activate([
            self.checkImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.checkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.checkImageView.widthAnchor.constraint(equalToConstant: 16),
            self.checkImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.checkImageView.trailingAnchor, constant: 4),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Extension for methods added
extension SearchClassificationCollectionViewCell {
    func setCell(title: String) {
        self.titleLabel.text = title
        
    }
}

