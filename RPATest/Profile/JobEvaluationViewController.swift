//
//  JobEvaluationViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2/1/24.
//

import UIKit

final class JobEvaluationViewController: UIViewController {
    
    lazy var pathKnowTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "노선숙지 68/200"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.asColor(targetString: "노선숙지", color: .black)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var pathKnowProgressView: UIProgressView = {
        let progressView = UIProgressView()
//        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.progressViewStyle = .bar
        progressView.progress = 68 / 200
        progressView.progressTintColor = .useRGB(red: 176, green: 0, blue: 32)
        progressView.trackTintColor = .useRGB(red: 189, green: 189, blue: 189)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    lazy var eduTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "CS교육 3/5"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.asColor(targetString: "CS교육", color: .black)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var eduProgressView: UIProgressView = {
        let progressView = UIProgressView()
//        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.progressViewStyle = .bar
        progressView.progress = 3 / 5
        progressView.progressTintColor = .useRGB(red: 176, green: 0, blue: 32)
        progressView.trackTintColor = .useRGB(red: 189, green: 189, blue: 189)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    lazy var carManageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "차량관리 17/23"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.asColor(targetString: "차량관리", color: .black)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var carManageProgressView: UIProgressView = {
        let progressView = UIProgressView()
//        progressView.layer.cornerRadius = 4
        progressView.clipsToBounds = true
        progressView.progressViewStyle = .bar
        progressView.progress = 17 / 23
        progressView.progressTintColor = .useRGB(red: 176, green: 0, blue: 32)
        progressView.trackTintColor = .useRGB(red: 189, green: 189, blue: 189)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
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
        print("----------------------------------- JobEvaluationViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension JobEvaluationViewController: EssentialViewMethods {
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
            self.pathKnowTitleLabel,
            self.pathKnowProgressView,
            self.eduTitleLabel,
            self.eduProgressView,
            self.carManageTitleLabel,
            self.carManageProgressView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // pathKnowTitleLabel
        NSLayoutConstraint.activate([
            self.pathKnowTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.pathKnowTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16)
        ])
        
        // pathKnowProgressView
        NSLayoutConstraint.activate([
            self.pathKnowProgressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.pathKnowProgressView.topAnchor.constraint(equalTo: self.pathKnowTitleLabel.bottomAnchor, constant: 8),
            self.pathKnowProgressView.heightAnchor.constraint(equalToConstant: 8),
            self.pathKnowProgressView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        // eduTitleLabel
        NSLayoutConstraint.activate([
            self.eduTitleLabel.leadingAnchor.constraint(equalTo: self.eduProgressView.leadingAnchor),
            self.eduTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16)
        ])
        
        // eduProgressView
        NSLayoutConstraint.activate([
            self.eduProgressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.eduProgressView.topAnchor.constraint(equalTo: self.eduTitleLabel.bottomAnchor, constant: 8),
            self.eduProgressView.heightAnchor.constraint(equalToConstant: 8),
            self.eduProgressView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        // carManageTitleLabel
        NSLayoutConstraint.activate([
            self.carManageTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.carManageTitleLabel.topAnchor.constraint(equalTo: self.pathKnowProgressView.bottomAnchor, constant: 10)
        ])
        
        // carManageProgressView
        NSLayoutConstraint.activate([
            self.carManageProgressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.carManageProgressView.topAnchor.constraint(equalTo: self.carManageTitleLabel.bottomAnchor, constant: 8),
            self.carManageProgressView.heightAnchor.constraint(equalToConstant: 8),
            self.carManageProgressView.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension JobEvaluationViewController {
    
}

// MARK: - Extension for selector methods
extension JobEvaluationViewController {
    
}

