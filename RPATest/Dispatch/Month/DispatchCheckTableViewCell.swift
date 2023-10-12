//
//  DispatchCheckTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/13.
//

import UIKit

protocol DispatchDailyDelegate: NSObjectProtocol {
    func tapDetailMapButton(mapLink: String)
    func tapCheckButton(info: DispatchRegularlyItem)
    func tapDenyButton(info: DispatchRegularlyItem)
}

final class DispatchCheckTableViewCell: UITableViewCell {
    
    lazy var driveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var driveTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var detailMapButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("노선상세", for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedDetailMapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.contentBackGroundView, self.buttonStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var contentBackGroundView: UIView = {
        let view = UIView()
        view.addSubview(self.contentStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.firstStackView, self.secondStackView])
        stackView.axis = .horizontal
        stackView.spacing = 28
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.startStackView, self.passengerStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var startStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.startTitleLabel, self.startTimeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var startTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발시간:"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        return label
    }()
    
    lazy var passengerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.passengerTitleLabel, self.passengerCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var passengerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승인원:"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passengerCountLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        return label
    }()
    
    lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.arrivalStackView, self.busNumberStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var arrivalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.arrivalTitleLabel, self.arrivalTimeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var arrivalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착시간:"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        return label
    }()
    
    lazy var busNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.busNumberTitleLabel, self.busNumberCountLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var busNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "버스번호:"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var busNumberCountLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.checkButton, self.denyButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedCheckButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var denyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("거부", for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedDenyButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: DispatchDailyDelegate?
    var info: DispatchRegularlyItem?
    var mapLink: String = ""
    
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
extension DispatchCheckTableViewCell {
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
        self.addSubview(self.driveImageView)
        self.addSubview(self.driveTitleLabel)
        self.addSubview(self.detailMapButton)
        self.addSubview(self.mainStackView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // driveImageView
        NSLayoutConstraint.activate([
            self.driveImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.driveImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.driveImageView.widthAnchor.constraint(equalToConstant: 30),
            self.driveImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // driveTitleLabel
        NSLayoutConstraint.activate([
            self.driveTitleLabel.leadingAnchor.constraint(equalTo: self.driveImageView.trailingAnchor, constant: 12),
            self.driveTitleLabel.centerYAnchor.constraint(equalTo: self.driveImageView.centerYAnchor)
        ])
        
        // detailMapButton
        NSLayoutConstraint.activate([
            self.detailMapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.detailMapButton.centerYAnchor.constraint(equalTo: self.driveImageView.centerYAnchor),
            self.detailMapButton.widthAnchor.constraint(equalToConstant: 75),
            self.detailMapButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // mainStackView
        NSLayoutConstraint.activate([
            self.mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.mainStackView.topAnchor.constraint(equalTo: self.driveImageView.bottomAnchor, constant: 8),
            self.mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ])
        
        // contentStackView
        NSLayoutConstraint.activate([
            self.contentStackView.leadingAnchor.constraint(equalTo: self.contentBackGroundView.leadingAnchor),
            self.contentStackView.topAnchor.constraint(equalTo: self.contentBackGroundView.topAnchor),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.contentBackGroundView.bottomAnchor)
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // denyButton
        NSLayoutConstraint.activate([
            self.denyButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchCheckTableViewCell {
    func setCell(info: DispatchRegularlyItem) {
        self.info = info
        self.mapLink = info.maplink
        self.driveTitleLabel.text = "\(info.group) - \(info.route)"
        
        self.startTimeLabel.text = "\(info.departureDate.split(separator: " ").last!)"
        self.passengerCountLabel.text = "00명"
        
        self.arrivalTimeLabel.text = "\(info.arrivalDate.split(separator: " ").last!)"
        self.busNumberCountLabel.text = info.busId
        
        if info.workType == "출근" {
            self.driveImageView.image = UIImage(named: "Start")
        } else {
            self.driveImageView.image = UIImage(named: "Arrival")
        }
        
        if info.maplink == "" {
            self.detailMapButton.isHidden = true
            
        } else {
            self.detailMapButton.isHidden = false
            
        }
        
        if info.checkRegularlyConnect.connectCheck == "1" || info.checkRegularlyConnect.connectCheck == "0" {
            self.buttonStackView.isHidden = true
            
        } else {
            self.buttonStackView.isHidden = false
            
        }
    }
}

// MARK: - Extension for selectors added
extension DispatchCheckTableViewCell {
    @objc func tappedDetailMapButton(_ sender: UIButton) {
        self.delegate?.tapDetailMapButton(mapLink: self.mapLink)
    }
    
    @objc func tappedCheckButton(_ sender: UIButton) {
        self.delegate?.tapCheckButton(info: self.info!)
    }
    
    @objc func tappedDenyButton(_ sender: UIButton) {
        self.delegate?.tapDenyButton(info: self.info!)
    }
    
}
