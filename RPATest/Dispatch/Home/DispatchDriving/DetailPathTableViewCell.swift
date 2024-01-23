//
//  DetailPathTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/10/24.
//

import UIKit

final class DetailPathTableViewCell: UITableViewCell {
    
    lazy var pathLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var countTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승인원"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.minusButton, self.countLabel, self.plusButton])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승인원: 0명"
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
extension DetailPathTableViewCell {
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
            self.pathLabel,
            self.countTitleLabel,
            self.buttonStackView
//            self.minusButton,
//            self.countLabel,
//            self.plusButton
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // pathLabel
        NSLayoutConstraint.activate([
            self.pathLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.pathLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        // countTitleLabel
        NSLayoutConstraint.activate([
            self.countTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.countTitleLabel.centerXAnchor.constraint(equalTo: self.countLabel.centerXAnchor)
        ])
        
        // buttonStackView
        NSLayoutConstraint.activate([
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.pathLabel.trailingAnchor, constant: 4),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.buttonStackView.topAnchor.constraint(equalTo: self.countTitleLabel.bottomAnchor, constant: 4),
            self.buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // minusButton
        NSLayoutConstraint.activate([
//            self.minusButton.leadingAnchor.constraint(equalTo: self.pathLabel.trailingAnchor, constant: 4),
//            self.minusButton.centerYAnchor.constraint(equalTo: self.countLabel.centerYAnchor),
            self.minusButton.widthAnchor.constraint(equalToConstant: 40),
            self.minusButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // countLabel
        NSLayoutConstraint.activate([
//            self.countLabel.topAnchor.constraint(equalTo: self.countTitleLabel.bottomAnchor, constant: 4),
//            self.countLabel.leadingAnchor.constraint(equalTo: self.minusButton.trailingAnchor, constant: 10),
//            self.countLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.countLabel.widthAnchor.constraint(equalToConstant: 80),
            self.countLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        // plusButton
        NSLayoutConstraint.activate([
//            self.plusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            self.plusButton.centerYAnchor.constraint(equalTo: self.countLabel.centerYAnchor),
            self.plusButton.widthAnchor.constraint(equalToConstant: 40),
            self.plusButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - Extension for methods added
extension DetailPathTableViewCell {
    func setCell(station: Station, index: Int) {
        self.minusButton.tag = index
        self.plusButton.tag = index
        
        self.pathLabel.text = station.pathName
        self.countLabel.text = "탑승인원: \(station.count)명"
        
    }
}

