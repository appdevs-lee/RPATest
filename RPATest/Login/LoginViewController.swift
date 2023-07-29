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
    
    var loginModel = LoginModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        self.loginRequest(id: self.idTextField.text!, pwd: self.pwdTextField.text!) { info in
            UserInfo.shared.access = info.access
            UserInfo.shared.name = info.authenticatedUser.name
            UserDefaults.standard.set(info.refresh, forKey: "refreshToken")
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else { return }
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } loginFailure: { reason in
            if reason == 1 {
                print("아이디 또는 비밀번호가 일치하지 않습니다.")
            } else if reason == 2 {
                print("탈퇴 혹은 탈퇴처리된 회원입니다.")
            }
        } failure: { errorMessage in
            print("tapLoginButton loginRequest API error: \(errorMessage)")
        }
    }
}

// MARK: - Extension for Methods Added
extension LoginViewController {
    func loginRequest(id: String, pwd: String, success: ((LoginDetail) -> ())?, loginFailure: ((_ reason: Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.loginModel.loginRequest(id: id, pwd: pwd) { loginDetail in
            success?(loginDetail)
        } loginFailure: { reason in
            loginFailure?(reason)
        } failure: { errorMessage in
            failure?(errorMessage)
        }
    }
}

// MARK: - Extension for Selectors Added
extension LoginViewController {
    
}
