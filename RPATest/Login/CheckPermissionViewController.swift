//
//  CheckPermissionViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit
import CoreLocation

final class CheckPermissionViewController: UIViewController {
    
    let commonModel = CommonModel()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Pop Slide
//        if self.navigationController?.viewControllers.first === self  {
//            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        }
        
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
    
    @IBAction func tapCheckButton(_ sender: UIButton) {
        self.commonModel.registerForPushNotifications {
            self.commonModel.checkAlbumPermission { result in
                self.locationManager.delegate = self
                
                print("\(self.locationManager.authorizationStatus)")
                if self.locationManager.authorizationStatus != .notDetermined {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true) {
                            UserDefaults.standard.set("Check", forKey: "CheckPermission")
                            NotificationCenter.default.post(name: Notification.Name("PermissionComplete"), object: nil)
                            
                        }
                        
                    }

                } else {
                    self.locationManager.requestWhenInUseAuthorization()
                    
                }

            }
        }
    }
    
    deinit {
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CheckPermissionViewController: EssentialViewMethods {
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
        
    }
    
    func setLayouts() {
        //let safeArea = self.view.safeAreaLayoutGuide
        
        //
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNavigationTitle() -> UIImageView {
        let navigationTitleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        navigationTitleImageView.image = UIImage(named: "NavigationTitleImage")
        navigationTitleImageView.contentMode = .scaleAspectFit
        
        return navigationTitleImageView
    }
    
    private func setUpNavigationItem() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // No bar line appears
        appearance.backgroundColor = .useRGB(red: 176, green: 0, blue: 32) // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.titleView = self.setUpNavigationTitle()
        self.navigationItem.title = "킹버스"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension CheckPermissionViewController {
    
}

// MARK: - Extension for selector methods
extension CheckPermissionViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        
    }
}

// MARK: - Extension for CLLocationManagerDelegate
extension CheckPermissionViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print(".notDetermined")
            self.locationManager.requestWhenInUseAuthorization()
        case .denied:
            print(".denied")
            self.dismiss(animated: true) {
                UserDefaults.standard.set("Check", forKey: "CheckPermission")
                NotificationCenter.default.post(name: Notification.Name("PermissionComplete"), object: nil)
                
            }
            
        case .authorizedWhenInUse, .authorizedAlways:
            print(".autohrizedWhenInUse")
            self.dismiss(animated: true) {
                UserDefaults.standard.set("Check", forKey: "CheckPermission")
                NotificationCenter.default.post(name: Notification.Name("PermissionComplete"), object: nil)
                
            }
            
        case .restricted:
            print(".restricted")
            self.dismiss(animated: true) {
                UserDefaults.standard.set("Check", forKey: "CheckPermission")
                NotificationCenter.default.post(name: Notification.Name("PermissionComplete"), object: nil)
                
            }
            
        @unknown default:
            self.dismiss(animated: true) {
                UserDefaults.standard.set("Check", forKey: "CheckPermission")
                NotificationCenter.default.post(name: Notification.Name("PermissionComplete"), object: nil)
                
            }
            
        }
    }
}
