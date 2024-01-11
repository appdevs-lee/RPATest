//
//  DispatchScheduleViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/9/23.
//

import UIKit

enum DispatchStatus: Int {
    case wake = 0
    case boarding = 1
    case driving = 2
}

final class DispatchScheduleViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
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
        DispatchScheduleItem(id: 1, name: "이성곤", vehicleNumber: "1701", phoneNumber: "010-1234-0234", time: "06:55", pathName: "써니밸리", arrivalName: "K1", breathalyzing: "0.0", note: "없음.", check: true, status: (wake: false, boarding: false, driving: false)),
        DispatchScheduleItem(id: 10, name: "김성일", vehicleNumber: "3127", phoneNumber: "010-1234-1234", time: "06:45", pathName: "수원여고_H1_(리디아35분, 여산 40분, 성화45분)", arrivalName: "기존노선투가추입", breathalyzing: "0.0", note: "", check: false, status: (wake: true, boarding: true, driving: false)),
        DispatchScheduleItem(id: 20, name: "최오명", vehicleNumber: "8444", phoneNumber: "010-1234-1234", time: "06:20", pathName: "수지로얄스포츠", arrivalName: "K1-DSR", breathalyzing: "0.0", note: "", check: false, status: (wake: true, boarding: true, driving: true)),
        DispatchScheduleItem(id: 30, name: "송승우", vehicleNumber: "7254", phoneNumber: "010-1234-1234", time: "07:10", pathName: "구반포", arrivalName: "H1-DSR", breathalyzing: "0.0", note: "", check: false, status: (wake: true, boarding: false, driving: false)),
    ]
    
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
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- DispatchScheduleViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchScheduleViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        
        cell.setCell(schedule: schedule)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let schedule = self.scheduleList[indexPath.row]
        let vc = DispatchScheduleDetailViewController(nowSchedule: schedule)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
