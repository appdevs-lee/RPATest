//
//  DispatchCategoryTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/19.
//

import UIKit

final class DispatchCategoryTableViewCell: UITableViewCell {
    
    lazy var pathGroupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var pathKnowRatioLabel: UILabel = {
        let label = UILabel()
        label.text = "1/44"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .red
        progressView.trackTintColor = .lightGray
        progressView.layer.cornerRadius = 2
        progressView.layer.masksToBounds = true
        progressView.progress = 0.3
        
        progressView.progressViewStyle = .bar
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
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
extension DispatchCategoryTableViewCell {
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
        self.addSubview(self.pathGroupLabel)
//        self.addSubview(self.progressView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // pathGroupLabel
        NSLayoutConstraint.activate([
            self.pathGroupLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.pathGroupLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.pathGroupLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        // pathGroupLabel
//        NSLayoutConstraint.activate([
//            self.pathGroupLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            self.pathGroupLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
//            self.pathGroupLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
//            self.pathGroupLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
//        ])
        
        // pathKnowRatioLabel
//        NSLayoutConstraint.activate([
//            self.progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
//            self.progressView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            self.progressView.heightAnchor.constraint(equalToConstant: 4),
//            self.progressView.widthAnchor.constraint(equalToConstant: 50)
//        ])
    }
}

// MARK: - Extension for methods added
extension DispatchCategoryTableViewCell {
    func setCell(group: DispatchSearchItemGroupList) {
        self.pathGroupLabel.text = group.name
    }
}
