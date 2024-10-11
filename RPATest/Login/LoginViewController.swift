//
//  LoginViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/04.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.isHidden = false
        view.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KingbusLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .white
        progressView.trackTintColor = .lightGray
        progressView.layer.cornerRadius = 4
        progressView.layer.masksToBounds = true
        progressView.progress = 0.0
        
        progressView.progressTintColor = UIColor.white
        progressView.progressViewStyle = .bar
        
        self.progressBarTimer?.invalidate()
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(LoginViewController.updateProgressView), userInfo: nil, repeats: true)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    
    let loginModel = LoginModel()
    let commonModel = OldCommonModel()
    let dispatchModel = DispatchModel()
    let organizationModel = OrganizationModel()
    
    var progressBarTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ReferenceValues.firstVC = self
        
        self.setSubViews()
        self.setLayouts()
        NotificationCenter.default.addObserver(self, selector: #selector(presentCompanyEnterView), name: Notification.Name("PermissionComplete"), object: nil)
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        self.alertLabel.isHidden = true
        SupportingMethods.shared.turnCoverView(.on)
        if self.idTextField.text == "" || self.pwdTextField.text == "" {
            SupportingMethods.shared.turnCoverView(.off)
            self.alertLabel.isHidden = false
            self.alertLabel.text = "아이디와 비밀번호를 입력해주세요."
        } else {
            self.loginRequest(id: self.idTextField.text!, pwd: self.pwdTextField.text!) { info in
                UserInfo.shared.access = "Bearer " + info.access
                UserInfo.shared.name = info.authenticatedUser.name
                UserInfo.shared.role = info.authenticatedUser.role
                UserDefaults.standard.set(info.authenticatedUser.name, forKey: "name")
                UserDefaults.standard.set(info.refresh, forKey: "refreshToken")
                
                self.sendFCMTokenRequest(fcmToken: UserInfo.shared.fcmToken ?? "") {
                    self.memberInfoRequest {
                        self.loadDailyDispatchRequest { items in
                            var isDispatchCheck: Bool = true
                            
                            for item in items.regularly {
                                if item.checkRegularlyConnect.connectCheck == "" {
                                    isDispatchCheck = false
                                    break
                                }
                            }
                            
                            if !isDispatchCheck {
                                for item in items.order {
                                    if item.checkOrderConnect.connectCheck == "" {
                                        isDispatchCheck = false
                                        break
                                    }
                                }
                            }
                            
                            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else { return }
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: false) {
                                if !isDispatchCheck {
                                    let afterDate = SupportingMethods.shared.calculateDate(byValue: 1, component: .day, date: Date())
                                    let dateString = SupportingMethods.shared.convertDate(intoString: afterDate)
                                    
                                    NotificationCenter.default.post(name: Notification.Name("LoginDispatchCheck"), object: nil, userInfo: ["dateString": dateString])
                                }
                                SupportingMethods.shared.turnCoverView(.off)
                            }
                            
                        } failure: { errorMessage in
                            SupportingMethods.shared.turnCoverView(.off)
                            print("loadDailyDispatchRequest API Errpr \(errorMessage)")
                            
                        }
                    }
                } failure: { errorMessage in
                    SupportingMethods.shared.turnCoverView(.off)
                    print("sendFCMTokenRequest API Error: \(errorMessage)")
                }
            } loginFailure: { reason in
                SupportingMethods.shared.turnCoverView(.off)
                self.alertLabel.isHidden = false
                if reason == 1 {
                    print("아이디 또는 비밀번호가 일치하지 않습니다.")
                    self.alertLabel.text = "아이디 또는 비밀번호가 일치하지 않습니다."
                } else if reason == 2 {
                    print("탈퇴 혹은 탈퇴처리된 회원입니다.")
                    self.alertLabel.text = "탈퇴 혹은 탈퇴처리된 회원입니다."
                } else {
                    self.alertLabel.text = "관리자에게 문의 바랍니다."
                }
            } failure: { errorMessage in
                SupportingMethods.shared.turnCoverView(.off)
                print("tapLoginButton loginRequest API error: \(errorMessage)")
            }
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
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
            }
        }
    }
    
    func memberInfoRequest(success: (() -> ())?) {
        self.organizationModel.memberInfoRequest { info in
            UserInfo.shared.role = info.role
            UserInfo.shared.id = info.id
            UserInfo.shared.phoneNumber = info.phoneNum
            SupportingMethods.shared.turnCoverView(.off)
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                print("memeberInfoRequest API Error: \(errorMessage)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        }

    }
    
    func tokenRefreshRequest(success: ((Token) -> ())?, refreshFailure: ((Int) -> ())?, failure: ((String) -> ())?) {
        self.loginModel.tokenRefreshRequest { token in
            success?(token)
            
        } refreshFailure: { reason in
            refreshFailure?(reason)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
            }
        }

    }
    
    func sendFCMTokenRequest(fcmToken: String, success: (() -> ())?, failure: ((String) -> ())?) {
        self.loginModel.sendFCMTokenRequest() { item in
            print("FCM Token: \(item.token)")
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func loadDailyDispatchRequest(success: ((DispatchDailyItem) -> ())?, failure: ((String) -> ())?) {
        let afterDate = SupportingMethods.shared.calculateDate(byValue: 1, component: .day, date: Date())
        let dateString = SupportingMethods.shared.convertDate(intoString: afterDate)
        
        self.dispatchModel.loadDailyDispatchRequest(date: dateString) { item in
            success?(item)
            
        } dispatchFailure: { reason in
            if reason == 1 {
                print("날짜 입력이 잘못되었습니다.")
            }
            
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func setUpProgressView() {
        self.progressView.isHidden = false
        self.progressView.progress = 0.0
        
        self.progressBarTimer?.invalidate()
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(LoginViewController.updateProgressView), userInfo: nil, repeats: true)
        self.progressView.progressTintColor = UIColor.white
        self.progressView.progressViewStyle = .bar
    }
    
    func setSubViews() {
        self.view.addSubview(self.backGroundView)
        self.view.addSubview(self.alertLabel)
        
        self.backGroundView.addSubview(self.logoImageView)
        self.backGroundView.addSubview(self.progressView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // backGroundView
        NSLayoutConstraint.activate([
            self.backGroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backGroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.backGroundView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.backGroundView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.centerYAnchor.constraint(equalTo: self.backGroundView.centerYAnchor),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.backGroundView.centerXAnchor)
        ])
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.progressView.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant: -16),
            self.progressView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            self.progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        // alertLabel
        NSLayoutConstraint.activate([
            self.alertLabel.topAnchor.constraint(equalTo: self.pwdTextField.bottomAnchor, constant: 4),
            self.alertLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
        ])
    }
}

// MARK: - Extension for Selectors Added
extension LoginViewController {
    @objc func presentCompanyEnterView() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompanyEnterViewController") else { return }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false) {
            self.backGroundView.isHidden = true
            self.progressView.progress = 0
        }
    }
    
    @objc func updateProgressView() {
        self.progressView.progress += 0.01
        self.progressView.setProgress(self.progressView.progress, animated: true)
        
        if(self.progressView.progress == 1.0)
        {
            self.progressBarTimer?.invalidate()
            
            if self.commonModel.getCompanyCheck() == "Y" {
                // token refresh check
                if getRefreshToken() != "" {
                    self.tokenRefreshRequest { tokenData in
                        UserInfo.shared.access = "Bearer " + tokenData.access
                        UserDefaults.standard.set(tokenData.refresh, forKey: "refreshToken")
                        
                        self.sendFCMTokenRequest(fcmToken: UserInfo.shared.fcmToken ?? "") {
                            self.memberInfoRequest {
                                self.loadDailyDispatchRequest { items in
                                    var isDispatchCheck: Bool = true
                                    
                                    for item in items.regularly {
                                        if item.checkRegularlyConnect.connectCheck == "" {
                                            isDispatchCheck = false
                                            break
                                        }
                                    }
                                    
                                    if !isDispatchCheck {
                                        for item in items.order {
                                            if item.checkOrderConnect.connectCheck == "" {
                                                isDispatchCheck = false
                                                break
                                            }
                                        }
                                    }
                                    
                                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") else { return }
                                    
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: false) {
                                        if !isDispatchCheck {
                                            let afterDate = SupportingMethods.shared.calculateDate(byValue: 1, component: .day, date: Date())
                                            let dateString = SupportingMethods.shared.convertDate(intoString: afterDate)
                                            
                                            NotificationCenter.default.post(name: Notification.Name("LoginDispatchCheck"), object: nil, userInfo: ["dateString": dateString])
                                            
                                            SupportingMethods.shared.showAlertNoti(title: "다음날 배차 수락이 완료되지 않았습니다. 배차 수락 화면으로 이동합니다.")
                                        }
                                        SupportingMethods.shared.turnCoverView(.off)
                                    }
                                    
                                } failure: { errorMessage in
                                    SupportingMethods.shared.turnCoverView(.off)
                                    print("loadDailyDispatchRequest API Errpr \(errorMessage)")
                                    
                                }
                            }
                        } failure: { errorMessage in
                            SupportingMethods.shared.turnCoverView(.off)
                            print("sendFCMTokenRequest API Error: \(errorMessage)")
                        }
                    } refreshFailure: { reason in
                        SupportingMethods.shared.turnCoverView(.off)
                        
                        if reason == 1 {
                            print("유효하지 않은 토큰입니다.")
                            SupportingMethods.shared.determineAppState(.logout)
                            
                        } else if reason == 2 {
                            print("Token이 미입력되었습니다.")
                            
                        } else {
                            print("관리자에게 문의 바랍니다.")
                            
                        }
                        
                    } failure: { errorMessage in
                        print("updateProgressView tokenRefreshRequest API Error: \(errorMessage)")
                    }
                } else {
                    self.backGroundView.isHidden = true
                }
                
            } else {
                if self.commonModel.getPermissionCheck() == "Check" {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CompanyEnterViewController") else { return }
                    
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false) {
                        self.backGroundView.isHidden = true
                        self.progressView.progress = 0
                    }
                } else {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckPermissionViewController") else { return }
                    
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: false)
                }
            }
        }
    }
}
