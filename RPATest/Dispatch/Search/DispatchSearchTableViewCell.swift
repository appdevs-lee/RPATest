//
//  DispatchSearchTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/19.
//

import UIKit

protocol DispatchSearchDelegate: NSObjectProtocol {
    func tapKakaoMapButton(mapLink: String)
    func tapPathKnowButton(id: Int, button: UIButton)
    func tapPathKnowDeleteButton(id: Int, button: UIButton)
}

final class DispatchSearchTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var kakaoMapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "KakaoMapLogo"), for: .normal)
        button.addTarget(self, action: #selector(tappedKakaoMapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var pathKnowBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PathKnowBadge")
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.leftStackView, self.rightStackView])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var leftStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.departureLabel, self.driveDayLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var driveDayLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rightStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.arrivalLabel, self.driveTimeLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var driveTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var driverAllowanceLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var precautionsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var detailedRouteLabel: UILabel = {
        let label = UILabel()
        label.text = "상세노선 ↓"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var detailedRouteTextView: UITextView = {
        let textView = UITextView()
        textView.font = .useFont(ofSize: 14, weight: .Medium)
        textView.textColor = .useRGB(red: 66, green: 66, blue: 66)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var pathKnowRequestButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedPathKnowButton(_:)), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: DispatchSearchDelegate?
    var searchResult: DispatchPathRegularlyList?
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
extension DispatchSearchTableViewCell {
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
        self.addSubview(self.titleLabel)
        self.addSubview(self.pathKnowBadgeImageView)
        self.addSubview(self.kakaoMapButton)
        self.addSubview(self.allStackView)
        self.addSubview(self.driverAllowanceLabel)
        self.addSubview(self.precautionsLabel)
        self.addSubview(self.detailedRouteLabel)
        self.addSubview(self.detailedRouteTextView)
        self.addSubview(self.pathKnowRequestButton)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        ])
        
        // pathKnowBadgeImageView
        NSLayoutConstraint.activate([
            self.pathKnowBadgeImageView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 5),
            self.pathKnowBadgeImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor)
        ])
        
        // kakaoMapButton
        NSLayoutConstraint.activate([
            self.kakaoMapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.kakaoMapButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.kakaoMapButton.widthAnchor.constraint(equalToConstant: 30),
            self.kakaoMapButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // allStackView
        NSLayoutConstraint.activate([
            self.allStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.allStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.allStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10)
        ])
        
        // driverAllowanceLabel
        NSLayoutConstraint.activate([
            self.driverAllowanceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.driverAllowanceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.driverAllowanceLabel.topAnchor.constraint(equalTo: self.allStackView.bottomAnchor, constant: 5)
        ])
        
        // precautionsLabel
        NSLayoutConstraint.activate([
            self.precautionsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.precautionsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.precautionsLabel.topAnchor.constraint(equalTo: self.driverAllowanceLabel.bottomAnchor, constant: 5)
        ])
        
        // detailedRouteLabel
        NSLayoutConstraint.activate([
            self.detailedRouteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.detailedRouteLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.detailedRouteLabel.topAnchor.constraint(equalTo: self.precautionsLabel.bottomAnchor, constant: 5)
        ])
        
        // detailedRouteTextView
        NSLayoutConstraint.activate([
            self.detailedRouteTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.detailedRouteTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.detailedRouteTextView.topAnchor.constraint(equalTo: self.detailedRouteLabel.bottomAnchor, constant: 5)
        ])
        
        // pathKnowRequestButton
        NSLayoutConstraint.activate([
            self.pathKnowRequestButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.pathKnowRequestButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.pathKnowRequestButton.topAnchor.constraint(equalTo: self.detailedRouteTextView.bottomAnchor, constant: 5),
            self.pathKnowRequestButton.heightAnchor.constraint(equalToConstant: 30),
            self.pathKnowRequestButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchSearchTableViewCell {
    func setCell(searchResult: DispatchPathRegularlyList) {
        self.searchResult = searchResult
        
        self.titleLabel.text = searchResult.route
        
        self.departureLabel.text = "출발지: \(searchResult.departure)"
        self.arrivalLabel.text = "도착지: \(searchResult.arrival)"
        
        self.driveDayLabel.text = "운행요일: \(searchResult.week)"
        self.driveTimeLabel.text = "운행시간: \(searchResult.departureTime) ~ \(searchResult.arrivalTime)"
        
        self.driverAllowanceLabel.text = "기사수당: \(searchResult.driverAllowance)"
        self.precautionsLabel.text = "유의사항: \(searchResult.references)"
        
        self.detailedRouteTextView.text = searchResult.detailedRoute
        
        if searchResult.know == "true"{
            self.pathKnowRequestButton.setTitle("노선숙지 취소", for: .normal)
            self.pathKnowRequestButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            self.pathKnowBadgeImageView.isHidden = false
            
        } else {
            self.pathKnowRequestButton.setTitle("노선숙지 완료", for: .normal)
            self.pathKnowRequestButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            self.pathKnowBadgeImageView.isHidden = true
        }
        
        if searchResult.maplink == "" {
            self.kakaoMapButton.isHidden = true
        } else {
            self.kakaoMapButton.isHidden = false
        }
    }
}

// MARK: - Extension for selectors added
extension DispatchSearchTableViewCell {
    @objc func tappedPathKnowButton(_ sender: UIButton) {
        if self.searchResult?.know == "true" {
            guard let id = self.searchResult?.id else { return }
            self.delegate?.tapPathKnowDeleteButton(id: id, button: self.pathKnowRequestButton)
        } else {
            guard let id = self.searchResult?.id else { return }
            self.delegate?.tapPathKnowButton(id: id, button: self.pathKnowRequestButton)
        }
    }
    
    @objc func tappedPathKnowDeleteButton(_ sender: UIButton) {
        
    }
    
    @objc func tappedKakaoMapButton(_ sender: UIButton) {
        guard let mapLink = self.searchResult?.maplink else { return }
        
        self.delegate?.tapKakaoMapButton(mapLink: mapLink)
    }
}
