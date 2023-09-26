//
//  ServerInspectionViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/26.
//

import UIKit

final class ServerInspectionViewController: UIViewController {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ServerInspectionViewController: EssentialViewMethods {
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
        self.view.addSubview(self.backgroundView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // backgroundView
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.backgroundView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 16),
            self.backgroundView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.backgroundView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension ServerInspectionViewController {
    
}

// MARK: - Extension for selector methods
extension ServerInspectionViewController {
    
}
