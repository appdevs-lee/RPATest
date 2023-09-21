//
//  NoticeDetailTextTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

class NoticeDetailTextTableViewCell: UITableViewCell {
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = .useFont(ofSize: 16, weight: .Medium)
        textView.textColor = .useRGB(red: 66, green: 66, blue: 66)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
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
extension NoticeDetailTextTableViewCell {
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
        self.addSubview(self.textView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // textView
        NSLayoutConstraint.activate([
            self.textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - Extension for methods added
extension NoticeDetailTextTableViewCell {
    func setCell(notice: NoticeDetail) {
        self.textView.text = notice.content
    }
}
