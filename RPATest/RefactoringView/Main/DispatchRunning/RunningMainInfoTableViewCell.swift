//
//  RunningMainInfoTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/11/24.
//

import UIKit

final class RunningMainInfoTableViewCell: UITableViewCell {
    
    lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 18, weight: .SemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var routeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 168, green: 168, blue: 168)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 시간"
        label.textColor = .useRGB(red: 168, green: 168, blue: 168)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var runningDiaryBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var vehicleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("Universe")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var vehilceNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.vehicleNumberTitleLabel, self.vehicleNumberLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var vehicleNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "차량 번호"
        label.textColor = .useRGB(red: 127, green: 127, blue: 127)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var vehicleNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 94, green: 94, blue: 94)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var runningDiaryLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 일보"
        label.textColor = .useRGB(red: 168, green: 168, blue: 168)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var runningDiaryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("rightArrow")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
extension RunningMainInfoTableViewCell {
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
        SupportingMethods.shared.addSubviews([
            self.groupLabel,
            self.routeLabel,
            self.dateTitleLabel,
            self.dateLabel,
            self.runningDiaryBaseView,
            self.bottomBorderView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.vehicleImageView,
            self.vehilceNumberStackView,
            self.runningDiaryLabel,
            self.runningDiaryImageView,
        ], to: self.runningDiaryBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // groupLabel
        NSLayoutConstraint.activate([
            self.groupLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.groupLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
        
        // routeLabel
        NSLayoutConstraint.activate([
            self.routeLabel.leadingAnchor.constraint(equalTo: self.groupLabel.trailingAnchor, constant: 10),
            self.routeLabel.centerYAnchor.constraint(equalTo: self.groupLabel.centerYAnchor),
        ])
        
        // dateTitleLabel
        NSLayoutConstraint.activate([
            self.dateTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.dateTitleLabel.topAnchor.constraint(equalTo: self.groupLabel.bottomAnchor, constant: 20),
        ])
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.dateLabel.centerYAnchor.constraint(equalTo: self.dateTitleLabel.centerYAnchor),
        ])
        
        // runningDiaryBaseView
        NSLayoutConstraint.activate([
            self.runningDiaryBaseView.topAnchor.constraint(equalTo: self.dateTitleLabel.bottomAnchor, constant: 20),
            self.runningDiaryBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.runningDiaryBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.runningDiaryBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.runningDiaryBaseView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // vehicleImageView
        NSLayoutConstraint.activate([
            self.vehicleImageView.leadingAnchor.constraint(equalTo: self.runningDiaryBaseView.leadingAnchor, constant: 16),
            self.vehicleImageView.centerYAnchor.constraint(equalTo: self.runningDiaryBaseView.centerYAnchor),
            self.vehicleImageView.widthAnchor.constraint(equalToConstant: 60),
            self.vehicleImageView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // vehilceNumberStackView
        NSLayoutConstraint.activate([
            self.vehilceNumberStackView.leadingAnchor.constraint(equalTo: self.vehicleImageView.trailingAnchor, constant: 10),
            self.vehilceNumberStackView.centerYAnchor.constraint(equalTo: self.vehicleImageView.centerYAnchor),
        ])
        
        // runningDiaryImageView
        NSLayoutConstraint.activate([
            self.runningDiaryImageView.trailingAnchor.constraint(equalTo: self.runningDiaryBaseView.trailingAnchor, constant: -20),
            self.runningDiaryImageView.centerYAnchor.constraint(equalTo: self.runningDiaryBaseView.centerYAnchor),
            self.runningDiaryImageView.heightAnchor.constraint(equalToConstant: 14),
            self.runningDiaryImageView.widthAnchor.constraint(equalToConstant: 14),
        ])
        
        // runningDiaryLabel
        NSLayoutConstraint.activate([
            self.runningDiaryLabel.trailingAnchor.constraint(equalTo: self.runningDiaryImageView.leadingAnchor, constant: -5),
            self.runningDiaryLabel.centerYAnchor.constraint(equalTo: self.runningDiaryImageView.centerYAnchor),
        ])
        
        // bottomView
        NSLayoutConstraint.activate([
            self.bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomBorderView.topAnchor.constraint(equalTo: self.runningDiaryBaseView.bottomAnchor, constant: 20),
            self.bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomBorderView.heightAnchor.constraint(equalToConstant: 5),
        ])
        
    }
}

// MARK: - Extension for methods added
extension RunningMainInfoTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        if let _ = item.checkRegularlyConnect {
            self.groupLabel.text = "\(item.group!)"
            self.routeLabel.text = "\(item.route!)"
            
        } else {
            // order
            if let operationType = item.operationType {
                self.groupLabel.text = "일반 배차(\(operationType))"
                
            } else {
                self.groupLabel.text = "일반 배차"
                
            }
            
        }
        
        let tempDepartureDate = SupportingMethods.shared.convertString(intoDate: item.departureDate, "yyyy-MM-dd HH:mm")
        let tempArrivalDate = SupportingMethods.shared.convertString(intoDate: item.arrivalDate, "yyyy-MM-dd HH:mm")
        
        let convertedDepartureDate = SupportingMethods.shared.convertDate(intoString: tempDepartureDate, "MM/dd HH:mm")
        let convertedArrivalDate = SupportingMethods.shared.convertDate(intoString: tempArrivalDate, "MM/dd HH:mm")
        self.dateLabel.text = "\(convertedDepartureDate) ~ \(convertedArrivalDate)"
        
        self.vehicleNumberLabel.text = item.busId
    }
    
}

