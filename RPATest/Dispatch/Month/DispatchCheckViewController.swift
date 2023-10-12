//
//  DispatchCheckViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/13.
//

import UIKit

final class DispatchCheckViewController: UIViewController {
    
    lazy var noDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noDataImageView, self.noDataLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoDataImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "금일 등록된 배차가 없습니다"
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchCheckTableViewCell.self, forCellReuseIdentifier: "DispatchCheckTableViewCell")
//        tableView.register(DispatchCheckOrderTableViewCell.self, forCellReuseIdentifier: "DispatchCheckOrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var date: String?
    let dispatchModel = DispatchModel()
    var regularlyItem: [DispatchRegularlyItem] = []
    var orderItem: [DispatchOrderItem] = []
    
    init(date: String?) {
        self.date = date
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
        self.setData()
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    deinit {
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchCheckViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(dateReload), name: Notification.Name("DispatchCheckComplete"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(dateReload), name: Notification.Name("DispatchDenyComplete"), object: nil)
    }
    
    func setSubviews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.noDataStackView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // noDataStackView
        NSLayoutConstraint.activate([
            self.noDataStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.noDataStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor)
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
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest(date: self.date!) { item in
            self.orderItem = item.order
            self.regularlyItem = item.regularly
            
            if !item.regularly.isEmpty {
                self.noDataStackView.isHidden = true
            } else {
                self.noDataStackView.isHidden = false
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
            }
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("setData loadDailyDispatchRequest API Error: \(errorMessage)")
        }

    }
}

// MARK: - Extension for methods added
extension DispatchCheckViewController {
    func loadDailyDispatchRequest(date: String, success: ((DispatchDailyItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDailyDispatchRequest(date: date) { dailyInfo in
            success?(dailyInfo)
            
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
    
    func checkDispatchRequest(check: String, refusal: String, regularlyId: String, orderId: String, success: (() -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.checkDispatchRequest(check: check, refusal: refusal, regularlyId: regularlyId, orderId: orderId) {
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension DispatchCheckViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dateReload() {
        self.setData()
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchCheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.regularlyItem.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchCheckTableViewCell", for: indexPath) as! DispatchCheckTableViewCell
        
        cell.setCell(info: self.regularlyItem[indexPath.row])
        cell.delegate = self
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - Extension for DispatchDailyDelegate
extension DispatchCheckViewController: DispatchDailyDelegate {
    func tapDetailMapButton(mapLink: String) {
        guard let url = URL(string: mapLink) else { return }
        UIApplication.shared.open(url)
    }
    
    func tapCheckButton(info: DispatchRegularlyItem) {
        let vc = DispatchCheckPopViewController(regularlyItem: info)
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
    
    // 배차 거부
    func tapDenyButton(info: DispatchRegularlyItem) {
        let vc = DispatchCheckDenyViewController(id: info.id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
