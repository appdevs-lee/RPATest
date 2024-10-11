//
//  RunningReferenceTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/11/24.
//

import UIKit

final class RunningReferenceTableViewCell: UITableViewCell {
    
    lazy var referenceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "참조 사항"
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var referenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
extension RunningReferenceTableViewCell {
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
            self.referenceTitleLabel,
            self.referenceLabel,
            self.bottomBorderView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // referenceTitleLabel
        NSLayoutConstraint.activate([
            self.referenceTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.referenceTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        ])
        
        // referenceLabel
        NSLayoutConstraint.activate([
            self.referenceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.referenceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.referenceLabel.topAnchor.constraint(equalTo: self.referenceTitleLabel.bottomAnchor, constant: 16),
        ])
        
        // bottomBorderView
        NSLayoutConstraint.activate([
            self.bottomBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomBorderView.topAnchor.constraint(equalTo: self.referenceLabel.bottomAnchor, constant: 20),
            self.bottomBorderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomBorderView.heightAnchor.constraint(equalToConstant: 5),
        ])
    }
}

// MARK: - Extension for methods added
extension RunningReferenceTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        self.referenceLabel.text = "\(item.references)"
        
    }
}

