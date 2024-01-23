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
            tableView.register(DispatchDrivingRegularlyTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingRegularlyTableViewCell")
            
        case .order:
            tableView.register(DispatchDrivingOrderTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingOrderTableViewCell")
            
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
    var peopleCount: Int = 0
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(drivingDone(_:)), name: Notification.Name("NoteWriteCompleted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPeopleCount(_:)), name: Notification.Name("PeopleCount"), object: nil)
        
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
        ReferenceValues.peopleCount = 0
        UserDefaults.standard.set(nil, forKey: "SaveDrivingInfo")
        
        // 운행일보 작성 present
        let vc = DispatchNoteDetailViewController(presentType: .present, type: self.type, id: (regularly: "\(self.regularlyItem?.id ?? 0)", order: ""), date: (departure: self.regularlyItem?.departureDate ?? "", arrival: self.regularlyItem?.arrivalDate ?? ""), count: self.peopleCount)
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func drivingDone(_ noti: Notification) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func setPeopleCount(_ noti: Notification) {
        guard let count = noti.userInfo?["count"] as? Int else { return }
        
        self.peopleCount = count
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
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingTitleTableViewCell", for: indexPath) as! DispatchDrivingTitleTableViewCell
            
            cell.setCell(route: self.regularlyItem?.route ?? "")
            
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
            var station: String = ""
            
            switch self.type {
            case .regularly:
                station = self.regularlyItem?.detailedRoute ?? ""
                
            case .order:
                station = ""
                
            }
            
            cell.setCell(station: station)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingDoneTableViewCell", for: indexPath) as! DispatchDrivingDoneTableViewCell
            
            cell.setCell()
            cell.doneButton.addTarget(self, action: #selector(tappedDoneButton(_:)), for: .touchUpInside)
            
            return cell
            
        }
        
    }
}
