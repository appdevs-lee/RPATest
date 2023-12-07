//
//  MorningRollCallTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 12/7/23.
//

import UIKit

enum RollCallStatus: Int {
    case fine = 0
    case notFine = 1
    
    var status: String {
        switch self {
        case .fine:
            return "양호"
            
        case .notFine:
            return "이상"
            
        }
    }
}

final class MorningRollCallTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var selectBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        view.layer.borderWidth = 1.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.fineButton, self.notFineButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var fineButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22
        button.setTitle("양호", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedFineButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var notFineButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 22
        button.setTitle("이상", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        button.addTarget(self, action: #selector(tappedNotFineButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var selectedCellInfo: (index: Int, status: RollCallStatus) = (index: 0, status: .fine)
    
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
extension MorningRollCallTableViewCell {
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
            self.buttonStackView
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
        
        // buttonStackView
        NSLayoutConstraint.activate([
            self.buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.buttonStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
        ])
        
        // fineButton
        NSLayoutConstraint.activate([
            self.fineButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // notFineButton
        NSLayoutConstraint.activate([
            self.notFineButton.heightAnchor.constraint(equalToConstant: 44),
            self.notFineButton.widthAnchor.constraint(equalTo: self.fineButton.widthAnchor, multiplier: 1.0)
        ])
        
    }
}

// MARK: - Extension for methods added
extension MorningRollCallTableViewCell {
    func setCell(title: String, index: Int) {
        self.titleLabel.text = title
        
        self.selectedCellInfo.index = index
        
    }
}

// MARK: - Extension for selector added
extension MorningRollCallTableViewCell {
    @objc func tappedFineButton(_ sender: UIButton) {
        self.selectedCellInfo.status = RollCallStatus.fine
        
        self.fineButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        self.notFineButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        
        NotificationCenter.default.post(name: Notification.Name("MorningRollCallStatus"), object: nil, userInfo: ["selectedCellInfo": self.selectedCellInfo])
    }
    
    @objc func tappedNotFineButton(_ sender: UIButton) {
        self.selectedCellInfo.status = RollCallStatus.notFine
        
        self.notFineButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        self.fineButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        
        NotificationCenter.default.post(name: Notification.Name("MorningRollCallStatus"), object: nil, userInfo: ["selectedCellInfo": self.selectedCellInfo])
    }
}
