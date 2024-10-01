//
//  CustomizedTabBarController.swift
//  UniversalBora
//
//  Created by Awesomepia on 6/20/24.
//

import UIKit

class CustomizedTabBarController: UITabBarController {
    
    // 이전에 선택했던 탭
    var previousSelectedIndex: Int = 0
    
    // 현재 선택한 탭
    var currentSelectedIndex: Int = 0 {
        didSet {
            self.previousSelectedIndex = oldValue
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Tabbar Desgin
        self.setDesign()
        
        // Set ViewControllers in Tabbar
//        let mainVC = MainViewController()
//        let letterVC = LetterViewController()
//        let aquaVC = AquaViewController()
//        let settingVC = SettingViewController()
//        let setting2VC = SettingViewController()
        
        self.viewControllers = [
//            self.createTabBarItem(tabBarTitle: SupportingMethods.shared.getText("tabbar.home"), tabBarImage: "Home", selectedImage: "SelectedHome", viewController: mainVC),
//            self.createTabBarItem(tabBarTitle: SupportingMethods.shared.getText("tabbar.home"), tabBarImage: "Home", selectedImage: "SelectedHome", viewController: letterVC),
//            self.createTabBarItem(tabBarTitle: SupportingMethods.shared.getText("tabbar.home"), tabBarImage: "Home", selectedImage: "SelectedHome", viewController: aquaVC),
//            self.createTabBarItem(tabBarTitle: SupportingMethods.shared.getText("tabbar.home"), tabBarImage: "Home", selectedImage: "SelectedHome", viewController: settingVC),
//            self.createTabBarItem(tabBarTitle: SupportingMethods.shared.getText("tabbar.home"), tabBarImage: "Home", selectedImage: "SelectedHome", viewController: setting2VC),
        ]
        
        // FIXME: 고치기
        NotificationCenter.default.addObserver(self, selector: #selector(changeTextLanguage(_:)), name: Notification.Name("SetLocalization"), object: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.selectedViewController?.preferredStatusBarStyle ?? .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.selectedViewController?.supportedInterfaceOrientations ?? .portrait) == .landscape ? .landscape : .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.selectedViewController?.preferredInterfaceOrientationForPresentation ?? .portrait) == .landscapeRight ? .landscapeRight : .portrait
    }
    
    deinit {
            print("----------------------------------- CustomizedTabBarController disposed -----------------------------------")
    }
}

// MARK: Extension for methods add
extension CustomizedTabBarController {
    func setDesign() {
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .useRGB(red: 151, green: 157, blue: 242)
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.useFont(ofSize: 12, weight: .Medium)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        self.tabBar.layer.cornerRadius = 24
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.tabBar.layer.borderWidth = 0
//        self.tabBar.addShadow(location: .bottom)
    }
    
    func createTabBarItem(tabBarTitle: String, tabBarImage: String, selectedImage: String, viewController: UIViewController) -> UINavigationController {
        let naviVC = CustomizedNavigationController(rootViewController: viewController)
        naviVC.tabBarItem.title = tabBarTitle
        naviVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.image = UIImage(named: tabBarImage)?.withRenderingMode(.alwaysOriginal)
        
        return naviVC
    }
    
}

extension CustomizedTabBarController {
    @objc func changeTextLanguage(_ notification: Notification) {
        for _ in self.tabBar.items! {
//            item.title = SupportingMethods.shared.getText("tabbar.home")
        }
    }
}

// MARK: Extension for UITabBarControllerDelegate
extension CustomizedTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.currentSelectedIndex = tabBarController.selectedIndex
        
        if tabBarController.selectedIndex == 0 {
            
        }
        
        if tabBarController.selectedIndex == 1 {
            
        }
        
        if tabBarController.selectedIndex == 2 {
            
        }
        
        if tabBarController.selectedIndex == 3 {
            
        }
        
    }
    
}
