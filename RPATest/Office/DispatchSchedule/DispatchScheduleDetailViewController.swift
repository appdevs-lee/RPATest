//
//  DispatchScheduleDetailViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/11/24.
//

import UIKit

final class DispatchScheduleDetailViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchScheduleDetailTableViewCell.self, forCellReuseIdentifier: "DispatchScheduleDetailTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(name: String, id: Int, check: Bool, status: (wake: String, boarding: String, driving: String)) {
        self.id = id
        self.name = name
        self.check = check
        self.status = status
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var nowSchedule: DispatchScheduleItem
//    var scheduleList: [DispatchScheduleItem] = [
//        DispatchScheduleItem(id: 1, name: "이성곤", vehicleNumber: "1701", phoneNumber: "010-1234-0234", time: "06:55", pathName: "써니밸리", arrivalName: "K1", breathalyzing: "0.0", note: "없음.", check: true, status: (wake: true, boarding: false, driving: false)),
//        DispatchScheduleItem(id: 2, name: "이성곤", vehicleNumber: "1701", phoneNumber: "010-1234-0234", time: "08:10", pathName: "병점", arrivalName: "동탄거점오피스", breathalyzing: "0.0", note: "없음.", check: false, status: (wake: false, boarding: false, driving: false)),
//        DispatchScheduleItem(id: 3, name: "이성곤", vehicleNumber: "1701", phoneNumber: "010-1234-0234", time: "17:30", pathName: "멀티플렉스", arrivalName: "수원역", breathalyzing: "0.0", note: "없음.", check: false, status: (wake: false, boarding: false, driving: false)),
//        DispatchScheduleItem(id: 4, name: "이성곤", vehicleNumber: "1701", phoneNumber: "010-1234-0234", time: "18:10", pathName: "멀티플렉스", arrivalName: "수원역", breathalyzing: "0.0", note: "없음.", check: false, status: (wake: false, boarding: false, driving: false)),
//    ]
    
    var id: Int
    var name: String
    var check: Bool
    var status: (wake: String, boarding: String, driving: String)
    var schedule: TeamScheduleDetailItem?
    var scheduleDetailList: [TeamScheduleDispatchItem] = []
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- DispatchScheduleDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchScheduleDetailViewController: EssentialViewMethods {
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
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
        
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
        
        self.navigationItem.title = "\(self.name) 기사 당일 배차목록"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchScheduleDetailRequest { schedule in
            self.schedule = schedule
            self.scheduleDetailList = schedule.combineData()
            
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            print("setData loadDispatchScheduleDetailRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
}

// MARK: - Extension for methods added
extension DispatchScheduleDetailViewController {
    func loadDispatchScheduleDetailRequest(success: ((TeamScheduleDetailItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.dispatchModel.loadDispatchScheduleDetailRequest(id: self.id) { scheduleList in
            success?(scheduleList)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension DispatchScheduleDetailViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        if let url = URL(string: "tel://\(self.schedule?.phone ?? "")") {
            UIApplication.shared.open(url)
            
        }
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchScheduleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scheduleDetailList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchScheduleDetailTableViewCell", for: indexPath) as! DispatchScheduleDetailTableViewCell
        let schedule = self.scheduleDetailList[indexPath.row]
        
        cell.setCell(schedule: schedule)
        if self.id == schedule.id {
            cell.mainView.layer.borderColor = UIColor.blue.cgColor
            cell.mainView.layer.borderWidth = 2.0
            
        } else {
            cell.mainView.layer.borderWidth = 0.0
            
        }
        
        if self.check {
            if self.status.wake == "false" {
                cell.problemCheckLabel.text = "기상 문제 발생"
                
            } else if self.status.boarding == "false" {
                cell.problemCheckLabel.text = "탑승 문제 발생"
                
            } else if self.status.driving == "false" {
                cell.problemCheckLabel.text = "운행 문제 발생"
                
            }
            
        } else {
            cell.problemCheckLabel.text = "정상"
            
        }
        
        cell.problemCheckLabel.textColor = self.check ? .red : .blue
        
        return cell
    }
    
}
