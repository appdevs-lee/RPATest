//
//  AddingContentCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

final class AddingContentCell: UICollectionViewCell {
    lazy var contentBaseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var movieIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "moviePlayIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var deleteButton: IndexPathButton = {
        let button = IndexPathButton()
        button.setImage(UIImage(named: "deleteImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
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

// MARK: Extension for essential methods
extension AddingContentCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.contentBaseView
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.contentImageView,
            self.movieIconImageView,
            self.deleteButton
        ], to: self.contentBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.safeAreaLayoutGuide
        
        // contentBaseView
        NSLayoutConstraint.activate([
            self.contentBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.contentBaseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.contentBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.contentBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        // contentImageView
        NSLayoutConstraint.activate([
            self.contentImageView.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor),
            self.contentImageView.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor),
            self.contentImageView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor),
            self.contentImageView.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor)
        ])
        
        // movieIconImageView
        NSLayoutConstraint.activate([
            self.movieIconImageView.centerYAnchor.constraint(equalTo: self.contentBaseView.centerYAnchor),
            self.movieIconImageView.heightAnchor.constraint(equalToConstant: 25),
            self.movieIconImageView.centerXAnchor.constraint(equalTo: self.contentBaseView.centerXAnchor),
            self.movieIconImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        // deleteButton
        NSLayoutConstraint.activate([
            self.deleteButton.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor, constant: 8),
            self.deleteButton.heightAnchor.constraint(equalToConstant: 12),
            self.deleteButton.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor, constant: -8),
            self.deleteButton.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
}

// MARK: Extension for methods added
extension AddingContentCell {
    func setCell(_ imageData: Data, isMovie: Bool, indexPath: IndexPath) {
        self.deleteButton.indexPath = indexPath
        self.contentImageView.image = UIImage(data: imageData)
        self.movieIconImageView.isHidden = !isMovie
        
    }
}
