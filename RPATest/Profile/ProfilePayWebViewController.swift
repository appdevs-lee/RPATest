//
//  ProfilePayWebViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/22/23.
//

import UIKit
import WebKit

final class ProfilePayWebViewController: UIViewController {
    
    // MARK: - WebView
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    init(html: String) {
        self.html = html
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var html: String
//    var htmlString: NSAttributedString
    
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
        self.startWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- RenewalProfileClauseViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ProfilePayWebViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
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
        self.view.addSubview(self.webView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // webView
        NSLayoutConstraint.activate([
            self.webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.webView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
        
        self.navigationItem.title = "급여명세서"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func startWebView() {
        self.webView.loadHTMLString(self.html, baseURL: nil)
        
    }
}

// MARK: - Extension for methods added
extension ProfilePayWebViewController {
    
}

// MARK: - Extension for selector methods
extension ProfilePayWebViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

