//
//  ProfileCollectionViewCell.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/04.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {
    
    lazy var menuStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.menuImageView, self.menuLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
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
extension ProfileCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        self.addSubview(self.menuStackView)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // menuStackView
        NSLayoutConstraint.activate([
            self.menuStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.menuStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        // menuImageView
        NSLayoutConstraint.activate([
            self.menuImageView.heightAnchor.constraint(equalToConstant: 40),
            self.menuImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
        
    }
}

// MARK: - Extension for methods added
extension ProfileCollectionViewCell {
    func setCell(imageString: String, menuString: String) {
        self.menuImageView.image = UIImage(named: "\(imageString)")
        self.menuLabel.text = "\(menuString)"
    }
}
