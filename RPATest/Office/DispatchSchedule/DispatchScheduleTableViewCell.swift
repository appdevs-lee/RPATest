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
    
    lazy var dispatchCountLabel: UILabel = {
        let label = UILabel()
        label.text = "(1/4)"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
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
    
    lazy var pathNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "노선명: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var pathNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var takeOffTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발시간: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var takeOffLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var wakeButton: UIButton = {
        let button = UIButton()
        button.setTitle("기상", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 15
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var boardingButton: UIButton = {
        let button = UIButton()
        button.setTitle("탑승", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 15
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var drivingButton: UIButton = {
        let button = UIButton()
        button.setTitle("운행", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 15
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var isBlinking = false
    
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
            self.dispatchCountLabel,
            self.vehicleNumberLabel,
            self.pathNameTitleLabel,
            self.pathNameLabel,
            self.takeOffTitleLabel,
            self.takeOffLabel,
            self.wakeButton,
            self.boardingButton,
            self.drivingButton
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
        
        // dispatchCountLabel
        NSLayoutConstraint.activate([
            self.dispatchCountLabel.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 8),
            self.dispatchCountLabel.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor)
        ])
        
        // vehicleNumberLabel
        NSLayoutConstraint.activate([
            self.vehicleNumberLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10),
            self.vehicleNumberLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
        ])
        
        // pathNameTitleLabel
        NSLayoutConstraint.activate([
            self.pathNameTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.pathNameTitleLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
        ])
        
        // pathNameLabel
        NSLayoutConstraint.activate([
            self.pathNameLabel.leadingAnchor.constraint(equalTo: self.pathNameTitleLabel.trailingAnchor, constant: 4),
            self.pathNameLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -4),
            self.pathNameLabel.centerYAnchor.constraint(equalTo: self.pathNameTitleLabel.centerYAnchor)
        ])
        
        // takeOffTitleLabel
        NSLayoutConstraint.activate([
            self.takeOffTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.takeOffTitleLabel.topAnchor.constraint(equalTo: self.pathNameLabel.bottomAnchor, constant: 8),
        ])
        
        // takeOffLabel
        NSLayoutConstraint.activate([
            self.takeOffLabel.leadingAnchor.constraint(equalTo: self.takeOffTitleLabel.trailingAnchor, constant: 4),
            self.takeOffLabel.centerYAnchor.constraint(equalTo: self.takeOffTitleLabel.centerYAnchor),
        ])
        
        // wakeButton
        NSLayoutConstraint.activate([
            self.wakeButton.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 16),
            self.wakeButton.topAnchor.constraint(equalTo: self.takeOffLabel.bottomAnchor, constant: 10),
            self.wakeButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 80)/3),
            self.wakeButton.heightAnchor.constraint(equalToConstant: 36),
            self.wakeButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10),
        ])
        
        // boardingButton
        NSLayoutConstraint.activate([
            self.boardingButton.leadingAnchor.constraint(equalTo: self.wakeButton.trailingAnchor, constant: 8),
            self.boardingButton.topAnchor.constraint(equalTo: self.takeOffLabel.bottomAnchor, constant: 10),
            self.boardingButton.widthAnchor.constraint(equalTo: self.wakeButton.widthAnchor, multiplier: 1.0),
            self.boardingButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        // drivingButton
        NSLayoutConstraint.activate([
            self.drivingButton.leadingAnchor.constraint(equalTo: self.boardingButton.trailingAnchor, constant: 8),
            self.drivingButton.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
            self.drivingButton.topAnchor.constraint(equalTo: self.takeOffLabel.bottomAnchor, constant: 10),
            self.drivingButton.widthAnchor.constraint(equalTo: self.wakeButton.widthAnchor, multiplier: 1.0),
            self.drivingButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchScheduleTableViewCell {
    func setCell(schedule: DispatchScheduleItem) {
        if schedule.check {
            self.isBlinking = true
            
        } else {
            self.isBlinking = false
            
        }
        
        self.nameLabel.text = schedule.name
        self.vehicleNumberLabel.text = "버스번호: \(schedule.vehicleNumber)"
        self.pathNameLabel.text = schedule.pathName
        self.takeOffLabel.text = schedule.time
        
        self.wakeButton.layer.removeAllAnimations()
        self.wakeButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        self.wakeButton.setTitleColor(.white, for: .normal)
        
        self.boardingButton.layer.removeAllAnimations()
        self.boardingButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        self.boardingButton.setTitleColor(.white, for: .normal)
        
        self.drivingButton.layer.removeAllAnimations()
        self.drivingButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        self.drivingButton.setTitleColor(.white, for: .normal)
        
        switch schedule.status {
        case (true, false, false):
            self.wakeButton.setTitle("기상 완료", for: .normal)
            self.wakeButton.setTitleColor(.useRGB(red: 66, green: 66, blue: 66), for: .normal)
            self.wakeButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
            self.boardingButton.setTitle("탑승", for: .normal)
            
            self.drivingButton.setTitle("운행", for: .normal)
            
        case (true, true, false):
            self.wakeButton.setTitle("기상 완료", for: .normal)
            self.wakeButton.setTitleColor(.useRGB(red: 66, green: 66, blue: 66), for: .normal)
            self.wakeButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
            self.boardingButton.setTitle("탑승 완료", for: .normal)
            self.boardingButton.setTitleColor(.useRGB(red: 66, green: 66, blue: 66), for: .normal)
            self.boardingButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
            self.drivingButton.setTitle("운행", for: .normal)
            
        case (true, true, true):
            self.wakeButton.setTitle("기상 완료", for: .normal)
            self.wakeButton.setTitleColor(.useRGB(red: 66, green: 66, blue: 66), for: .normal)
            self.wakeButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
            self.boardingButton.setTitle("탑승 완료", for: .normal)
            self.boardingButton.setTitleColor(.useRGB(red: 66, green: 66, blue: 66), for: .normal)
            self.boardingButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
            self.drivingButton.setTitle("운행중", for: .normal)
            self.drivingButton.setTitleColor(.useRGB(red: 66, green: 66, blue: 66), for: .normal)
            self.drivingButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
        default:
            if schedule.check {
                if schedule.status.wake == false {
                    self.wakeButton.setTitle("기상 문제", for: .normal)
                    
                    if self.isBlinking {
                        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
                            self.wakeButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                            
                        }
                        
                    }
                    
                } else if schedule.status.boarding == false {
                    self.boardingButton.setTitle("탑승 문제", for: .normal)
                    
                    if self.isBlinking {
                        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
                            self.boardingButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                            
                        }
                        
                    }
                    
                } else if schedule.status.boarding == false {
                    self.drivingButton.setTitle("운행 문제", for: .normal)
                    
                    
                    if self.isBlinking {
                        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
                            self.drivingButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                            
                        }
                        
                    }
                    
                } else {
                    self.drivingButton.setTitle("운행 문제", for: .normal)
                    
                    if self.isBlinking {
                        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
                            self.drivingButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                            
                        }
                        
                    }
                    
                }
            }
        }
        
        if schedule.check {
            self.mainView.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32, alpha: 0.7).cgColor
            self.mainView.layer.borderWidth = 4.0
            
        } else {
            self.mainView.layer.borderWidth = 0.0
            
        }
        
    }
}
