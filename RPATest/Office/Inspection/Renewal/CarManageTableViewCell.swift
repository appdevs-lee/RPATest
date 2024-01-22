//
//  CarManageTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/22/24.
//

import UIKit

final class CarManageTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    
    lazy var detailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "DayRightButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
extension CarManageTableViewCell {
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
            self.baseView,
            self.statusLabel,
            self.titleLabel,
            self.detailButton
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
//            self.baseView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // statusLabel
        NSLayoutConstraint.activate([
            self.statusLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.statusLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 10),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 8),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -10)
        ])
        
        // detailButton
        NSLayoutConstraint.activate([
            self.detailButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.detailButton.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.detailButton.heightAnchor.constraint(equalToConstant: 36),
            self.detailButton.widthAnchor.constraint(equalToConstant: 36)
        ])
    }
}

// MARK: - Extension for methods added
extension CarManageTableViewCell {
    func setCell(data: CarManage) {
        self.titleLabel.text = data.title
        
        if data.status {
            self.statusLabel.text = "점검 여부: 완료"
            self.statusLabel.asFontColor(targetString: "완료", font: .useFont(ofSize: 18, weight: .Bold), color: .blue)
            
        } else {
            self.statusLabel.text = "점검 여부: 미완료"
            self.statusLabel.asFontColor(targetString: "미완료", font: .useFont(ofSize: 18, weight: .Bold), color: .red)
            
        }
    }
}

