//
//  CustomizedNavigationController.swift
//  UniversalBora
//
//  Created by Awesomepia on 6/20/24.
//

import UIKit

class CustomizedNavigationController: UINavigationController {

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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController?.preferredStatusBarStyle ?? .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.topViewController?.supportedInterfaceOrientations ?? .portrait) == .landscape ? .landscape : .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait) == .landscapeRight ? .landscapeRight : .portrait
    }
    
    deinit {
            print("----------------------------------- CustomizedNavigationController disposed -----------------------------------")
    }

}
