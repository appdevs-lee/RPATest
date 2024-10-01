//
//  NotYetDispatchCheckListTableViewCell.swift
//  RPATest
//
//  Created by 이주성 on 10/1/24.
//

import UIKit

final class NotYetDispatchCheckListTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.0
        view.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32, alpha: 0.5).cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var baseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.regularlyView, self.commonView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var regularlyView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 10
        view.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
//        view.backgroundColor = .useRGB(red: 220, green: 77, blue: 65)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var routeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 229, green: 229, blue: 229)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var kakaoMapButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("KakaoMapLogo"), for: .normal)
        button.setImage(.useCustomImage("SelectedKakaoMapLogo"), for: .highlighted)
        button.addTarget(self, action: #selector(kakaoMapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var commonView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pathStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.departureLabel, self.dispatchCheckImageView, self.arrivalLabel])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("DispatchCheckImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var busIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("배차 수락", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var refusalButton: UIButton = {
        let button = UIButton()
        button.setTitle("사유 작성", for: .normal)
        button.setTitleColor(.useRGB(red: 108, green: 108, blue: 108), for: .normal)
        button.setTitleColor(.useRGB(red: 108, green: 108, blue: 108, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.useRGB(red: 108, green: 108, blue: 108).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
extension NotYetDispatchCheckListTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.baseStackView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.groupLabel,
            self.routeLabel,
            self.kakaoMapButton,
        ], to: self.regularlyView)
        
        SupportingMethods.shared.addSubviews([
            self.pathStackView,
            self.departureDateLabel,
            self.busIdLabel,
            self.arrivalDateLabel,
            self.acceptButton,
            self.refusalButton,
        ], to: self.commonView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // baseStackView
        NSLayoutConstraint.activate([
            self.baseStackView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.baseStackView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.baseStackView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.baseStackView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
        ])
        
        // groupLabel
        NSLayoutConstraint.activate([
            self.groupLabel.leadingAnchor.constraint(equalTo: self.regularlyView.leadingAnchor, constant: 16),
            self.groupLabel.topAnchor.constraint(equalTo: self.regularlyView.topAnchor, constant: 10),
        ])
        
        // routeLabel
        NSLayoutConstraint.activate([
            self.routeLabel.leadingAnchor.constraint(equalTo: self.groupLabel.leadingAnchor),
            self.routeLabel.topAnchor.constraint(equalTo: self.groupLabel.bottomAnchor, constant: 5),
            self.routeLabel.bottomAnchor.constraint(equalTo: self.regularlyView.bottomAnchor, constant: -10)
        ])
        
        // kakaoMapButton
        NSLayoutConstraint.activate([
            self.kakaoMapButton.trailingAnchor.constraint(equalTo: self.regularlyView.trailingAnchor, constant: -16),
            self.kakaoMapButton.centerYAnchor.constraint(equalTo: self.regularlyView.centerYAnchor),
            self.kakaoMapButton.heightAnchor.constraint(equalToConstant: 40),
            self.kakaoMapButton.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        // pathStackView
        NSLayoutConstraint.activate([
            self.pathStackView.leadingAnchor.constraint(equalTo: self.commonView.leadingAnchor, constant: 10),
            self.pathStackView.trailingAnchor.constraint(equalTo: self.commonView.trailingAnchor, constant: -10),
            self.pathStackView.topAnchor.constraint(equalTo: self.commonView.topAnchor, constant: 25),
        ])
        
        // dispatchCheckImageView
        NSLayoutConstraint.activate([
            self.dispatchCheckImageView.heightAnchor.constraint(equalToConstant: 28),
            self.dispatchCheckImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        // departureDateLabel
        NSLayoutConstraint.activate([
            self.departureDateLabel.leadingAnchor.constraint(equalTo: self.departureLabel.leadingAnchor),
            self.departureDateLabel.topAnchor.constraint(equalTo: self.pathStackView.bottomAnchor, constant: 10),
        ])
        
        // busIdLabel
        NSLayoutConstraint.activate([
            self.busIdLabel.centerXAnchor.constraint(equalTo: self.dispatchCheckImageView.centerXAnchor),
            self.busIdLabel.topAnchor.constraint(equalTo: self.pathStackView.bottomAnchor, constant: 10),
        ])
        
        // arrivalDateLabel
        NSLayoutConstraint.activate([
            self.arrivalDateLabel.trailingAnchor.constraint(equalTo: self.arrivalLabel.trailingAnchor),
            self.arrivalDateLabel.topAnchor.constraint(equalTo: self.pathStackView.bottomAnchor, constant: 10),
        ])
        
        // acceptButton
        NSLayoutConstraint.activate([
            self.acceptButton.leadingAnchor.constraint(equalTo: self.commonView.leadingAnchor, constant: 16),
            self.acceptButton.topAnchor.constraint(equalTo: self.departureDateLabel.bottomAnchor, constant: 25),
            self.acceptButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // refusalButton
        NSLayoutConstraint.activate([
            self.refusalButton.trailingAnchor.constraint(equalTo: self.commonView.trailingAnchor, constant: -16),
            self.refusalButton.topAnchor.constraint(equalTo: self.acceptButton.topAnchor),
            self.refusalButton.leadingAnchor.constraint(equalTo: self.acceptButton.trailingAnchor, constant: 10),
            self.refusalButton.heightAnchor.constraint(equalToConstant: 44),
            self.refusalButton.widthAnchor.constraint(equalTo: self.acceptButton.widthAnchor, multiplier: 1.0),
            self.refusalButton.bottomAnchor.constraint(equalTo: self.commonView.bottomAnchor, constant: -25),
        ])

    }
}

// MARK: - Extension for methods added
extension NotYetDispatchCheckListTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        if let _ = item.checkRegularlyConnect {
            // regularly
            self.regularlyView.isHidden = false
            self.groupLabel.text = "\(item.group!)"
            self.routeLabel.text = "\(item.route!)"
            self.mapLink = item.maplink
            
        } else {
            // order
            self.regularlyView.isHidden = true
            
        }
        
        self.departureLabel.text = item.departure
        self.arrivalLabel.text = item.arrival
        
        let tempDepartureDate = SupportingMethods.shared.convertString(intoDate: item.departureDate, "yyyy-MM-dd HH:mm")
        let tempArrivalDate = SupportingMethods.shared.convertString(intoDate: item.arrivalDate, "yyyy-MM-dd HH:mm")
        
        self.departureDateLabel.text = SupportingMethods.shared.convertDate(intoString: tempDepartureDate, "a hh:mm")
        self.arrivalDateLabel.text = SupportingMethods.shared.convertDate(intoString: tempArrivalDate, "a hh:mm")
        
        self.busIdLabel.text = "\(item.busId)"
        
    }
    
}

// MARK: - Extension for selector added
extension NotYetDispatchCheckListTableViewCell {
    @objc func kakaoMapButton(_ sender: UIButton) {
        guard let url = URL(string: self.mapLink) else { return }
        UIApplication.shared.open(url)
        
    }
    
}
