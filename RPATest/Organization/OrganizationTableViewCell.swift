//
//  OrganizationTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/07.
//

import UIKit

class OrganizationTableViewCell: UITableViewCell {
    
    lazy var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.positionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
extension OrganizationTableViewCell {
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
        self.addSubview(self.profileView)
        self.profileView.addSubview(self.profileLabel)
        
        self.addSubview(self.profileStackView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // profileView
        NSLayoutConstraint.activate([
            self.profileView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.profileView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.profileView.widthAnchor.constraint(equalToConstant: 50),
            self.profileView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // profileLabel
        NSLayoutConstraint.activate([
            self.profileLabel.centerYAnchor.constraint(equalTo: self.profileView.centerYAnchor),
            self.profileLabel.centerXAnchor.constraint(equalTo: self.profileView.centerXAnchor)
        ])
        
        // profileStackView
        NSLayoutConstraint.activate([
            self.profileStackView.leadingAnchor.constraint(equalTo: self.profileView.trailingAnchor, constant: 20),
            self.profileStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.profileStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.profileStackView.centerYAnchor.constraint(equalTo: self.profileView.centerYAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension OrganizationTableViewCell {
    func setCell(nameData: String, positionData: String) {
        self.nameLabel.text = nameData
        self.positionLabel.text = positionData
        
        let firstWordinName = String((nameData.first)!)
        self.profileLabel.text = firstWordinName
    }
}

