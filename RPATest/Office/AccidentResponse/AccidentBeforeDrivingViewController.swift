//
//  AccidentBeforeDrivingViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/18/24.
//

import UIKit

final class AccidentBeforeDrivingViewController: UIViewController {
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 6/7
        view.trackTintColor = .useRGB(red: 233, green: 236, blue: 239)
        view.progressTintColor = .useRGB(red: 33, green: 37, blue: 41)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안내 문구"
        label.textColor = .black
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text =
        """
        경미한 사고일 경우,\n
        사고처리 완료하여 다시 운행하겠습니다!\n
        \n
        운행 재개가 어려운 사고일 경우,\n
        예비 차량이 오고 있으니, 잠시 기다려주시기 바랍니다.\n
        """
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = .black
        textView.font = .useFont(ofSize: 20 , weight: .Medium)
        textView.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        textView.layer.borderWidth = 1.0
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
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
    
    deinit {
        print("----------------------------------- AccidentSafeCheckViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension AccidentBeforeDrivingViewController: EssentialViewMethods {
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
            self.progressView,
            self.titleLabel,
            self.textView
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
        
        // textView
        NSLayoutConstraint.activate([
            self.textView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.textView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.textView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
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
        
        self.navigationItem.title = "6. 탑승객 안내 방송 재실시"
        
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
extension AccidentBeforeDrivingViewController {
    
}

// MARK: - Extension for selector methods
extension AccidentBeforeDrivingViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = AccidentLastFlowViewController()
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
