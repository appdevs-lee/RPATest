//
//  DispatchScheduleDetailTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/11/24.
//

import UIKit

final class DispatchScheduleDetailTableViewCell: UITableViewCell {
    
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
    
    lazy var pathNameLabel: UILabel = {
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
    
    lazy var arrivalNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var breathalyzingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "음주측정: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var breathalyzingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var takeOffTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발시간: "
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var takeOffTimeLabel: UILabel = {
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
    
    lazy var problemCheckTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "문제 발생 여부"
        label.textColor = .useRGB(red: 158, green: 158, blue: 158)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var problemCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "정상"
        label.textColor = .blue
        label.font = .useFont(ofSize: 16, weight: .Bold)
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
extension DispatchScheduleDetailTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
        self.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
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
            self.pathNameLabel,
            self.vehicleNumberLabel,
            self.arrivalNameTitleLabel,
            self.arrivalNameLabel,
            self.breathalyzingTitleLabel,
            self.breathalyzingLabel,
            self.takeOffTimeTitleLabel,
            self.takeOffTimeLabel,
            self.noteTitleLabel,
            self.noteLabel,
            self.problemCheckTitleLabel,
            self.problemCheckLabel
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
        
        // pathNameLabel
        NSLayoutConstraint.activate([
            self.pathNameLabel.leadingAnchor.constraint(equalTo: self.busImageView.trailingAnchor, constant: 4),
            self.pathNameLabel.centerYAnchor.constraint(equalTo: self.busImageView.centerYAnchor)
        ])
        
        // vehicleNumberLabel
        NSLayoutConstraint.activate([
            self.vehicleNumberLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10),
            self.vehicleNumberLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
        ])
        
        // arrivalNameTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalNameTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.arrivalNameTitleLabel.topAnchor.constraint(equalTo: self.pathNameLabel.bottomAnchor, constant: 8),
        ])
        
        // arrivalNameLabel
        NSLayoutConstraint.activate([
            self.arrivalNameLabel.leadingAnchor.constraint(equalTo: self.arrivalNameTitleLabel.trailingAnchor, constant: 4),
            self.arrivalNameLabel.centerYAnchor.constraint(equalTo: self.arrivalNameTitleLabel.centerYAnchor)
        ])
        
        // breathalyzingTitleLabel
        NSLayoutConstraint.activate([
            self.breathalyzingTitleLabel.topAnchor.constraint(equalTo: self.pathNameLabel.bottomAnchor, constant: 8),
        ])
        
        // breathalyzingLabel
        NSLayoutConstraint.activate([
            self.breathalyzingLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
            self.breathalyzingLabel.leadingAnchor.constraint(equalTo: self.breathalyzingTitleLabel.trailingAnchor, constant: 4),
            self.breathalyzingLabel.centerYAnchor.constraint(equalTo: self.breathalyzingTitleLabel.centerYAnchor),
        ])
        
        // takeOffTimeTitleLabel
        NSLayoutConstraint.activate([
            self.takeOffTimeTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.takeOffTimeTitleLabel.topAnchor.constraint(equalTo: self.arrivalNameTitleLabel.bottomAnchor, constant: 12),
        ])
        
        // takeOffTimeLabel
        NSLayoutConstraint.activate([
            self.takeOffTimeLabel.leadingAnchor.constraint(equalTo: self.takeOffTimeTitleLabel.trailingAnchor, constant: 4),
            self.takeOffTimeLabel.centerYAnchor.constraint(equalTo: self.takeOffTimeTitleLabel.centerYAnchor)
        ])
        
        // noteTitleLabel
        NSLayoutConstraint.activate([
            self.noteTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.noteTitleLabel.topAnchor.constraint(equalTo: self.takeOffTimeLabel.bottomAnchor, constant: 12)
        ])
        
        // noteLabel
        NSLayoutConstraint.activate([
            self.noteLabel.leadingAnchor.constraint(equalTo: self.noteTitleLabel.trailingAnchor, constant: 4),
            self.noteLabel.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -16),
            self.noteLabel.centerYAnchor.constraint(equalTo: self.noteTitleLabel.centerYAnchor)
        ])
        
        // problemCheckTitleLabel
        NSLayoutConstraint.activate([
            self.problemCheckTitleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 36),
            self.problemCheckTitleLabel.topAnchor.constraint(equalTo: self.noteLabel.bottomAnchor, constant: 12)
        ])
        
        // problemCheckLabel
        NSLayoutConstraint.activate([
            self.problemCheckLabel.leadingAnchor.constraint(equalTo: self.problemCheckTitleLabel.trailingAnchor, constant: 4),
            self.problemCheckLabel.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -10),
            self.problemCheckLabel.centerYAnchor.constraint(equalTo: self.problemCheckTitleLabel.centerYAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchScheduleDetailTableViewCell {
    func setCell(schedule: DispatchScheduleItem) {
        self.pathNameLabel.text = schedule.pathName
        self.vehicleNumberLabel.text = "버스번호: \(schedule.vehicleNumber)"
        self.arrivalNameLabel.text = schedule.arrivalName
        self.breathalyzingLabel.text = schedule.breathalyzing
        self.takeOffTimeLabel.text = schedule.time
        self.noteLabel.text = schedule.note
        
        if schedule.check {
            if schedule.status.wake {
                self.problemCheckLabel.text = "기상 문제 발생"
                
            } else if schedule.status.boarding {
                self.problemCheckLabel.text = "탑승 문제 발생"
                
            } else {
                self.problemCheckLabel.text = "운행 문제 발생"
                
            }
        }
        self.problemCheckLabel.textColor = schedule.check ? .red : .blue
    }
}

