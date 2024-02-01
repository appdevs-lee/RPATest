//
//  CardViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2/1/24.
//

import UIKit

final class CardViewController: UIViewController {
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Card")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    lazy var cardNameLabel: UILabel = {
       let label = UILabel()
        label.text = UserInfo.shared.name
        label.textColor = .black
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var cardPhoneNumberLabel: UILabel = {
       let label = UILabel()
        label.text = UserInfo.shared.phoneNumber
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var cardShareButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedCardShareButton(_:)), for: .touchUpInside)
        button.setTitle("공유", for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- CardViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CardViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.cardView,
            self.cardShareButton
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.cardImageView,
            self.cardNameLabel,
            self.cardPhoneNumberLabel
        ], to: self.cardView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // cardView
        NSLayoutConstraint.activate([
            self.cardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.cardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.cardView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.cardView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        // cardImageView
        NSLayoutConstraint.activate([
            self.cardImageView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor),
            self.cardImageView.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor),
            self.cardImageView.topAnchor.constraint(equalTo: self.cardView.topAnchor),
            self.cardImageView.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor)
        ])
        
        // cardNameLabel
        NSLayoutConstraint.activate([
            self.cardNameLabel.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -16),
            self.cardNameLabel.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 32)
        ])
        
        // cardPhoneNumberLabel
        NSLayoutConstraint.activate([
            self.cardPhoneNumberLabel.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -16),
            self.cardPhoneNumberLabel.topAnchor.constraint(equalTo: self.cardNameLabel.bottomAnchor, constant: 8)
        ])
        
        // cardShareButton
        NSLayoutConstraint.activate([
            self.cardShareButton.centerXAnchor.constraint(equalTo: self.cardView.centerXAnchor),
            self.cardShareButton.topAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: 10),
            self.cardShareButton.heightAnchor.constraint(equalToConstant: 36),
            self.cardShareButton.widthAnchor.constraint(equalToConstant: 73),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension CardViewController {
    
}

// MARK: - Extension for selector methods
extension CardViewController {
    @objc func tappedCardShareButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        guard let image = self.cardView.transfromToImage() else {
            SupportingMethods.shared.turnCoverView(.off)
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        vc.excludedActivityTypes = [.saveToCameraRoll]
        self.present(vc, animated: true) {
            SupportingMethods.shared.turnCoverView(.off)
        }
    }
}
