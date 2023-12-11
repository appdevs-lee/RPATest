//
//  GarageListViewController.swift
//  RPATest
//
//  Created by Awesomepia on 12/11/23.
//

import UIKit

final class GarageListViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "차고를 선택해주세요."
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(GarageTableViewCell.self, forCellReuseIdentifier: "GarageTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dispatchModel = DispatchModel()
    var garageList: [GarageDetailItem] = []
    var page: Int = 1
    var search: String = ""
    var nextRequest: String?
    
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
    
    deinit {
            print("----------------------------------- gasStationListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension GarageListViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
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
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.tableView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setData() {
        self.loadGarageRequestAtBeginning()
    }
}

// MARK: - Extension for methods added
extension GarageListViewController {
    func loadGarageRequest(page: Int, search: String, success: ((GarageItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadGarageRequest(page: page, search: search) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func loadGarageRequestAtBeginning() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadGarageRequest(page: 1, search: self.search) { item in
            self.page = 1
            self.garageList = item.garageList
            self.nextRequest = item.next
            
            self.tableView.reloadData()
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadGarageRequestAtBeginning API Error: \(errorMessage)")
        }
    }
    
    func loadGarageRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadGarageRequest(page: page, search: self.search) { item in
            self.page = page
            self.nextRequest = item.next
            
            let list = item.garageList
            self.garageList.append(contentsOf: list)
            
            if !list.isEmpty {
                self.tableView.reloadData()
            }
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
            }
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadGarageRequest API Error: \(errorMessage)")
        }

    }
    
}

// MARK: - Extension for selector methods
extension GarageListViewController {
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension GarageListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.garageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GarageTableViewCell", for: indexPath) as! GarageTableViewCell
        let garage = self.garageList[indexPath.row]
        
        cell.setCell(garage: garage)
        
        cell.selectionStyle = .none
        
        if indexPath.row == self.garageList.count - 1 && self.nextRequest != nil {
            self.loadGarageRequest(page: self.page + 1)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let garage = self.garageList[indexPath.row]
        
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("SendGarage"), object: nil, userInfo: ["garageId": garage.id, "garageName": "\(garage.category)"])
        }
    }
}
