//
//  DispatchNoteRegularlyTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 12/7/23.
//

import UIKit

final class DispatchNoteRegularlyTableViewCell: UITableViewCell {
    
    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Check_No")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
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
extension DispatchNoteRegularlyTableViewCell {
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
            self.checkImageView,
            self.contentsView
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
        
        // checkImageView
        NSLayoutConstraint.activate([
            self.checkImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.checkImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.checkImageView.widthAnchor.constraint(equalToConstant: 20),
            self.checkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // contentsView
        NSLayoutConstraint.activate([
//            self.contentsView.heightAnchor.constraint(equalToConstant: 100),
            self.contentsView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.contentsView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.contentsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.contentsView.leadingAnchor.constraint(equalTo: self.checkImageView.trailingAnchor, constant: 10)
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
extension DispatchNoteRegularlyTableViewCell {
    func setCell(item: DispatchRegularlyItem) {
        self.departureTimeLabel.text = self.sliceString(string: item.departureDate)
        self.departureLabel.text = item.departure
        
        self.arrivalTimeLabel.text = self.sliceString(string: item.arrivalDate)
        self.arrivalLabel.text = item.arrival
        
        self.vehicleNumberLabel.text = item.busId
    }
    
    func sliceString(string: String) -> String {
        let startIndex = string.index(string.startIndex, offsetBy: 11)// 사용자지정 시작인덱스
        let endIndex = string.index(string.startIndex, offsetBy: 16)// 사용자지정 끝인덱스
        
        return String(string[startIndex..<endIndex])
    }
}

