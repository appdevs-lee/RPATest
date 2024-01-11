//
//  RenewalDispatchRegularlyTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 12/14/23.
//

import UIKit

enum DriveCheckType: String {
    case wake = "기상"
    case boarding = "운행"
    case departureArrive = "출발지"
    case drivingStart
    case driving
    case done
}

protocol RenewalDispatchDelegate: NSObjectProtocol {
    func tapDetailMapButton(mapLink: String)
    func tappedStatusButton(type: DriveCheckType, item: DispatchRegularlyItem?)
    
}

final class RenewalDispatchRegularlyTableViewCell: UITableViewCell {
    
    lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Start")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Arrival")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.numberOfLines = 0
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var vehicleNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 240, blue: 86)
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var vehicleNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.statusButton, self.kakaoImageView])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("기상", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Bold)
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.addShadow(location: .bottom)
        button.addTarget(self, action: #selector(tappedStatusButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var kakaoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KakaoMapLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.addShadow(location: .bottom)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var delegate: RenewalDispatchDelegate?
    var mapLink: String = ""
    var checkType: DriveCheckType = .wake
    var item: DispatchRegularlyItem?
    
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
extension RenewalDispatchRegularlyTableViewCell {
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
        let kakaoGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedKakaoButton(_:)))
        self.kakaoImageView.addGestureRecognizer(kakaoGesture)
        self.kakaoImageView.isUserInteractionEnabled = true
    }
    
    // Set notificationCenters
    func setNotificationCenters() {
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.contentsView,
            self.statusStackView
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.departureTimeLabel,
            self.departureImageView,
            self.departureLabel,
            self.arrivalTimeLabel,
            self.arrivalImageView,
            self.arrivalLabel,
            self.vehicleNumberView,
            self.vehicleNumberLabel
        ], to: self.contentsView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // contentsView
        NSLayoutConstraint.activate([
            self.contentsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.contentsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.contentsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        // statusSatckView
        NSLayoutConstraint.activate([
            self.statusStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.statusStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.statusStackView.topAnchor.constraint(equalTo: self.contentsView.bottomAnchor, constant: 8)
        ])
        
        // statusButton
        NSLayoutConstraint.activate([
            self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // kakaoImageView
        NSLayoutConstraint.activate([
            self.kakaoImageView.heightAnchor.constraint(equalToConstant: 50),
            self.kakaoImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.contentsView.leadingAnchor, constant: 16),
            self.departureTimeLabel.centerYAnchor.constraint(equalTo: self.departureLabel.centerYAnchor)
        ])
        
        // departureImageView
        NSLayoutConstraint.activate([
            self.departureImageView.centerYAnchor.constraint(equalTo: self.departureLabel.centerYAnchor),
            self.departureImageView.leadingAnchor.constraint(equalTo: self.departureTimeLabel.trailingAnchor, constant: 4),
            self.departureImageView.widthAnchor.constraint(equalToConstant: 30),
            self.departureImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.topAnchor.constraint(equalTo: self.contentsView.topAnchor, constant: 10),
            self.departureLabel.centerYAnchor.constraint(equalTo: self.departureTimeLabel.centerYAnchor),
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureImageView.trailingAnchor, constant: 4),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.vehicleNumberView.leadingAnchor, constant: -4),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.contentsView.leadingAnchor, constant: 16),
            self.arrivalTimeLabel.centerYAnchor.constraint(equalTo: self.arrivalLabel.centerYAnchor)
        ])
        
        // arrivalImageView
        NSLayoutConstraint.activate([
            self.arrivalImageView.centerYAnchor.constraint(equalTo: self.arrivalLabel.centerYAnchor),
            self.arrivalImageView.leadingAnchor.constraint(equalTo: self.arrivalTimeLabel.trailingAnchor, constant: 4),
            self.arrivalImageView.widthAnchor.constraint(equalToConstant: 30),
            self.arrivalImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 20),
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalImageView.trailingAnchor, constant: 4),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.vehicleNumberView.leadingAnchor, constant: -4),
            self.arrivalLabel.bottomAnchor.constraint(equalTo: self.contentsView.bottomAnchor, constant: -10)
        ])
        
        // vehicleNumberView
        NSLayoutConstraint.activate([
            self.vehicleNumberView.trailingAnchor.constraint(equalTo: self.contentsView.trailingAnchor, constant: -10),
            self.vehicleNumberView.centerYAnchor.constraint(equalTo: self.contentsView.centerYAnchor),
            self.vehicleNumberView.heightAnchor.constraint(equalToConstant: 40),
            self.vehicleNumberView.widthAnchor.constraint(equalToConstant: 72)
        ])
        
        // vehicleNumberLabel
        NSLayoutConstraint.activate([
            self.vehicleNumberLabel.centerYAnchor.constraint(equalTo: self.vehicleNumberView.centerYAnchor),
            self.vehicleNumberLabel.centerXAnchor.constraint(equalTo: self.vehicleNumberView.centerXAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension RenewalDispatchRegularlyTableViewCell {
    func setCell(item: DispatchRegularlyItem, checkType: DriveCheckType) {
        self.item = item
        self.mapLink = item.maplink
        self.checkType = checkType
        
        self.departureTimeLabel.text = item.departureDate.sliceString()
        self.departureLabel.text = item.departure
        
        self.arrivalTimeLabel.text = item.arrivalDate.sliceString()
        self.arrivalLabel.text = item.arrival
        
        self.vehicleNumberLabel.text = item.busId
        
        if item.maplink == "" {
            self.kakaoImageView.isHidden = true
            
        } else {
            self.kakaoImageView.isHidden = false
            
        }
        
        if item.checkRegularlyConnect.driveTime == "" {
            self.checkType = .wake
        } else if item.checkRegularlyConnect.departureTime == "" {
            self.checkType = .boarding
        } else {
            if checkType == .wake {
                self.checkType = .departureArrive
            }
            
        }
        
        if item.checkRegularlyConnect.wakeTime == "" {
            self.statusButton.setTitle("기상", for: .normal)
            self.checkType = .wake
            
        } else if item.checkRegularlyConnect.wakeTime != "" && self.checkType == .wake {
            self.statusButton.setTitle("탑승 및 출발", for: .normal)
            self.checkType = .boarding
            
        } else if item.checkRegularlyConnect.driveTime != "" && self.checkType == .boarding {
            self.statusButton.setTitle("첫 출발지 도착", for: .normal)
            self.checkType = .departureArrive
            
        } else if self.checkType == .departureArrive {
            self.statusButton.setTitle("운행 시작", for: .normal)
            self.checkType = .drivingStart
            
        } else if self.checkType == .drivingStart {
            self.statusButton.setTitle("운행중", for: .normal)
            self.checkType = .driving
            
        } else {
            self.statusButton.setTitle("운행 종료", for: .normal)
            self.statusButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            self.statusButton.isEnabled = false
            self.checkType = .done
        }
    }
}

// MARK: - Extension for selector added
extension RenewalDispatchRegularlyTableViewCell {
    @objc func tappedKakaoButton(_ sender: UIButton) {
        self.delegate?.tapDetailMapButton(mapLink: self.mapLink)
        
    }
    
    @objc func tappedStatusButton(_ sender: UIButton) {
        self.delegate?.tappedStatusButton(type: self.checkType, item: self.item)
        
    }
}
