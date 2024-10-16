//
//  DriverTableViewCell.swift
//  RPATest
//
//  Created by 이주성 on 10/5/24.
//

import UIKit

final class DriverTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchInfoView: DispatchInfoView = {
        let dispatchInfoView = DispatchInfoView()
        dispatchInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        return dispatchInfoView
    }()
    
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 235, green: 235, blue: 235)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var moreSubView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
extension DriverTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchInfoView,
            self.separateView,
            self.moreSubView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.referenceTitleLabel,
            self.referenceLabel,
            self.activeButton,
        ], to: self.moreSubView)
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
        
        // moreSubView
        NSLayoutConstraint.activate([
            self.moreSubView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.moreSubView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.moreSubView.topAnchor.constraint(equalTo: self.separateView.bottomAnchor),
            self.moreSubView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
        ])
        
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
            self.activeButton.heightAnchor.constraint(equalToConstant: 36),
            self.activeButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Extension for methods added
extension DriverTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        self.dispatchInfoView.reloadData(item: item)
        self.referenceLabel.text = item.references == "" ? "없음" : item.references
        
    }
    
}
