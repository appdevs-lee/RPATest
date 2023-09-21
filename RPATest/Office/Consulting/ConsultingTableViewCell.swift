//
//  ConsultingTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

final class ConsultingTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
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
extension ConsultingTableViewCell {
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
        self.addSubview(self.titleLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.timeLabel)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
        
        // statusLabel
        NSLayoutConstraint.activate([
            self.statusLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 4),
            self.statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.timeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4)
        ])
        
    }
}

// MARK: - Extension for methods added
extension ConsultingTableViewCell {
    func setCell(consulting: ConsultingItem) {
        self.titleLabel.text = consulting.content
        self.statusLabel.text = consulting.status
        self.timeLabel.text = consulting.date
    }
}

