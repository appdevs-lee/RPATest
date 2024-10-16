//
//  RunningInputTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/11/24.
//

import UIKit

final class RunningInputTableViewCell: UITableViewCell {
    
    lazy var baseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.baseView, self.diaryView, self.stationView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var diaryView: RunningDiaryView = {
        let view = RunningDiaryView()
        view.isHidden = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var stationView: RunningStationView = {
        let view = RunningStationView()
        view.isHidden = true
        view.backgroundColor = .white
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
extension RunningInputTableViewCell {
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
            self.baseStackView,
        ], to: self)
        
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseStackView
        NSLayoutConstraint.activate([
            self.baseStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

// MARK: - Extension for methods added
extension RunningInputTableViewCell {
    func setCell(diaryItem: RunningDiaryItem?) {
        self.diaryView.reloadData(diaryItem: diaryItem)
        
    }
    
}

