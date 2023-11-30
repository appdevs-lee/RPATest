//
//  gasStationListTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 11/30/23.
//

import UIKit

final class GasStationListTableViewCell: UITableViewCell {
    
    lazy var gasStationNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
extension GasStationListTableViewCell {
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
        self.addSubview(self.gasStationNameLabel)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // vehicleNameLabel
        NSLayoutConstraint.activate([
            self.gasStationNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.gasStationNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.gasStationNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Extension for methods added
extension GasStationListTableViewCell {
    func setCell(gasStation: GasStationDetailItem) {
        self.gasStationNameLabel.text = gasStation.category
    }
}
