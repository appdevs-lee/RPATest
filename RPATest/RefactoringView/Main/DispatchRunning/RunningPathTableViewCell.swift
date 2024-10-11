//
//  RunningPathTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/11/24.
//

import UIKit

final class RunningPathTableViewCell: UITableViewCell {
    
    lazy var movingPathLabel: UILabel = {
        let label = UILabel()
        label.text = "이동 경로"
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLocationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("departureLocationImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var departureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지"
        label.textColor = .useRGB(red: 111, green: 111, blue: 111)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var connectView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지"
        label.textColor = .useRGB(red: 111, green: 111, blue: 111)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLocationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("arrivalLocationImage")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
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
extension RunningPathTableViewCell {
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
            self.movingPathLabel,
            self.departureLocationImageView,
            self.departureTitleLabel,
            self.departureLabel,
            self.connectView,
            self.arrivalLocationImageView,
            self.arrivalTitleLabel,
            self.arrivalLabel,
            self.bottomBorderView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // movingPathLabel
        NSLayoutConstraint.activate([
            self.movingPathLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.movingPathLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
        
        // departureLocationImageView
        NSLayoutConstraint.activate([
            self.departureLocationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.departureLocationImageView.topAnchor.constraint(equalTo: self.movingPathLabel.bottomAnchor, constant: 16),
            self.departureLocationImageView.heightAnchor.constraint(equalToConstant: 12),
            self.departureLocationImageView.widthAnchor.constraint(equalToConstant: 12),
        ])
        
        // departureTitleLabel
        NSLayoutConstraint.activate([
            self.departureTitleLabel.leadingAnchor.constraint(equalTo: self.departureLocationImageView.trailingAnchor, constant: 16),
            self.departureTitleLabel.centerYAnchor.constraint(equalTo: self.departureLocationImageView.centerYAnchor),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.topAnchor.constraint(equalTo: self.departureTitleLabel.bottomAnchor, constant: 10),
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureTitleLabel.leadingAnchor),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        // connectView
        NSLayoutConstraint.activate([
            self.connectView.topAnchor.constraint(equalTo: self.departureLocationImageView.bottomAnchor, constant: 5),
            self.connectView.centerXAnchor.constraint(equalTo: self.departureLocationImageView.centerXAnchor),
            self.connectView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        // arrivalLocationImageView
        NSLayoutConstraint.activate([
            self.arrivalLocationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.arrivalLocationImageView.topAnchor.constraint(equalTo: self.connectView.bottomAnchor, constant: 5),
            self.arrivalLocationImageView.heightAnchor.constraint(equalToConstant: 14),
            self.arrivalLocationImageView.widthAnchor.constraint(equalToConstant: 14),
        ])
        
        // arrivalTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTitleLabel.leadingAnchor.constraint(equalTo: self.arrivalLocationImageView.trailingAnchor, constant: 16),
            self.arrivalTitleLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 20),
            self.arrivalTitleLabel.centerYAnchor.constraint(equalTo: self.arrivalLocationImageView.centerYAnchor),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.topAnchor.constraint(equalTo: self.arrivalTitleLabel.bottomAnchor, constant: 10),
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleLabel.leadingAnchor),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        // bottomBorderView
        NSLayoutConstraint.activate([
            self.bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomBorderView.topAnchor.constraint(equalTo: self.arrivalLabel.bottomAnchor, constant: 20),
            self.bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomBorderView.heightAnchor.constraint(equalToConstant: 5),
        ])
        
    }
}

// MARK: - Extension for methods added
extension RunningPathTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        self.departureLabel.text = item.departure
        self.arrivalLabel.text = item.arrival
        
    }
}

