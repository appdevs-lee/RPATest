//
//  DrivingAnalysisViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2/1/24.
//

import UIKit

final class DrivingAnalysisViewController: UIViewController {
    
    lazy var yearAnalysisButton: UIButton = {
        let button = UIButton()
        button.setTitle("연간", for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var monthAnalysisButton: UIButton = {
        let button = UIButton()
        button.setTitle("월간", for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        button.layer.borderWidth = 1.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dayAnalysisButton: UIButton = {
        let button = UIButton()
        button.setTitle("일간", for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: #selector(dayAnalysisButton(_:)), for: .touchUpInside)
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
        print("----------------------------------- DrivingAnalysisViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DrivingAnalysisViewController: EssentialViewMethods {
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
            self.yearAnalysisButton,
            self.monthAnalysisButton,
            self.dayAnalysisButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // yearAnalysisButton
        NSLayoutConstraint.activate([
            self.yearAnalysisButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.yearAnalysisButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.yearAnalysisButton.heightAnchor.constraint(equalToConstant: 30),
            self.yearAnalysisButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // monthAnalysisButton
        NSLayoutConstraint.activate([
            self.monthAnalysisButton.leadingAnchor.constraint(equalTo: self.yearAnalysisButton.trailingAnchor, constant: 10),
            self.monthAnalysisButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.monthAnalysisButton.heightAnchor.constraint(equalToConstant: 30),
            self.monthAnalysisButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // dayAnalysisButton
        NSLayoutConstraint.activate([
            self.dayAnalysisButton.leadingAnchor.constraint(equalTo: self.monthAnalysisButton.trailingAnchor, constant: 16),
            self.dayAnalysisButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.dayAnalysisButton.heightAnchor.constraint(equalToConstant: 30),
            self.dayAnalysisButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension DrivingAnalysisViewController {
    
}

// MARK: - Extension for selector methods
extension DrivingAnalysisViewController {
    @objc func dayAnalysisButton(_ sender: UIButton) {
        let vc = DayAnalysisViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

