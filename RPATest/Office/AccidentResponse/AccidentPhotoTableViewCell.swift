//
//  AccidentPhotoTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/17/24.
//

import UIKit
import PhotosUI

final class AccidentPhotoTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "plusImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.itemSize = CGSize(width: 83, height: 83)
        //flowLayout.minimumLineSpacing = 4
        //flowLayout.minimumInteritemSpacing = 0
        //flowLayout.headerReferenceSize = CGSize(width: 4, height: 83)
        //flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(AddingContentCell.self, forCellWithReuseIdentifier: "AddingContentCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var selectedImageIdentifiers: [String] = []
    var pickedImageResults: [String: PHPickerResult] = [:]
    var imageData: [String: Data] = [:]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setCellFoundation()
        self.initializeViews()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// MARK: Extension for essential methods
extension AccidentPhotoTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
    }
    
    // Initialize views
    func initializeViews() {
        
    }
    
    // Set gestures
    func setGestures() {
        
    }
    
    // Set notificationCenters
    func setNotificationCenters() {
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.plusButton,
            self.collectionView
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
        
        // plusButton
        NSLayoutConstraint.activate([
            self.plusButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.plusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.plusButton.heightAnchor.constraint(equalToConstant: 83),
            self.plusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.plusButton.widthAnchor.constraint(equalToConstant: 83)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.plusButton.topAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 83),
            self.collectionView.leadingAnchor.constraint(equalTo: self.plusButton.trailingAnchor, constant: 4),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension AccidentPhotoTableViewCell {
    func setCell(photo: PhotoData, index: Int) {
        self.plusButton.tag = index
        
        self.titleLabel.text = photo.title
        self.selectedImageIdentifiers = photo.selectedImageIdentifiers
        self.pickedImageResults = photo.pickedImageResults
        self.imageData = photo.imageData
        
        self.collectionView.reloadData()
    }
}

// MARK: - Extension for selector added
extension AccidentPhotoTableViewCell {
    @objc func deleteButton(_ sender: IndexPathButton) {
//        self.imageData.removeValue(forKey: self.selectedImageIdentifiers[sender.indexPath.item])
//        self.selectedImageIdentifiers.remove(at: sender.indexPath.item)
        
        self.collectionView.reloadData()
    }
}

// MARK: - Extension for UICollectionViewDelegate, UICollectionViewDataSource
extension AccidentPhotoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.selectedImageIdentifiers.isEmpty ? .zero : CGSize(width: 4, height: 83)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedImageIdentifiers.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 83, height: 83)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddingContentCell", for: indexPath) as! AddingContentCell
        
        cell.setCell(self.imageData[self.selectedImageIdentifiers[indexPath.item]] ?? Data(), isMovie: false, indexPath: indexPath)
        cell.deleteButton.addTarget(self, action: #selector(deleteButton(_:)), for: .touchUpInside)
        
        return cell
    }
}
