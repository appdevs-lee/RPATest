//
//  OfficeCollectionViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

final class OfficeCollectionViewCell: UICollectionViewCell {
    
    lazy var menuStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.menuImageView, self.menuLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var menuImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
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
extension OfficeCollectionViewCell: EssentialCellHeaderMethods {
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
            self.menuImageView.heightAnchor.constraint(equalToConstant: 60),
            self.menuImageView.widthAnchor.constraint(equalToConstant: 60),
        ])
        
    }
}

// MARK: - Extension for methods added
extension OfficeCollectionViewCell {
    func setCell(office: Office) {
        self.menuImageView.image = UIImage(named: "\(office.rawValue)")
        self.menuLabel.text = "\(office.labelName)"
    }
}
