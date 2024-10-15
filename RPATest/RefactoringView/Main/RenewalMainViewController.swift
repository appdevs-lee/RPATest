//
//  RenewalMainViewController.swift
//  RPATest
//
//  Created by 이주성 on 10/1/24.
//

import UIKit

enum Role: String {
    case generalDriver = "운전원"
    case driverLeader = "팀장"
    case manager = "관리자"
    case mechanic = "정비사"
}

final class RenewalMainViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.role == .driverLeader || self.role == .generalDriver {
            self.driverView.isHidden = false
            
        } else {
            self.driverView.isHidden = true
            
        }
        
        return view
    }()
    
    lazy var naviBarBaseView: UIView = {
        let view = UIView()
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "안전한 운행되세요!\n\(ReferenceValues.name) \(self.role.rawValue)님"
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .useFont(ofSize: 22, weight: .Medium)
        label.asFontColor(targetString: "\(ReferenceValues.name) \(self.role.rawValue)님", font: .useFont(ofSize: 16, weight: .Medium), color: .useRGB(red: 165, green: 165, blue: 165))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("배차 관리", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(dispatchCheckButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if self.role == .driverLeader || self.role == .generalDriver {
            button.isHidden = false
            
        } else {
            button.isHidden = true
            
        }
        
        return button
    }()
    
    lazy var driverView: DriverView = {
        let view = DriverView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var role: Role
    let vehicleModel = VehicleModel()
    
    init(role: Role) {
        self.role = role
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.setUpNavigationItem()
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- RenewalMainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalMainViewController: EssentialViewMethods {
    func setViewFoundation() {
        print("role: \(self.role)")
        print("accessToken: \(UserInfo.shared.access ?? "")")
        self.view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        
        if self.navigationController?.viewControllers.first === self  {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
            
        }
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(runningStart(_:)), name: Notification.Name("RunningStart"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.naviBarBaseView,
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.greetingLabel,
            self.dispatchCheckButton,
        ], to: self.naviBarBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.driverView,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // naviBarBaseView
        NSLayoutConstraint.activate([
            self.naviBarBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.naviBarBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.naviBarBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.naviBarBaseView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // greetingLabel
        NSLayoutConstraint.activate([
            self.greetingLabel.leadingAnchor.constraint(equalTo: self.naviBarBaseView.leadingAnchor, constant: 16),
            self.greetingLabel.centerYAnchor.constraint(equalTo: self.naviBarBaseView.centerYAnchor),
        ])
        
        // dispatchCheckButton
        NSLayoutConstraint.activate([
            self.dispatchCheckButton.trailingAnchor.constraint(equalTo: self.naviBarBaseView.trailingAnchor, constant: -16),
            self.dispatchCheckButton.centerYAnchor.constraint(equalTo: self.naviBarBaseView.centerYAnchor),
            self.dispatchCheckButton.heightAnchor.constraint(equalToConstant: 50),
            self.dispatchCheckButton.widthAnchor.constraint(equalToConstant: 90),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.naviBarBaseView.bottomAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // driverView
        NSLayoutConstraint.activate([
            self.driverView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.driverView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.driverView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.driverView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        let leftBarButtonItem = UIBarButtonItem(title: "운행 목록", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 18, weight: .Regular),
            .foregroundColor: UIColor.black
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    func setData() {
        switch self.role {
        case .driverLeader, .generalDriver:
            self.driverView.reloadData()
            self.loadMonrningCheckDataRequest { submitCheck in
                if !submitCheck {
                    let vc = RenewalMorningCheckViewController()
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            }
            
        case .manager:
            break
            
        case .mechanic:
            break
            
        }
    }
    
}

// MARK: - Extension for methods added
extension RenewalMainViewController {
    func loadMonrningCheckDataRequest(success: ((Bool) -> ())?) {
        self.vehicleModel.loadMonrningCheckDataRequest { morningCheckData in
            success?(morningCheckData.submitCheck)
            
        } failure: { message in
            print("loadMonrningCheckDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
}

// MARK: - Extension for selector methods
extension RenewalMainViewController {
    @objc func dispatchCheckButton(_ sender: UIButton) {
        print("dispatchCheckButton")
        let vc = RenewalDispatchMonthlyViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func runningStart(_ notification: Notification) {
        guard let item = notification.userInfo?["item"] as? DailyDispatchDetailItem else { return }
        
        let vc = RenewalDispatchRunningViewController(item: item)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension RenewalMainViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
}
