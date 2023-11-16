//
//  TabBarController.swift
//  RPATest
//
//  Created by 이주성 on 2023/08/05.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewController()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
    }
    
    func setViewController() {
        let dispatchVC = DispatchViewController()
        let officeVC = OfficeViewController()
        let organizationVC = OrganizationViewPagerViewController()
        let profileVC = ProfileViewController()
        
        self.viewControllers = [
            self.createTabBarItem(tabBarTitle: "배차", tabBarImage: "dispatch", selectedImage: "selectedDispatch", viewController: dispatchVC),
            self.createTabBarItem(tabBarTitle: "사무", tabBarImage: "office", selectedImage: "selectedOffice", viewController: officeVC),
            self.createTabBarItem(tabBarTitle: "조직도", tabBarImage: "organization", selectedImage: "selectedOrganization", viewController: organizationVC),
            self.createTabBarItem(tabBarTitle: "프로필", tabBarImage: "profile", selectedImage: "selectedProfile", viewController: profileVC)
        ]
    }
    
    func createTabBarItem(tabBarTitle: String, tabBarImage: String, selectedImage: String, viewController: UIViewController) -> UINavigationController {
        let naviVC = NavigationViewController(rootViewController: viewController)
        naviVC.tabBarItem.title = tabBarTitle
        naviVC.tabBarItem.selectedImage = UIImage(named: selectedImage)
        naviVC.tabBarItem.image = UIImage(named: tabBarImage)
        
        return naviVC
    }

}
