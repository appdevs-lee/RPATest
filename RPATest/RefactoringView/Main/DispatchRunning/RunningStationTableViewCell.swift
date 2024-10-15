//
//  RunningStationTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/15/24.
//

import UIKit

final class RunningStationTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var stationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("departureLocationImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var stationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 94, green: 94, blue: 94)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        button.imageView?.tintColor = .useRGB(red: 255, green: 65, blue: 65)
        button.addTarget(self, action: #selector(minusButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.imageView?.tintColor = .useRGB(red: 35, green: 162, blue: 77)
        button.addTarget(self, action: #selector(plusButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .useRGB(red: 94, green: 94, blue: 94)
        label.font = .useFont(ofSize: 20, weight: .Medium)
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
extension RunningStationTableViewCell {
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
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.stationImageView,
            self.stationLabel,
            self.minusButton,
            self.numberLabel,
            self.plusButton,
        ], to: self.baseView)
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
            self.baseView.heightAnchor.constraint(equalToConstant: 90),
        ])
        
        // stationImageView
        NSLayoutConstraint.activate([
            self.stationImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.stationImageView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.stationImageView.heightAnchor.constraint(equalToConstant: 12),
            self.stationImageView.widthAnchor.constraint(equalToConstant: 12),
        ])
        
        // stationLabel
        NSLayoutConstraint.activate([
            self.stationLabel.leadingAnchor.constraint(equalTo: self.stationImageView.trailingAnchor, constant: 10),
            self.stationLabel.centerYAnchor.constraint(equalTo: self.stationImageView.centerYAnchor),
        ])
        
        // minusButton
        NSLayoutConstraint.activate([
            self.minusButton.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.minusButton.heightAnchor.constraint(equalToConstant: 30),
            self.minusButton.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        // numberLabel
        NSLayoutConstraint.activate([
            self.numberLabel.leadingAnchor.constraint(equalTo: self.minusButton.trailingAnchor, constant: 10),
            self.numberLabel.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.numberLabel.trailingAnchor.constraint(equalTo: self.plusButton.leadingAnchor, constant: -10),
        ])
        
        // plusButton
        NSLayoutConstraint.activate([
            self.plusButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.plusButton.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.plusButton.heightAnchor.constraint(equalToConstant: 30),
            self.plusButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}

// MARK: - Extension for methods added
extension RunningStationTableViewCell {
    func setCell(station: String) {
        self.stationLabel.text = station
        
    }
    
}

// MARK: - Extension for selector added
extension RunningStationTableViewCell {
    @objc func minusButton(_ sender: UIButton) {
        var number = Int(self.numberLabel.text ?? "0")!
        
        if number != 0 {
            number -= 1
            
        }
        
        self.numberLabel.text = "\(number)"
    }
    
    @objc func plusButton(_ sender: UIButton) {
        var number = Int(self.numberLabel.text ?? "0")!
        
        number += 1
        
        self.numberLabel.text = "\(number)"
    }
    
}
