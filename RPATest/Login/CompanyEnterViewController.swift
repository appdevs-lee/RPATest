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
        UserDefaults.standard.set("Y", forKey: "CompanyCheck")
        
        if self.companyEnterTextField.text == "dev" {
            Server.shared.currentURL = .DEV
            
            self.dismiss(animated: true)
        } else if self.companyEnterTextField.text == "성화투어" {
            Server.shared.currentURL = .PROD
            
            self.dismiss(animated: true)
        }
    }
}
