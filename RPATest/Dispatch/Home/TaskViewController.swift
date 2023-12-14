//
//  TaskViewController.swift
//  RPATest
//
//  Created by Awesomepia on 12/14/23.
//

import UIKit

final class TaskViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dailyButton: UIButton = {
        let button = UIButton()
        button.setTitle("일일 점검", for: .normal)
        button.setTitleColor(.useRGB(red: 97, green: 97, blue: 97), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedDailyButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var weeklyButton: UIButton = {
        let button = UIButton()
        button.setTitle("주간 점검", for: .normal)
        button.setTitleColor(.useRGB(red: 97, green: 97, blue: 97), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedWeeklyButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var equipmentButton: UIButton = {
        let button = UIButton()
        button.setTitle("비품 점검", for: .normal)
        button.setTitleColor(.useRGB(red: 97, green: 97, blue: 97), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedEquipmentButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.useRGB(red: 97, green: 97, blue: 97), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedDoneButton(_:)), for: .touchUpInside)
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
        print("----------------------------------- TaskViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension TaskViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.4)
        
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
            self.baseView
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.dailyButton,
            self.weeklyButton,
            self.equipmentButton,
            self.doneButton
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.baseView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.baseView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
        
        // dailyButton
        NSLayoutConstraint.activate([
            self.dailyButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.dailyButton.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 16),
            self.dailyButton.widthAnchor.constraint(equalToConstant: 72),
            self.dailyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // weeklyButton
        NSLayoutConstraint.activate([
            self.weeklyButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.weeklyButton.topAnchor.constraint(equalTo: self.dailyButton.bottomAnchor, constant: 16),
            self.weeklyButton.widthAnchor.constraint(equalToConstant: 72),
            self.weeklyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // equipmentButton
        NSLayoutConstraint.activate([
            self.equipmentButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.equipmentButton.topAnchor.constraint(equalTo: self.weeklyButton.bottomAnchor, constant: 16),
            self.equipmentButton.bottomAnchor.constraint(equalTo: self.doneButton.topAnchor, constant: -16),
            self.equipmentButton.widthAnchor.constraint(equalToConstant: 72),
            self.equipmentButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.doneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - Extension for methods added
extension TaskViewController {
    
}

// MARK: - Extension for selector methods
extension TaskViewController {
    @objc func tappedDailyButton(_ sender: UIButton) {
        let vc = DispatchInspectionViewController(type: .daily, carNumber: "Test")
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    @objc func tappedWeeklyButton(_ sender: UIButton) {
        let vc = DispatchInspectionViewController(type: .weekly, carNumber: "Test")
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
    @objc func tappedEquipmentButton(_ sender: UIButton) {
        let vc = DispatchInspectionViewController(type: .equipment, carNumber: "Test")
        
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
}

