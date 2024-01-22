//
//  CarManageInspectionTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/22/24.
//

import UIKit

enum InspectionStatus {
    case fine
    case normal
    case notFine
}

final class CarManageInspectionTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var buttonBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var fineButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.setImage(UIImage(systemName: "circlebadge"), for: .normal)
        button.tintColor = .useRGB(red: 255, green: 255, blue: 255)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var normalButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .useRGB(red: 255, green: 255, blue: 255)
        button.setImage(UIImage(systemName: "triangle"), for: .normal)
        button.tintColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var notFineButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .useRGB(red: 255, green: 255, blue: 255)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    weak var delegate: DispatchInspectionDelegate?
    
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
extension CarManageInspectionTableViewCell {
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
            self.titleLabel,
            self.buttonBaseView
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.fineButton,
            self.normalButton,
            self.notFineButton
        ], to: self.buttonBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.buttonBaseView.centerYAnchor)
        ])
        
        // buttonBaseView
        NSLayoutConstraint.activate([
            self.buttonBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.buttonBaseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.buttonBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.buttonBaseView.widthAnchor.constraint(equalToConstant: 120),
            self.buttonBaseView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // fineButton
        NSLayoutConstraint.activate([
            self.fineButton.leadingAnchor.constraint(equalTo: self.buttonBaseView.leadingAnchor),
            self.fineButton.topAnchor.constraint(equalTo: self.buttonBaseView.topAnchor),
            self.fineButton.bottomAnchor.constraint(equalTo: self.buttonBaseView.bottomAnchor),
            self.fineButton.widthAnchor.constraint(equalToConstant: 40),
            self.fineButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // normalButton
        NSLayoutConstraint.activate([
            self.normalButton.leadingAnchor.constraint(equalTo: self.fineButton.trailingAnchor),
            self.normalButton.topAnchor.constraint(equalTo: self.buttonBaseView.topAnchor),
            self.normalButton.bottomAnchor.constraint(equalTo: self.buttonBaseView.bottomAnchor),
            self.normalButton.widthAnchor.constraint(equalToConstant: 40),
            self.normalButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // notFineButton
        NSLayoutConstraint.activate([
            self.notFineButton.leadingAnchor.constraint(equalTo: self.normalButton.trailingAnchor),
            self.notFineButton.trailingAnchor.constraint(equalTo: self.buttonBaseView.trailingAnchor),
            self.notFineButton.topAnchor.constraint(equalTo: self.buttonBaseView.topAnchor),
            self.notFineButton.bottomAnchor.constraint(equalTo: self.buttonBaseView.bottomAnchor),
            self.notFineButton.widthAnchor.constraint(equalToConstant: 40),
            self.notFineButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}

// MARK: - Extension for methods added
extension CarManageInspectionTableViewCell {
    func setCell(title: String, status: InspectionStatus) {
        self.titleLabel.text = title
        
        self.fineButton.backgroundColor = .white
        self.fineButton.tintColor = .useRGB(red: 176, green: 0, blue: 32)
        self.normalButton.backgroundColor = .white
        self.normalButton.tintColor = .useRGB(red: 176, green: 0, blue: 32)
        self.notFineButton.backgroundColor = .white
        self.notFineButton.tintColor = .useRGB(red: 176, green: 0, blue: 32)
        
        switch status {
        case .fine:
            self.fineButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            self.fineButton.tintColor = .white
        case .normal:
            self.normalButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            self.normalButton.tintColor = .white
        case .notFine:
            self.notFineButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            self.notFineButton.tintColor = .white
        default:
            break
        }
    }
    
}
