//
//  DispatchCheckPopViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/14.
//

import UIKit

final class DispatchCheckPopViewController: UIViewController {
    
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleImageView, self.titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var driveDay: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var busIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var detailMapLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var driveAllowanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 7
        button.setTitle("배차 확인", for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedCheckButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // 버스번호, 출발지, 도착지, 출발시각, 도착시각, 상세노선, 운임비, 수당
    
    init(regularlyItem: DispatchRegularlyItem? = nil, orderItem: DispatchOrderItem? = nil) {
        self.regularlyItem = regularlyItem
        self.orderItem = orderItem
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var regularlyItem: DispatchRegularlyItem?
    var orderItem: DispatchOrderItem?
    let dispatchModel = DispatchModel()
    
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
        
        print(self.regularlyItem!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    deinit {
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchCheckPopViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.4)
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let viewGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedDismissView))
        self.view.addGestureRecognizer(viewGesture)
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        self.view.addSubview(self.backGroundView)
        self.view.addSubview(self.titleStackView)
        self.view.addSubview(self.driveDay)
        self.view.addSubview(self.busIdLabel)
        self.view.addSubview(self.departureLabel)
        self.view.addSubview(self.arrivalLabel)
        self.view.addSubview(self.departureTimeLabel)
        self.view.addSubview(self.arrivalTimeLabel)
        self.view.addSubview(self.detailMapLabel)
        self.view.addSubview(self.priceLabel)
        self.view.addSubview(self.driveAllowanceLabel)
        self.view.addSubview(self.checkButton)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // backGroundView
        NSLayoutConstraint.activate([
            self.backGroundView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.backGroundView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.backGroundView.widthAnchor.constraint(equalToConstant: 328),
            self.backGroundView.heightAnchor.constraint(equalToConstant: 328)
        ])
        
        // titleStackView
        NSLayoutConstraint.activate([
            self.titleStackView.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.titleStackView.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant: -16),
            self.titleStackView.topAnchor.constraint(equalTo: self.backGroundView.topAnchor, constant: 8)
        ])
        
        // driveDay
        NSLayoutConstraint.activate([
            self.driveDay.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.driveDay.topAnchor.constraint(equalTo: self.titleStackView.bottomAnchor, constant: 4)
        ])
        
        // busIdLabel
        NSLayoutConstraint.activate([
            self.busIdLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.busIdLabel.topAnchor.constraint(equalTo: self.driveDay.bottomAnchor, constant: 16)
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.departureLabel.topAnchor.constraint(equalTo: self.busIdLabel.bottomAnchor, constant: 4)
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.arrivalLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 4)
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.arrivalLabel.bottomAnchor, constant: 4)
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.departureTimeLabel.bottomAnchor, constant: 4)
        ])
        
        // detailMapLabel
        NSLayoutConstraint.activate([
            self.detailMapLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.detailMapLabel.topAnchor.constraint(equalTo: self.arrivalTimeLabel.bottomAnchor, constant: 4),
            self.detailMapLabel.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant: -16)
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.priceLabel.topAnchor.constraint(equalTo: self.detailMapLabel.bottomAnchor, constant: 4)
        ])
        
        // driveAllowanceLabel
        NSLayoutConstraint.activate([
            self.driveAllowanceLabel.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.driveAllowanceLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 4)
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.leadingAnchor.constraint(equalTo: self.backGroundView.leadingAnchor, constant: 16),
            self.checkButton.trailingAnchor.constraint(equalTo: self.backGroundView.trailingAnchor, constant: -16),
            self.checkButton.heightAnchor.constraint(equalToConstant: 50),
            self.checkButton.topAnchor.constraint(equalTo: self.driveAllowanceLabel.bottomAnchor, constant: 16)
        ])
        
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNavigationTitle() -> UIImageView {
        let navigationTitleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        navigationTitleImageView.image = UIImage(named: "NavigationTitleImage")
        navigationTitleImageView.contentMode = .scaleAspectFit
        
        return navigationTitleImageView
    }
    
    private func setUpNavigationItem() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // No bar line appears
        appearance.backgroundColor = .useRGB(red: 176, green: 0, blue: 32) // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.titleView = self.setUpNavigationTitle()
        self.navigationItem.title = "킹버스"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        guard let info = self.regularlyItem else { return }
        
        if info.workType == "출근" {
            self.titleImageView.image = UIImage(named: "Start")
        } else {
            self.titleImageView.image = UIImage(named: "Arrival")
        }
        
        self.titleLabel.text = "\(info.group) - \(info.route)"
        self.driveDay.text = "운행요일: \(info.week)"
        self.busIdLabel.text =  "버스번호: \(info.busId)"
        self.departureLabel.text = "출발지: \(info.departure)"
        self.arrivalLabel.text = "도착지: \(info.arrival)"
        self.departureTimeLabel.text = "출발시간: \(info.departureDate)"
        self.arrivalTimeLabel.text = "도착시간: \(info.arrivalDate)"
        self.detailMapLabel.text = "상세노선: \(info.detailedRoute)"
        self.priceLabel.text = "운임비: \(Int(info.price)!.formatterStyle(.decimal)!)"
        self.driveAllowanceLabel.text = "수당: \(Int(info.driverAllowance)!.formatterStyle(.decimal)!)"
        
    }
}

// MARK: - Extension for methods added
extension DispatchCheckPopViewController {
    func checkDispatchRequest(check: String, regularlyId: String, orderId: String, success: (() -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.checkDispatchRequest(check: check, regularlyId: regularlyId, orderId: orderId) {
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension DispatchCheckPopViewController {
    @objc func tappedDismissView() {
        self.dismiss(animated: true)
    }
    
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        
    }
    
    @objc func tappedCheckButton(_ sender: UIButton) {
        guard let info = self.regularlyItem else { return }
        
        SupportingMethods.shared.turnCoverView(.on)
        self.checkDispatchRequest(check: "1", regularlyId: "\(info.id)", orderId: "") {
            SupportingMethods.shared.turnCoverView(.off)
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: Notification.Name("DispatchCheckComplete"), object: nil)
            }
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("tappedCheckButton checkDispatchRequest API Error: \(errorMessage)")
            
        }
    }
}
