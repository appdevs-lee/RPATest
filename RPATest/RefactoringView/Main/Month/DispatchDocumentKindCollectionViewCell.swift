//
//  DispatchDocumentKindCollectionViewCell.swift
//  RPATest
//
//  Created by 이주성 on 10/13/24.
//

import UIKit

final class DispatchDocumentKindCollectionViewCell: UICollectionViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .useRGB(red: 151, green: 151, blue: 151)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 35, green: 35, blue: 35)
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
extension DispatchDocumentKindCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.categoryLabel,
            self.bottomView,
        ], to: self.baseView)
        
    }
    
    func setLayouts() {
//        let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // categoryLabel
        NSLayoutConstraint.activate([
            self.categoryLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10),
            self.categoryLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -10),
            self.categoryLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 10),
            self.categoryLabel.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -10),
        ])
        
        // bottomView
        NSLayoutConstraint.activate([
            self.bottomView.leadingAnchor.constraint(equalTo: self.categoryLabel.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.categoryLabel.trailingAnchor),
            self.bottomView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.bottomView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchDocumentKindCollectionViewCell {
    func setCell(category: String) {
        self.categoryLabel.text = category
    }
}

