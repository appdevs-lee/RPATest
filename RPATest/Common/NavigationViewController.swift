//
//  NavigationViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/26.
//

import UIKit

class NavigationViewController: UINavigationController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.modalPresentationStyle = rootViewController.modalPresentationStyle
        self.modalTransitionStyle = rootViewController.modalTransitionStyle
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
