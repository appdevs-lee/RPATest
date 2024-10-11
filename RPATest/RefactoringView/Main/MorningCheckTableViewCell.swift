//
//  MorningCheckTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/10/24.
//

import UIKit

final class MorningCheckTableViewCell: UITableViewCell {
    
    lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .SemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (ReferenceValues.Size.Device.width - 37) / 2, height: 44)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(MorningCheckCollectionViewCell.self, forCellWithReuseIdentifier: "MorningCheckCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var question: Question?
    var selectedIndex: Int = 0
    
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
extension MorningCheckTableViewCell {
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
            self.questionLabel,
            self.collectionView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // questionLabel
        NSLayoutConstraint.activate([
            self.questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.collectionView.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 10),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.collectionView.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

// MARK: - Extension for methods added
extension MorningCheckTableViewCell {
    func setCell(question: Question) {
        self.question = question
        self.questionLabel.text = question.question
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
        
    }
}

// MARK: - Extension for methods added
extension MorningCheckTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MorningCheckCollectionViewCell", for: indexPath) as! MorningCheckCollectionViewCell
        
        cell.setCell()
        if indexPath.row == 0 {
            cell.button.setTitle(self.question?.notGoodButton, for: .normal)
            
        } else {
            cell.button.setTitle(self.question?.goodButton, for: .normal)
            
        }
        
        if self.question?.selectedIndex == indexPath.row {
            cell.button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
            cell.button.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
            
        } else {
            cell.button.setTitleColor(.useRGB(red: 49, green: 49, blue: 49), for: .normal)
            cell.button.layer.borderColor = UIColor.useRGB(red: 204, green: 204, blue: 204).cgColor
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.question?.selectedIndex = indexPath.row
        
        self.collectionView.reloadData()
    }
}

