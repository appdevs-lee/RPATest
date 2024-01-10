//
//  DispatchDrivingDoneTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/10/24.
//

import UIKit

final class DispatchDrivingDoneTableViewCell: UITableViewCell {
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("운행 종료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 22
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
extension DispatchDrivingDoneTableViewCell {
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
        self.addSubview(self.doneButton)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.doneButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.doneButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.doneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchDrivingDoneTableViewCell {
    func setCell() {
        
    }
}

