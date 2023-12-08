//
//  SelectTimeViewController.swift
//  RPATest
//
//  Created by Awesomepia on 12/8/23.
//

import UIKit

final class SelectTimeViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 22, weight: .Bold)
        button.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(tappedCancelButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 22, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(tappedCheckButton(_:)), for: .touchUpInside)
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
        print("----------------------------------- SelectTimeViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension SelectTimeViewController: EssentialViewMethods {
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
            self.datePicker,
            self.cancelButton,
            self.checkButton
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 55),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -55),
            self.baseView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.baseView.widthAnchor.constraint(equalToConstant: 320),
            self.baseView.heightAnchor.constraint(equalToConstant: 384)
        ])
        
        // datePicker
        NSLayoutConstraint.activate([
            self.datePicker.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 28),
            self.datePicker.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 0),
            self.datePicker.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: 0)
        ])
        
        // cancelButton
        NSLayoutConstraint.activate([
            self.cancelButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.cancelButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -16),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 140),
            self.cancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.leadingAnchor.constraint(equalTo: self.cancelButton.trailingAnchor, constant: 8),
            self.checkButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.checkButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -16),
            self.checkButton.widthAnchor.constraint(equalTo: self.cancelButton.widthAnchor, multiplier: 1.0),
            self.checkButton.heightAnchor.constraint(equalTo: self.cancelButton.heightAnchor, multiplier: 1.0)
        ])
        
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - Extension for methods added
extension SelectTimeViewController {
    
}

// MARK: - Extension for selector methods
extension SelectTimeViewController {
    @objc func tappedCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    @objc func tappedCheckButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("SelectTime"), object: nil, userInfo: ["time": SupportingMethods.shared.convertDate(intoString: self.datePicker.date, "HH:mm")])
            
        }
    }
}

