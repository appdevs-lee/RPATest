//
//  CompanyEnterViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/07/22.
//

import UIKit

class CompanyEnterViewController: UIViewController {

    @IBOutlet weak var companyEnterTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func tapNextButton(_ sender: UIButton) {
        if self.companyEnterTextField.text == "dev" {
            ReferenceValues.shared.currentURL = .DEV
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") else { return }
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if self.companyEnterTextField.text == "성화투어" {
            ReferenceValues.shared.currentURL = .PROD
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") else { return }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
