//
//  gasStationListViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/30/23.
//

import UIKit

final class GasStationListViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주유 장소를 선택해주세요."
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
        tableView.register(GasStationListTableViewCell.self, forCellReuseIdentifier: "GasStationListTableViewCell")
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
    
    let officeModel = OfficeModel()
    var gasStationList: [GasStationDetailItem] = []
    var page: Int = 1
    var search: String = ""
    var nextRequest: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Pop Slide
//        if self.navigationController?.viewControllers.first === self  {
//            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        }
        
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
            print("----------------------------------- gasStationListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension GasStationListViewController: EssentialViewMethods {
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
        self.loadGasStationRequestAtBeginning()
    }
}

// MARK: - Extension for methods added
extension GasStationListViewController {
    func loadGasStationRequest(page: Int, search: String, success: ((GasStationItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.officeModel.loadGasStationRequest(page: page, search: search) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func loadGasStationRequestAtBeginning() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadGasStationRequest(page: 1, search: self.search) { item in
            self.page = 1
            self.gasStationList = item.gasStationList
            self.nextRequest = item.next
            
            self.tableView.reloadData()
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadGasStationRequestAtBeginning API Error: \(errorMessage)")
        }
    }
    
    func loadGasStationRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadGasStationRequest(page: page, search: self.search) { item in
            self.page = page
            self.nextRequest = item.next
            
            let list = item.gasStationList
            self.gasStationList.append(contentsOf: list)
            
            if !list.isEmpty {
                self.tableView.reloadData()
            }
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
            }
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadGasStationRequest API Error: \(errorMessage)")
        }

    }
    
}

// MARK: - Extension for selector methods
extension GasStationListViewController {
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension GasStationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gasStationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GasStationListTableViewCell", for: indexPath) as! GasStationListTableViewCell
        let gasStation = self.gasStationList[indexPath.row]
        
        cell.setCell(gasStation: gasStation)
        
        cell.selectionStyle = .none
        
        if indexPath.row == self.gasStationList.count - 1 && self.nextRequest != nil {
            self.loadGasStationRequest(page: self.page + 1)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gasStation = self.gasStationList[indexPath.row]
        
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("SendGasStation"), object: nil, userInfo: ["gasStationId": gasStation.id, "gasStationName": "\(gasStation.category)"])
        }
    }
}
