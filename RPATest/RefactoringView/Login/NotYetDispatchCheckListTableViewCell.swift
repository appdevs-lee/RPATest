//
//  NotYetDispatchCheckListTableViewCell.swift
//  RPATest
//
//  Created by 이주성 on 10/1/24.
//

import UIKit

final class NotYetDispatchCheckListTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.0
        view.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32, alpha: 0.5).cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchInfoView: DispatchInfoView = {
        let view = DispatchInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("배차 수락", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addAction(UIAction { _ in
            guard let item = self.item else { return }
            NotificationCenter.default.post(name: Notification.Name("DispatchAccept"), object: nil, userInfo: ["item": item])
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var refusalButton: UIButton = {
        let button = UIButton()
        button.setTitle("사유 작성", for: .normal)
        button.setTitleColor(.useRGB(red: 108, green: 108, blue: 108), for: .normal)
        button.setTitleColor(.useRGB(red: 108, green: 108, blue: 108, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.useRGB(red: 108, green: 108, blue: 108).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.addAction(UIAction { _ in
            guard let item = self.item else { return }
            NotificationCenter.default.post(name: Notification.Name("DispatchRefusal"), object: nil, userInfo: ["item": item])
        }, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var item: DailyDispatchDetailItem?
    
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
extension NotYetDispatchCheckListTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
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
            self.acceptButton,
            self.refusalButton,
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
        
        // acceptButton
        NSLayoutConstraint.activate([
            self.acceptButton.leadingAnchor.constraint(equalTo: self.moreSubView.leadingAnchor, constant: 16),
            self.acceptButton.topAnchor.constraint(equalTo: self.moreSubView.topAnchor, constant: 10),
            self.acceptButton.bottomAnchor.constraint(equalTo: self.moreSubView.bottomAnchor, constant: -10),
            self.acceptButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // refusalButton
        NSLayoutConstraint.activate([
            self.refusalButton.trailingAnchor.constraint(equalTo: self.moreSubView.trailingAnchor, constant: -16),
            self.refusalButton.topAnchor.constraint(equalTo: self.acceptButton.topAnchor),
            self.refusalButton.leadingAnchor.constraint(equalTo: self.acceptButton.trailingAnchor, constant: 10),
            self.refusalButton.heightAnchor.constraint(equalToConstant: 44),
            self.refusalButton.widthAnchor.constraint(equalTo: self.acceptButton.widthAnchor, multiplier: 1.0),
        ])

    }
}

// MARK: - Extension for methods added
extension NotYetDispatchCheckListTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        self.item = item
        
        self.dispatchInfoView.reloadData(item: item)
        
    }
    
}

// MARK: - Extension for selector added
extension NotYetDispatchCheckListTableViewCell {
    @objc func kakaoMapButton(_ sender: UIButton) {
        guard let mapLink = self.item?.maplink else { return }
        guard let url = URL(string: mapLink) else { return }
        
        UIApplication.shared.open(url)
        
    }
    
}
