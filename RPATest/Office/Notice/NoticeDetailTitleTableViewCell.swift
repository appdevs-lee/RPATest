//
//  NoticeDetailTitleTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

class NoticeDetailTitleTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .useRGB(red: 97, green: 97, blue: 97, alpha: 0.85)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .useRGB(red: 158, green: 158, blue: 158, alpha: 0.85)
        label.font = .useFont(ofSize: 13, weight: .Medium)
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
extension NoticeDetailTitleTableViewCell {
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
        self.addSubview(self.timeLabel)
    }
    
    // Set layouts
    func setLayouts() {
//        let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 18),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.timeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.timeLabel.heightAnchor.constraint(equalToConstant: 13),
            self.timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}

// MARK: - Extension for methods added
extension NoticeDetailTitleTableViewCell {
    func setCell(notice: NoticeDetail) {
        self.titleLabel.text = notice.title
        self.timeLabel.text = SupportingMethods.shared.calculatePassedTime(SupportingMethods.shared.makeDateFormatter("yyyy-MM-dd HH:mm").date(from: notice.pubDate))
    }
}
