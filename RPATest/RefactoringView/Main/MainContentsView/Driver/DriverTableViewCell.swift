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
            self.moreSubView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

// MARK: - Extension for methods added
extension DriverTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        self.dispatchInfoView.reloadData(item: item)
        
    }
    
}
