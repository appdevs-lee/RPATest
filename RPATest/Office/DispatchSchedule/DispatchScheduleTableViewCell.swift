//
//  DispatchScheduleTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 11/9/23.
//

import UIKit

final class DispatchScheduleTableViewCell: UITableViewCell {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.layer.shadowColor = UIColor.lightGray.cgColor // 색깔
        view.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        view.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        view.layer.shadowRadius = 5 // 반경
        view.layer.shadowOpacity = 0.3 // alpha값
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var busImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "notiIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var vehicleNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var pathTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출근노선: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var pathLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var gateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Gate: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var gateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "비고: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
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
extension DispatchScheduleTableViewCell {
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
        self.addSubview(self.mainView)
        
        SupportingMethods.shared.addSubviews([
            self.busImageView,
            self.nameLabel,
            self.vehicleNumberLabel,
            self.pathTitleLabel,
            self.pathLabel,
            self.gateTitleLabel,
            self.gateLabel,
            self.noteTitleLabel,
            self.noteLabel
        ], to: self.mainView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // mainView
        NSLayoutConstraint.activate([
            self.mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // busImageView
        NSLayoutConstraint.activate([
            self.busImageView.widthAnchor.constraint(equalToConstant: 20),
            self.busImageView.heightAnchor.constraint(equalToConstant: 20),
            self.busImageView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 16),
            self.busImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.busImageView.trailingAnchor, constant: 4),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.busImageView.centerYAnchor)
        ])
        
        // vehicleNumberLabel
        NSLayoutConstraint.activate([
            self.vehicleNumberLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10),
            self.vehicleNumberLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
        ])
        
        // pathTitleLabel
        NSLayoutConstraint.activate([
            self.pathTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.pathTitleLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
        ])
        
        // pathLabel
        NSLayoutConstraint.activate([
            self.pathLabel.leadingAnchor.constraint(equalTo: self.pathTitleLabel.trailingAnchor, constant: 4),
            self.pathLabel.centerYAnchor.constraint(equalTo: self.pathTitleLabel.centerYAnchor)
        ])
        
        // gateTitleLabel
        NSLayoutConstraint.activate([
            self.gateTitleLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
        ])
        
        // gateLabel
        NSLayoutConstraint.activate([
            self.gateLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
            self.gateLabel.leadingAnchor.constraint(equalTo: self.gateTitleLabel.trailingAnchor, constant: 4),
            self.gateLabel.centerYAnchor.constraint(equalTo: self.gateTitleLabel.centerYAnchor),
        ])
        
        // noteTitleLabel
        NSLayoutConstraint.activate([
            self.noteTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.noteTitleLabel.topAnchor.constraint(equalTo: self.pathTitleLabel.bottomAnchor, constant: 12),
            self.noteTitleLabel.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10)
        ])
        
        // noteLabel
        NSLayoutConstraint.activate([
            self.noteLabel.leadingAnchor.constraint(equalTo: self.noteTitleLabel.trailingAnchor, constant: 4),
            self.noteLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
            self.noteLabel.centerYAnchor.constraint(equalTo: self.noteTitleLabel.centerYAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchScheduleTableViewCell {
    func setCell(schedule: DispatchScheduleItem) {
        self.nameLabel.text = schedule.name
        self.vehicleNumberLabel.text = schedule.vehicleNumber
        self.pathLabel.text = "\(schedule.path) (\(schedule.time))"
        self.gateLabel.text = schedule.gate
        self.noteLabel.text = schedule.note
        
    }
}
