//
//  NotYetDispatchCheckListViewController.swift
//  RPATest
//
//  Created by 이주성 on 10/1/24.
//

import UIKit

final class NotYetDispatchCheckListViewController: UIViewController {
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "미확인 배차"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NotYetDispatchCheckListTableViewCell.self, forCellReuseIdentifier: "NotYetDispatchCheckListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let dispatchModel = NewDispatchModel()
    var noCheckList: [DailyDispatchDetailItem] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
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
        print("----------------------------------- NotYetDispatchCheckListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension NotYetDispatchCheckListViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        
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
            self.headerView,
            self.tableView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.headerTitleLabel,
        ], to: self.headerView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // headerView
        NSLayoutConstraint.activate([
            self.headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // headerTitleLabel
        NSLayoutConstraint.activate([
            self.headerTitleLabel.centerXAnchor.constraint(equalTo: self.headerView.centerXAnchor),
            self.headerTitleLabel.centerYAnchor.constraint(equalTo: self.headerView.centerYAnchor),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest { noCheckList in
            self.noCheckList = noCheckList
            SupportingMethods.shared.turnCoverView(.off)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
            
        }
        
    }
}

// MARK: - Extension for methods added
extension NotYetDispatchCheckListViewController {
    func loadDailyDispatchRequest(success: (([DailyDispatchDetailItem]) -> ())?) {
        let date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400), "yyyy-MM-dd")
        self.dispatchModel.loadDailyDispatchRequest(date: date) { item in
            var noCheckList: [DailyDispatchDetailItem] = []
            let itemList = item.regularly + item.order
            for item in itemList {
                if let orderConnect = item.checkOrderConnect {
                    if orderConnect.connectCheck == "" {
                        noCheckList.append(item)
                        
                    }
                    
                } else if let regularlyConnect = item.checkRegularlyConnect {
                    if regularlyConnect.connectCheck == "" {
                        noCheckList.append(item)
                        
                    }
                    
                }
                
            }
            
            success?(noCheckList)
            
        } failure: { message in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadWhetherOrNotDispatchCheckRequest API error: \(message)")
            
        }

    }
}

// MARK: - Extension for selector methods
extension NotYetDispatchCheckListViewController {
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension NotYetDispatchCheckListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noCheckList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotYetDispatchCheckListTableViewCell", for: indexPath) as! NotYetDispatchCheckListTableViewCell
        let item = self.noCheckList[indexPath.row]
        
        cell.setCell(item: item)
        
        return cell
    }
}

