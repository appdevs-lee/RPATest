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
            self.dismiss(animated: false) {
                UserDefaults.standard.set("Y", forKey: "CompanyCheck")
                
                Server.shared.currentURL = ServerURL.DEV.rawValue
                UserDefaults.standard.set(ServerURL.DEV.rawValue, forKey: "currentURL")
            }
        } else if self.companyEnterTextField.text == "성화투어" {
            self.dismiss(animated: false) {
                UserDefaults.standard.set("Y", forKey: "CompanyCheck")
                
                Server.shared.currentURL = ServerURL.PROD.rawValue
                UserDefaults.standard.set(ServerURL.PROD.rawValue, forKey: "currentURL")
            }
        } else if self.companyEnterTextField.text == "뉴한솔" {
            self.dismiss(animated: false) {
                UserDefaults.standard.set("Y", forKey: "CompanyCheck")
                
                Server.shared.currentURL = ServerURL.NH.rawValue
                UserDefaults.standard.set(ServerURL.NH.rawValue, forKey: "currentURL")
            }
        }
    }
}
