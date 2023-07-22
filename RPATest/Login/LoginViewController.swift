//
//  LoginViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/04.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        postLogin(id: idTextField.text!, pwd: pwdTextField.text!) { _ in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else { return }
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc, animated: false)
        }
    }
    
}

extension LoginViewController {
    
}
