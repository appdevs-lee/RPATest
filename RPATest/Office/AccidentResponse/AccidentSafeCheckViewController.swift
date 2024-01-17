//
//  AccidentSafeCheckViewController.swift
//  RPATest
//
//  Created by 이주성 on 1/17/24.
//

import UIKit

final class AccidentSafeCheckViewController: UIViewController {
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 1/7
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
        죄송합니다!\n
        상대차량과 접촉사고가 있었습니다.\n
        불편한 분 계신가요?\n
        탑승자 확인을 위해 명단 작성 부탁드립닌다.\n
        (추후 후유증 발생시 필요, 명단 작성 필수)\n\n

        방송 후,\n
        명단 작성 거부, 상대 차량의 위협, 고통 호소시 119 연락, 불이 날 시 일단 대피
        """
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
extension AccidentSafeCheckViewController: EssentialViewMethods {
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
        
        self.navigationItem.title = "1. 승객 안전 유무 확인"
        
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
extension AccidentSafeCheckViewController {
    
}

// MARK: - Extension for selector methods
extension AccidentSafeCheckViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        
        
    }
}
