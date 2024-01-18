//
//  AccidentCallListTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/18/24.
//

import UIKit

final class AccidentCallListTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 24, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var partLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
extension AccidentCallListTableViewCell {
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
            self.baseView,
            self.nameLabel,
            self.partLabel,
            self.callButton
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.baseView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor)
        ])
        
        // partLabel
        NSLayoutConstraint.activate([
            self.partLabel.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 8),
            self.partLabel.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor)
        ])
        
        // callButton
        NSLayoutConstraint.activate([
            self.callButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.callButton.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.callButton.heightAnchor.constraint(equalToConstant: 36),
            self.callButton.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
}

// MARK: - Extension for methods added
extension AccidentCallListTableViewCell {
    func setCell(data: EmergencyPhoneBook, index: Int) {
        self.callButton.tag = index
        
        self.nameLabel.text = data.name
        self.partLabel.text = data.part
    }
}

