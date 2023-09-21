//
//  InspectionVehicleListTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

final class InspectionVehicleListTableViewCell: UITableViewCell {
    
    lazy var vehicleNameLabel: UILabel = {
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
extension InspectionVehicleListTableViewCell {
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
        self.addSubview(self.vehicleNameLabel)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // vehicleNameLabel
        NSLayoutConstraint.activate([
            self.vehicleNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.vehicleNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.vehicleNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}

// MARK: - Extension for methods added
extension InspectionVehicleListTableViewCell {
    func setCell(vehicle: VehicleListItem) {
        self.vehicleNameLabel.text = "\(vehicle.vehicleNameKr) \(vehicle.vehicleNum)"
    }
}
