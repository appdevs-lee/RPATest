//
//  AccidentNameListViewController.swift
//  RPATest
//
//  Created by 이주성 on 1/17/24.
//

import UIKit

final class AccidentNameListViewController: UIViewController {
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 2/7
        view.trackTintColor = .useRGB(red: 233, green: 236, blue: 239)
        view.progressTintColor = .useRGB(red: 33, green: 37, blue: 41)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "승객 명단 촬영"
        label.textColor = .black
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var listImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "plus.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
        self.setUpNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- AccidentNameListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension AccidentNameListViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        self.listImageView.addGestureRecognizer(imageTap)
        self.listImageView.isUserInteractionEnabled = true
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.progressView,
            self.titleLabel,
            self.listImageView,
            self.plusImageView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.progressView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.progressView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 10),
        ])
        
        // listImageView
        NSLayoutConstraint.activate([
            self.listImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.listImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.listImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.listImageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
        ])
        
        // plusImageView
        NSLayoutConstraint.activate([
            self.plusImageView.centerYAnchor.constraint(equalTo: self.listImageView.centerYAnchor),
            self.plusImageView.centerXAnchor.constraint(equalTo: self.listImageView.centerXAnchor)
        ])
        
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "2. 승객 명단 작성"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        let rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        rightBarButtonItem.setTitleTextAttributes([
            .foregroundColor:UIColor.useRGB(red: 176, green: 0, blue: 32),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ], for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - Extension for methods added
extension AccidentNameListViewController {
    
}

// MARK: - Extension for selector methods
extension AccidentNameListViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = AccidentCallListViewController()
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        print("imageTapped")
        
    }
}
