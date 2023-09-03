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
            self.dismiss(animated: true) {
                UserDefaults.standard.set("Y", forKey: "CompanyCheck")
                
                Server.shared.currentURL = URL.DEV.rawValue
                UserDefaults.standard.set(URL.DEV.rawValue, forKey: "currentURL")
            }
        } else if self.companyEnterTextField.text == "성화투어" {
            self.dismiss(animated: true) {
                UserDefaults.standard.set("Y", forKey: "CompanyCheck")
                
                Server.shared.currentURL = URL.PROD.rawValue
                UserDefaults.standard.set(URL.PROD.rawValue, forKey: "currentURL")
            }
        }
    }
}
