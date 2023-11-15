//
//  DispatchScheduleViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/9/23.
//

import UIKit

final class DispatchScheduleViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchScheduleTableViewCell.self, forCellReuseIdentifier: "DispatchScheduleTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var scheduleList: [DispatchScheduleItem] = [
        DispatchScheduleItem(name: "신공범", vehicleNumber: "7276", separateRole: "기사", phoneNumber: "010-1234-1234", time: "06:24", path: "병점 1", checkVehicleStatusPlace: "참누리 A", gate: "정문", note: "5시 15분 전까지 확인 필요", check: true),
        DispatchScheduleItem(name: "김창수", vehicleNumber: "5022", separateRole: "기사", phoneNumber: "010-1234-1234", time: "06:17", path: "병점 2", checkVehicleStatusPlace: "나노시티롯데캐슬", gate: "정문", note: "5시 15분 전까지 확인 필요", check: true),
        DispatchScheduleItem(name: "이용규", vehicleNumber: "5014", separateRole: "기사", phoneNumber: "010-1234-1234", time: "06:15", path: "수원 1", checkVehicleStatusPlace: "참누리 A", gate: "정문", note: "5시 15분 전까지 확인 필요", check: false),
        DispatchScheduleItem(name: "정윤진", vehicleNumber: "7918", separateRole: "용역", phoneNumber: "010-1234-1234", time: "06:30", path: "수원 2", checkVehicleStatusPlace: "참누리 A", gate: "정문", note: "5시 15분 전까지 확인 필요", check: true),
        DispatchScheduleItem(name: "김도윤", vehicleNumber: "6277", separateRole: "용역", phoneNumber: "010-1234-1234", time: "06:33", path: "수원 3", checkVehicleStatusPlace: "참누리 A", gate: "정문", note: "5시 15분 전까지 확인 필요", check: false),
        DispatchScheduleItem(name: "차기상", vehicleNumber: "5003", separateRole: "기사", phoneNumber: "010-1234-1234", time: "06:15", path: "우만", checkVehicleStatusPlace: "참누리 A", gate: "정문", note: "5시 15분 전까지 확인 필요", check: true),
        DispatchScheduleItem(name: "김유재", vehicleNumber: "7367", separateRole: "용역", phoneNumber: "010-1234-1234", time: "06:20", path: "망포 1", checkVehicleStatusPlace: "참누리 A", gate: "후문", note: "", check: true)]
    
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
        print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchScheduleViewController: EssentialViewMethods {
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: UIApplication.willEnterForegroundNotification, object: nil)
        
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
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
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
}

// MARK: - Extension for methods added
extension DispatchScheduleViewController {
    func startBlinkingAnimation(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
            view.backgroundColor = .useRGB(red: 176, green: 0, blue: 32, alpha: 0.7)
        }

    }
    
    func stopBlinkingAnimation(view: UIView) {
        view.layer.removeAllAnimations()
        view.backgroundColor = .white
    }
}

// MARK: - Extension for selector methods
extension DispatchScheduleViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func reloadData() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
        }
    }
    
    @objc func removeAnimation() {
        self.tableView.layer.removeAllAnimations()
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scheduleList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchScheduleTableViewCell", for: indexPath) as! DispatchScheduleTableViewCell
        let schedule = self.scheduleList[indexPath.row]
        var isBlinking: Bool = false
        
        cell.setCell(schedule: schedule)
        
        if schedule.check {
            cell.mainView.backgroundColor = .white
            
        } else {
            isBlinking.toggle()
            if isBlinking {
                self.startBlinkingAnimation(view: cell.mainView)
                
            } else {
                self.stopBlinkingAnimation(view: cell.mainView)
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule = self.scheduleList[indexPath.row]
        
        schedule.check = true
    }
}
