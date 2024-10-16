//
//  RenewalMonthlyDispatchTableViewCell.swift
//  RPATest
//
//  Created by 이주성 on 10/16/24.
//

import UIKit

final class RenewalMonthlyDispatchTableViewCell: UITableViewCell {
    
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
    
    lazy var dispatchInfoView: DispatchInfoView = {
        let view = DispatchInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 235, green: 235, blue: 235)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var coverLabel: UILabel = {
        let label = UILabel()
        label.text = "제출 완료"
        label.textColor = .white
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var moreSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // 배차 수락
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("배차 수락", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addAction(UIAction { _ in
            guard let item = self.item else { return }
            NotificationCenter.default.post(name: Notification.Name("DispatchAccept"), object: nil, userInfo: ["item": item])
        }, for: .touchUpInside)
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
        button.addAction(UIAction { _ in
            guard let item = self.item else { return }
            NotificationCenter.default.post(name: Notification.Name("DispatchRefusal"), object: nil, userInfo: ["item": item])
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // 운행 일보
    lazy var referenceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "참조 사항"
        label.textColor = .useRGB(red: 168, green: 168, blue: 168)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var referenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 111, green: 111, blue: 111)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var activeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .useRGB(red: 235, green: 235, blue: 235)
        config.background.cornerRadius = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8)
        
        var attributedString = AttributedString("자세히")
        attributedString.font = .useFont(ofSize: 14, weight: .Medium)
        attributedString.foregroundColor = .useRGB(red: 111, green: 111, blue: 111)
        config.attributedTitle = attributedString
        
        let button = UIButton(configuration: config)
        button.configurationUpdateHandler = { button in
            switch button.state {
            case .normal: break
            case .highlighted:
                config.attributedTitle?.foregroundColor = .useRGB(red: 111, green: 111, blue: 111, alpha: 0.5)
                
            default: break
            }
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var item: DailyDispatchDetailItem?
    
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
extension RenewalMonthlyDispatchTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
        self.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
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
            self.dispatchInfoView,
            self.separateView,
            self.moreSubView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.acceptButton,
            self.refusalButton,
            self.coverView,
            
            self.referenceTitleLabel,
            self.referenceLabel,
            self.activeButton,
        ], to: self.moreSubView)
        
        SupportingMethods.shared.addSubviews([
            self.coverLabel,
        ], to: self.coverView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
        
        // dispatchInfoView
        NSLayoutConstraint.activate([
            self.dispatchInfoView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.dispatchInfoView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.dispatchInfoView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.separateView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.separateView.topAnchor.constraint(equalTo: self.dispatchInfoView.bottomAnchor),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // coverView
        NSLayoutConstraint.activate([
            self.coverView.leadingAnchor.constraint(equalTo: self.moreSubView.leadingAnchor),
            self.coverView.trailingAnchor.constraint(equalTo: self.moreSubView.trailingAnchor),
            self.coverView.topAnchor.constraint(equalTo: self.moreSubView.topAnchor),
            self.coverView.bottomAnchor.constraint(equalTo: self.moreSubView.bottomAnchor),
        ])
        
        // coverLabel
        NSLayoutConstraint.activate([
            self.coverLabel.centerYAnchor.constraint(equalTo: self.coverView.centerYAnchor),
            self.coverLabel.centerXAnchor.constraint(equalTo: self.coverView.centerXAnchor),
        ])
        
        // moreSubView
        NSLayoutConstraint.activate([
            self.moreSubView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.moreSubView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.moreSubView.topAnchor.constraint(equalTo: self.separateView.bottomAnchor),
            self.moreSubView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
        ])
        
        // 배차 수락
        // acceptButton
        NSLayoutConstraint.activate([
            self.acceptButton.leadingAnchor.constraint(equalTo: self.moreSubView.leadingAnchor, constant: 16),
            self.acceptButton.topAnchor.constraint(equalTo: self.moreSubView.topAnchor, constant: 10),
            self.acceptButton.bottomAnchor.constraint(equalTo: self.moreSubView.bottomAnchor, constant: -10),
            self.acceptButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // refusalButton
        NSLayoutConstraint.activate([
            self.refusalButton.trailingAnchor.constraint(equalTo: self.moreSubView.trailingAnchor, constant: -16),
            self.refusalButton.topAnchor.constraint(equalTo: self.acceptButton.topAnchor),
            self.refusalButton.leadingAnchor.constraint(equalTo: self.acceptButton.trailingAnchor, constant: 10),
            self.refusalButton.heightAnchor.constraint(equalToConstant: 44),
            self.refusalButton.widthAnchor.constraint(equalTo: self.acceptButton.widthAnchor, multiplier: 1.0),
        ])
        
        // 운행일보
        // referenceTitleLabel
        NSLayoutConstraint.activate([
            self.referenceTitleLabel.leadingAnchor.constraint(equalTo: self.moreSubView.leadingAnchor, constant: 16),
            self.referenceTitleLabel.topAnchor.constraint(equalTo: self.moreSubView.topAnchor, constant: 10),
        ])
        
        // referenceLabel
        NSLayoutConstraint.activate([
            self.referenceLabel.leadingAnchor.constraint(equalTo: self.moreSubView.leadingAnchor, constant: 16),
            self.referenceLabel.topAnchor.constraint(equalTo: self.referenceTitleLabel.bottomAnchor, constant: 10),
            self.referenceLabel.bottomAnchor.constraint(equalTo: self.moreSubView.bottomAnchor, constant: -10),
        ])
        
        // activeButton
        NSLayoutConstraint.activate([
            self.activeButton.leadingAnchor.constraint(equalTo: self.referenceLabel.trailingAnchor, constant: 10),
            self.activeButton.trailingAnchor.constraint(equalTo: self.moreSubView.trailingAnchor, constant: -16),
            self.activeButton.centerYAnchor.constraint(equalTo: self.moreSubView.centerYAnchor),
            self.activeButton.widthAnchor.constraint(equalToConstant: 60),
            self.activeButton.heightAnchor.constraint(equalToConstant: 36),
        ])

    }
}

// MARK: - Extension for methods added
extension RenewalMonthlyDispatchTableViewCell {
    func setCell(item: DailyDispatchDetailItem, status: CalendarStatus) {
        self.item = item
        
        self.dispatchInfoView.reloadData(item: item)
        
        if let connect = item.checkRegularlyConnect {
            if connect.connectCheck == "" {
                self.coverView.isHidden = true
                
            } else {
                self.coverView.isHidden = false
                
            }
            
        } else if let connect = item.checkOrderConnect {
            if connect.connectCheck == "" {
                self.coverView.isHidden = true
                
            } else {
                self.coverView.isHidden = true
                
            }
            
        }
        
        if status == .runningDiary {
            // 운행일보
            self.coverView.isHidden = true
            self.acceptButton.isHidden = true
            self.refusalButton.isHidden = true
            
            self.referenceTitleLabel.isHidden = false
            self.referenceLabel.isHidden = false
            self.activeButton.isHidden = false
            
            self.referenceLabel.text = item.references
            
        } else {
            // 배차수락
            self.acceptButton.isHidden = false
            self.refusalButton.isHidden = false
            
            self.referenceTitleLabel.isHidden = true
            self.referenceLabel.isHidden = true
            self.activeButton.isHidden = true
            
        }
        
    }
}
