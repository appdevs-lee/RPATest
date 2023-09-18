//
//  DispatchTableViewCell.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/03.
//

import UIKit

protocol DispatchDelegate: NSObjectProtocol {
    func tapDetailMapButton(mapLink: String)
    func tapDriveCheckButton(current: String)
}

final class DispatchTableViewCell: UITableViewCell {
    
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
    
    lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.startStackView, self.passengerStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
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
        let stackView = UIStackView(arrangedSubviews: [self.driveCheckButton, self.detailMapButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
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
    
    lazy var driveCheckButton: UIButton = {
        let button = UIButton()
//        button.isHidden = true
        button.layer.cornerRadius = 7
        button.setTitle("기상", for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedDriveCheckButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: DispatchDelegate?
    var info: DispatchRegularlyItem?
    let dispatchModel = DispatchModel()
    
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
extension DispatchTableViewCell {
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
        self.addSubview(self.firstStackView)
        self.addSubview(self.secondStackView)
        self.addSubview(self.buttonStackView)
    }
    
    // Set layouts
    func setLayouts() {
//        let safeArea = self.safeAreaLayoutGuide
        
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
        
        // firstStackView
        NSLayoutConstraint.activate([
            self.firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.firstStackView.topAnchor.constraint(equalTo: self.driveImageView.bottomAnchor, constant: 8),
        ])
        
        // secondStackView
        NSLayoutConstraint.activate([
            self.secondStackView.leadingAnchor.constraint(equalTo: self.firstStackView.trailingAnchor, constant: 28),
            self.secondStackView.centerYAnchor.constraint(equalTo: self.firstStackView.centerYAnchor)
        ])
        
        // buttonStackView
        NSLayoutConstraint.activate([
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.buttonStackView.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 10),
            self.buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ])
        
        // driveCheckButton
        NSLayoutConstraint.activate([
            self.driveCheckButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // detailMapButton
        NSLayoutConstraint.activate([
            self.detailMapButton.widthAnchor.constraint(equalToConstant: 75),
            self.detailMapButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
}

// MARK: - Extension for methods added
extension DispatchTableViewCell {
    func setCell(info: DispatchRegularlyItem) {
        self.info = info
        self.driveTitleLabel.text = info.route
        
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
        
    }
}

// MARK: - Extension for methods added
extension DispatchTableViewCell {
    func checkPatchDispatchRequest(checkType: String, time: String, regularlyId: String, orderId: String, success: ((CheckDriveItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.checkPatchDispatchRequest(checkType: checkType, time: time, regularlyId: regularlyId, orderId: orderId) { item in
            success?(item)
            
        } dispatchFailure: { reason in
            print(reason)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
        }

        
    }
}

// MARK: - Extension for selectors added
extension DispatchTableViewCell {
    @objc func tappedDriveCheckButton(_ sender: UIButton) {
        var checkType: String = ""
        if self.driveCheckButton.titleLabel?.text == "기상" {
            checkType = "기상"
        } else if self.driveCheckButton.titleLabel?.text == "운행 시작" {
            checkType = "운행"
        } else if self.driveCheckButton.titleLabel?.text == "출발지 도착" {
            checkType = "출발지"
        }
        
        guard let info = self.info else { return }
        
        SupportingMethods.shared.turnCoverView(.on)
        self.checkPatchDispatchRequest(checkType: checkType, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"), regularlyId: "\(info.id)", orderId: "") { item in
            switch checkType {
            case "기상":
                self.driveCheckButton.setTitle("운행 시작", for: .normal)
            case "운행":
                self.driveCheckButton.setTitle("출발지 도착", for: .normal)
            default:
                self.driveCheckButton.setTitle("안전 운행하세요", for: .normal)
                self.driveCheckButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                self.driveCheckButton.isEnabled = false
            }
            
            SupportingMethods.shared.turnCoverView(.off)
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("tappedDriveCheckButton checkPatchDispatchRequest API Error: \(errorMessage)")
            
        }
        
        self.delegate?.tapDriveCheckButton(current: (self.driveCheckButton.titleLabel?.text!)!)
    }
    
    @objc func tappedDetailMapButton(_ sender: UIButton) {
        guard let info = self.info else { return }
        
        self.delegate?.tapDetailMapButton(mapLink: info.maplink)
    }
}
