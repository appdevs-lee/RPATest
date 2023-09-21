//
//  NoticeTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

final class NoticeTableViewCell: UITableViewCell {
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.overStackView, self.titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var overStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noticeImageView, self.timeLabel, self.newImageView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noticeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoticeListIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var newImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoticeNewIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let noticeModel = NoticeModel()
    
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
extension NoticeTableViewCell {
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
        self.addSubview(self.titleStackView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleStackView
        NSLayoutConstraint.activate([
            self.titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.titleStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
        // noticeImageView
        NSLayoutConstraint.activate([
            self.noticeImageView.widthAnchor.constraint(equalToConstant: 50),
            self.noticeImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // newImageView
        NSLayoutConstraint.activate([
            self.newImageView.widthAnchor.constraint(equalToConstant: 14),
            self.newImageView.heightAnchor.constraint(equalToConstant: 14)
        ])
        
    }
}

// MARK: - Extension for methods added
extension NoticeTableViewCell {
    func setCell(notice: NoticeItem) {
        self.titleLabel.text = notice.title
        self.timeLabel.text = SupportingMethods.shared.calculatePassedTime(SupportingMethods.shared.makeDateFormatter("yyyy-MM-dd HH:mm").date(from: notice.pubDate))
        
        if self.noticeModel.getReadStatus(noticeId: notice.id) == true {
            self.titleLabel.layer.opacity = 0.5
            self.timeLabel.layer.opacity = 0.5
            self.layer.opacity = 0.5
            
            self.newImageView.isHidden = true
        } else {
            self.titleLabel.layer.opacity = 1
            self.timeLabel.layer.opacity = 1
            self.layer.opacity = 1
            
            self.newImageView.isHidden = false
        }
    }
}

