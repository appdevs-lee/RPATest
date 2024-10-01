//
//  RenewalLoginViewController.swift
//  RPATest
//
//  Created by 이주성 on 10/1/24.
//

import UIKit

final class RenewalLoginViewController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KingbusLoginLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.idTitleLabel, self.idTextField, self.idAlertLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var idTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.textColor = .useRGB(red: 51, green: 51, blue: 51)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 51, green: 51, blue: 51)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.setPlaceholder(placeholder: "아이디를 입력해주세요.")
        textField.setBorder(imageName: "IdIcon")
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var idAlertLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "등록되지 않은 계정이거나, 아이디를 다시 확인해주세요"
        label.textColor = .useRGB(red: 234, green: 7, blue: 48)
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.passwordTitleLabel, self.passwordTextField, self.passwordAlertLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .useRGB(red: 51, green: 51, blue: 51)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 51, green: 51, blue: 51)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.isSecureTextEntry = true
        textField.setPlaceholder(placeholder: "비밀번호를 입력해주세요.")
        textField.setBorder(imageName: "PasswordIcon")
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var secretButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setImage(.useCustomImage("secretImage"), for: .normal)
        button.addTarget(self, action: #selector(secretButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var passwordAlertLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "등록되지 않은 계정이거나, 아이디를 다시 확인해주세요"
        label.textColor = .useRGB(red: 234, green: 7, blue: 48)
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("로그인", for: .normal)
        button.setImage(.useCustomImage("login.off"), for: .disabled)
        button.setImage(.useCustomImage("login.on"), for: .normal)
        button.setImage(.useCustomImage("selectedLogin.on"), for: .highlighted)
        button.addTarget(self, action: #selector(loginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let loginModel = LoginModel()
    let dispatchModel = NewDispatchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        print("----------------------------------- RenewalLoginViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalLoginViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        if !ReferenceValues.isCheckPermission {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckPermissionViewController") else { return }
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
            
        } else {
            if ReferenceValues.isLoginCheck {
                SupportingMethods.shared.turnCoverView(.on)
                self.tokenRefreshRequest {
                    self.proceedLoginProcess()
                    
                } failure: {
                    ReferenceValues.isLoginCheck = false
                    
                }

            }
            
        }
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.logoImageView,
            self.idStackView,
            self.passwordStackView,
            self.secretButton,
            self.loginButton,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.logoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 60),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 176),
        ])
        
        // idStackView
        NSLayoutConstraint.activate([
            self.idStackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 48),
            self.idStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.idStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
        ])
        
        // idTextField
        NSLayoutConstraint.activate([
            self.idTextField.heightAnchor.constraint(equalToConstant: 56),
        ])

        // passwordStackView
        NSLayoutConstraint.activate([
            self.passwordStackView.topAnchor.constraint(equalTo: self.idStackView.bottomAnchor, constant: 20),
            self.passwordStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.passwordStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        // secretButton
        NSLayoutConstraint.activate([
            self.secretButton.trailingAnchor.constraint(equalTo: self.passwordTextField.trailingAnchor),
            self.secretButton.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor),
            self.secretButton.topAnchor.constraint(equalTo: self.passwordTextField.topAnchor),
            self.secretButton.bottomAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor),
            self.secretButton.widthAnchor.constraint(equalToConstant: 52),
        ])
        
        // loginButton
        NSLayoutConstraint.activate([
            self.loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            self.loginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            self.loginButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension RenewalLoginViewController {
    func proceedLoginProcess() {
        self.sendFCMTokenRequest {
            self.loadWhetherOrNotDispatchCheckRequest { isDispatchCheck in
                if isDispatchCheck {
                    let vc = CustomizedTabBarController()
                    
                    self.present(vc, animated: false) {
                        ReferenceValues.isLoginCheck = true
                        SupportingMethods.shared.turnCoverView(.off)
                        
                    }
                    
                } else {
                    //FIXME: 운행 수락 화면 Present
                    print("운행 수락 필수")
                    let vc = NotYetDispatchCheckListViewController()
                    
                    self.present(vc, animated: true)
                    
                }
            }
            
        }
    }
    
    // MARK: API
    func loginRequest(id: String, pwd: String, success: ((LoginDetail) -> ())?) {
        self.loginModel.loginRequest(id: id, pwd: pwd) { info in
            success?(info)
            
        } loginFailure: { reason in
            print("reason: \(reason)")
            self.idAlertLabel.isHidden = false
            if reason == 1 {
                print("아이디 또는 비밀번호가 일치하지 않습니다.")
                self.idAlertLabel.text = "아이디 또는 비밀번호가 일치하지 않습니다."
                
            } else if reason == 2 {
                print("탈퇴 혹은 탈퇴처리된 회원입니다.")
                self.idAlertLabel.text = "탈퇴 혹은 탈퇴처리된 회원입니다."
                
            } else {
                self.idAlertLabel.text = "관리자에게 문의 바랍니다."
                
            }
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loginRequest API error: \(errorMessage)")
            
        }
        
    }
    
    func tokenRefreshRequest(success: (() -> ())?, failure: (() -> ())?) {
        self.loginModel.tokenRefreshRequest { _ in
            success?()
            
        } refreshFailure: { _ in
            failure?()
            
        } failure: { errorMessage in
            print("tokenRefreshRequest API Error: \(errorMessage)")
            failure?()
        }

    }
    
    func sendFCMTokenRequest(success: (() -> ())?) {
        self.loginModel.sendFCMTokenRequest { _ in
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("sendFCMTokenRequest API error: \(errorMessage)")
            
        }

    }
    
    func loadWhetherOrNotDispatchCheckRequest(success: ((Bool) -> ())?) {
        let date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400), "yyyy-MM-dd")
        self.dispatchModel.loadWhetherOrNotDispatchCheckRequest(date: date) { item in
            let connectList = item.regularly + item.order
            var isDispatchCheck: Bool = true
            
            for connect in connectList {
                if let orderConnect = connect.checkOrderConnect {
                    if orderConnect.connectCheck == "" {
                        // 운행 수락 안 함.
                        isDispatchCheck = false
                        break
                        
                    }
                    
                } else if let regularlyConnect = connect.checkRegularlyConnect {
                    if regularlyConnect.connectCheck == "" {
                        // 운행 수락 안 함.
                        isDispatchCheck = false
                        break
                        
                    }
                    
                }
                
            }
            
            success?(isDispatchCheck)
            
        } failure: { message in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadWhetherOrNotDispatchCheckRequest API error: \(message)")
            
        }

    }
}

// MARK: - Extension for selector methods
extension RenewalLoginViewController {
    @objc func secretButton(_ sender: UIButton) {
        if self.passwordTextField.isSecureTextEntry {
            self.secretButton.setImage(.useCustomImage("noSecretImage"), for: .normal)
            self.passwordTextField.isSecureTextEntry = false
            
        } else {
            self.secretButton.setImage(.useCustomImage("secretImage"), for: .normal)
            self.passwordTextField.isSecureTextEntry = true
            
        }
    }
    
    @objc func loginButton(_ sender: UIButton) {
        print("loginButton")
        SupportingMethods.shared.turnCoverView(.on)
        self.loginRequest(id: self.idTextField.text!, pwd: self.passwordTextField.text!) { info in
            // FCMToken 등록
            self.proceedLoginProcess()
            
        }
        
    }
    
}

extension RenewalLoginViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.idTextField {
            self.idTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
            self.idTextField.addLeftImageView(imageName: "EditingIdIcon")
            
        } else {
            self.passwordTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
            self.passwordTextField.addLeftImageView(imageName: "EditingPasswordIcon")
            self.secretButton.isEnabled = true
            
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.idTextField {
            if self.idTextField.text == "" {
                self.idTextField.layer.borderColor = UIColor.useRGB(red: 218, green: 218, blue: 218).cgColor
                self.idTextField.addLeftImageView(imageName: "IdIcon")
                
            } else {
                self.idTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
                self.idTextField.addLeftImageView(imageName: "EditingIdIcon")
                
            }
            
            
        } else {
            if self.passwordTextField.text == "" {
                self.passwordTextField.addLeftImageView(imageName: "PasswordIcon")
                self.passwordTextField.layer.borderColor = UIColor.useRGB(red: 218, green: 218, blue: 218).cgColor
                self.secretButton.isEnabled = false
                
            } else {
                self.passwordTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
                self.passwordTextField.addLeftImageView(imageName: "EditingPasswordIcon")
                self.secretButton.isEnabled = true
                
            }
            
            
        }
        
        return true
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.idTextField.text != "" && self.passwordTextField.text != "" {
            self.loginButton.isEnabled = true
            
        } else {
            self.loginButton.isEnabled = false
            
        }
        
    }
}
