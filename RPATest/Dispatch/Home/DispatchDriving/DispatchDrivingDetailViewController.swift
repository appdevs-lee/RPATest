//
//  DispatchDrivingDetailViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/9/24.
//

import UIKit

final class DispatchDrivingDetailViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(DispatchDrivingTitleTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingTitleTableViewCell")
        switch self.type {
        case .regularly:
            tableView.register(DispatchDrivingRegularlyTableViewCell.self, forCellReuseIdentifier: "RenewalDispatchRegularlyTableViewCell")
            
        case .order:
            tableView.register(DispatchDrivingOrderTableViewCell.self, forCellReuseIdentifier: "RenewalDispatchOrderTableViewCell")
            
        }
        tableView.register(DispatchDrivingDetailPathTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingDetailPathTableViewCell")
        tableView.register(DispatchDrivingDoneTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingDoneTableViewCell")
        
        return tableView
    }()
    
    init(type: DispatchKindType, regularlyItem: DispatchRegularlyItem? = nil, orderItem: DispatchOrderItem? = nil) {
        self.type = type
        
        switch type {
        case .regularly:
            self.regularlyItem = regularlyItem
            
        case .order:
            self.orderItem = orderItem
            
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var type: DispatchKindType
    var regularlyItem: DispatchRegularlyItem?
    var orderItem: DispatchOrderItem?
    
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
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- DispatchDrivingDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchDrivingDetailViewController: EssentialViewMethods {
    func setViewFoundation() {
        
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
            self.tableView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
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
        
        self.navigationItem.title = "운행중"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension DispatchDrivingDetailViewController {
    
}

// MARK: - Extension for selector methods
extension DispatchDrivingDetailViewController {
    @objc func tappedDoneButton(_ sender: UIButton) {
        // 운행일보 작성 present
        
    }
    
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchDrivingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingTitleTableViewCell", for: indexPath) as! DispatchDrivingTitleTableViewCell
            
            cell.setCell()
            
            return cell
            
        } else if indexPath.section == 1 {
            switch self.type {
            case .regularly:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingRegularlyTableViewCell", for: indexPath) as! DispatchDrivingRegularlyTableViewCell
                guard let item = self.regularlyItem else { return UITableViewCell() }
                
                cell.setCell(item: item)
                
                return cell
            case .order:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingOrderTableViewCell", for: indexPath) as! DispatchDrivingOrderTableViewCell
                guard let item = self.orderItem else { return UITableViewCell() }
                
                cell.setCell(item: item)
                
                return cell
            }
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingDetailPathTableViewCell", for: indexPath) as! DispatchDrivingDetailPathTableViewCell
            
            cell.setCell()
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingDoneTableViewCell", for: indexPath) as! DispatchDrivingDoneTableViewCell
            
            cell.setCell()
            cell.doneButton.addTarget(self, action: #selector(tappedDoneButton(_:)), for: .touchUpInside)
            
            return cell
            
        }
        
    }
}
