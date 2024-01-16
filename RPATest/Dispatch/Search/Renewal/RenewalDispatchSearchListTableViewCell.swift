//
//  RenewalDispatchSearchListTableViewCell.swift
//  RPATest
//
//  Created by 이주성 on 1/16/24.
//

import UIKit

final class RenewalDispatchSearchListTableViewCell: UITableViewCell {
    
    lazy var starButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "NoBookmarkPath"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var pathNameLabel: UILabel = {
        let label = UILabel()
        label.text = "동탄2신도시2차_H2-H1"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var startTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "20:20"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var finishTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var finishTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "20:20"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "KakaoMapLogo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchKnowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Check_No"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var detailedRouteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "모아미래도(무봉초버스정류장)-KCC스위첸(버스정류장)-시범반도4차(버스정류장)-호반베르디움(버스정류장)-대원칸타빌(버스정류장)-한화꿈에그린(버스정류장)-더샵센트럴시티(청계중앙공원)버스정류장-동탄2지구자이(버스정류장)-화성캠퍼스H2-화성캠퍼스H1"
        label.textColor = .black
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
extension RenewalDispatchSearchListTableViewCell {
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
            self.starButton,
            self.pathNameLabel,
            self.mapButton,
            self.dispatchKnowButton,
            self.startTimeTitleLabel,
            self.startTimeLabel,
            self.finishTimeTitleLabel,
            self.finishTimeLabel,
            self.departureTitleLabel,
            self.departureLabel,
            self.arrivalTitleLabel,
            self.arrivalLabel,
            self.separateView,
            self.detailedRouteLabel,
            self.bottomView
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
//        let safeArea = self.safeAreaLayoutGuide
        
        // starButton
        NSLayoutConstraint.activate([
            self.starButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.starButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.starButton.widthAnchor.constraint(equalToConstant: 40),
            self.starButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // pathNameLabel
        NSLayoutConstraint.activate([
            self.pathNameLabel.leadingAnchor.constraint(equalTo: self.starButton.trailingAnchor, constant: 10),
            self.pathNameLabel.centerYAnchor.constraint(equalTo: self.starButton.centerYAnchor)
        ])
        
        // mapButton
        NSLayoutConstraint.activate([
            self.mapButton.centerYAnchor.constraint(equalTo: self.dispatchKnowButton.centerYAnchor),
            self.mapButton.widthAnchor.constraint(equalToConstant: 40),
            self.mapButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // dispatchKnowButton
        NSLayoutConstraint.activate([
            self.dispatchKnowButton.leadingAnchor.constraint(equalTo: self.mapButton.trailingAnchor, constant: 8),
            self.dispatchKnowButton.centerYAnchor.constraint(equalTo: self.starButton.centerYAnchor),
            self.dispatchKnowButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
        // startTimeTitleLabel
        NSLayoutConstraint.activate([
            self.startTimeTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 76),
            self.startTimeTitleLabel.topAnchor.constraint(equalTo: self.pathNameLabel.bottomAnchor, constant: 10)
        ])
        
        // startTimeLabel
        NSLayoutConstraint.activate([
            self.startTimeLabel.leadingAnchor.constraint(equalTo: self.startTimeTitleLabel.trailingAnchor, constant: 16),
            self.startTimeLabel.centerYAnchor.constraint(equalTo: self.startTimeTitleLabel.centerYAnchor)
        ])
        
        // finishTimeTitleLabel
        NSLayoutConstraint.activate([
            self.finishTimeTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 76),
            self.finishTimeTitleLabel.topAnchor.constraint(equalTo: self.startTimeTitleLabel.bottomAnchor, constant: 10)
        ])
        
        // finishTimeLabel
        NSLayoutConstraint.activate([
            self.finishTimeLabel.leadingAnchor.constraint(equalTo: self.finishTimeTitleLabel.trailingAnchor, constant: 16),
            self.finishTimeLabel.centerYAnchor.constraint(equalTo: self.finishTimeTitleLabel.centerYAnchor)
        ])
        
        // departureTitleLabel
        NSLayoutConstraint.activate([
            self.departureTitleLabel.leadingAnchor.constraint(equalTo: self.startTimeLabel.trailingAnchor, constant: 10),
            self.departureTitleLabel.centerYAnchor.constraint(equalTo: self.startTimeTitleLabel.centerYAnchor)
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureTitleLabel.trailingAnchor, constant: 16),
            self.departureLabel.centerYAnchor.constraint(equalTo: self.startTimeTitleLabel.centerYAnchor)
        ])
        
        // arrivalTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTitleLabel.centerXAnchor.constraint(equalTo: self.departureTitleLabel.centerXAnchor),
            self.arrivalTitleLabel.centerYAnchor.constraint(equalTo: self.finishTimeTitleLabel.centerYAnchor)
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleLabel.trailingAnchor, constant: 16),
            self.arrivalLabel.centerYAnchor.constraint(equalTo: self.finishTimeTitleLabel.centerYAnchor)
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.topAnchor.constraint(equalTo: self.finishTimeTitleLabel.bottomAnchor, constant: 20),
            self.separateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.separateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.separateView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // detailedRouteLabel
        NSLayoutConstraint.activate([
            self.detailedRouteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.detailedRouteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.detailedRouteLabel.topAnchor.constraint(equalTo: self.separateView.bottomAnchor, constant: 10),
            self.detailedRouteLabel.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: -10),
        ])
        
        // bottomView
        NSLayoutConstraint.activate([
            self.bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomView.heightAnchor.constraint(equalToConstant: 4),
            self.bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}

// MARK: - Extension for methods added
extension RenewalDispatchSearchListTableViewCell {
    func setCell() {
        
    }
}
