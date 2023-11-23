//
//  DispatchViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/02.
//

import UIKit

final class DispatchViewController: UIViewController {
    
    lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.leftButton, self.dateLabel, self.rightButton])
        stackView.axis = .horizontal
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var dateLabel: UILabel = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")!
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.string(from: Date())
        
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.text = "\(todayDate)"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(named: "DayLeftButton"), for: .normal)
        button.addTarget(self, action: #selector(tappedMoveDayBeforeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setImage(UIImage(named: "DayRightButton"), for: .normal)
        button.addTarget(self, action: #selector(tappedMoveDayAfterButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.shared.name ?? ""
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.dispatchMonthlyInfoButton, self.refuelingCheckButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var dispatchMonthlyInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("월간정보", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedPushDispatchMonthlyInfoButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var refuelingCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("주유", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedRefuelingCheckButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
        tableView.register(DispatchTableViewCell.self, forCellReuseIdentifier: "DispatchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var dispatchModel = DispatchModel()
    var dailyDispatchData: [DispatchRegularlyItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pop Slide
        if self.navigationController?.viewControllers.first === self  {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }

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
        
//        self.setViewAfterTransition()
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
extension DispatchViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(dispatchCheck(_:)), name: Notification.Name("LoginDispatchCheck"), object: nil)
    }
    
    func setSubviews() {
        self.view.addSubview(self.dateStackView)
        self.view.addSubview(self.topView)
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.buttonStackView)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.noDataStackView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // dateStackView
        NSLayoutConstraint.activate([
            self.dateStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            self.dateStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        // leftButton
        NSLayoutConstraint.activate([
            self.leftButton.widthAnchor.constraint(equalToConstant: 24),
            self.leftButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // rightButton
        NSLayoutConstraint.activate([
            self.rightButton.widthAnchor.constraint(equalToConstant: 24),
            self.rightButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // topView
        NSLayoutConstraint.activate([
            self.topView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.topView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.topView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 12),
            self.topView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor, constant: 16),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor)
        ])
        
        // buttonStackView
        NSLayoutConstraint.activate([
            self.buttonStackView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -16),
            self.buttonStackView.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor)
        ])
        
        // refuelingCheckButton
        NSLayoutConstraint.activate([
            self.refuelingCheckButton.widthAnchor.constraint(equalToConstant: 75),
            self.refuelingCheckButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // dispatchMonthlyInfoButton
        NSLayoutConstraint.activate([
            self.dispatchMonthlyInfoButton.widthAnchor.constraint(equalToConstant: 75),
            self.dispatchMonthlyInfoButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
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
            self.tableView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 24)
        ])
    }
    
    func setViewAfterTransition() {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        self.tabBarController?.tabBar.isHidden = false
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest(date: self.dateLabel.text!) { dailyInfo in
            self.dailyDispatchData = dailyInfo.regularly
            
            if !dailyInfo.regularly.isEmpty {
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
            print("setData loadDaliyDispatchRequest API Error: \(errorMessage)")
        }

    }
}

// MARK: - Extension for methods added
extension DispatchViewController {
    func loadDailyDispatchRequest(date: String, success: ((DispatchDailyItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDailyDispatchRequest(date: date) { dailyInfo in
            if !dailyInfo.regularly.isEmpty {
                print("wakeTime: \(dailyInfo.regularly[0].checkRegularlyConnect.wakeTime)")
            }
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
    
    func loadMonthlyDispatchRequest(month: String, success: ((DispatchMonthlyItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadMonthlyDispatchRequest(month: month) { monthlyItem in
            success?(monthlyItem)
            
        } dispatchFailure: { reason in
            if reason == 1 {
                print("날짜가 틀림")
            }
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func checkPatchDispatchRequest(checkType: String, time: String, regularlyId: String, orderId: String, success: ((CheckDriveItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.checkPatchDispatchRequest(checkType: checkType, time: time, regularlyId: regularlyId, orderId: orderId) { item in
            success?(item)
            
        } dispatchFailure: { reason in
            print(reason)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
        }
        
    }
    
    func loadDispatchGroupListRequest(success: (([DispatchSearchItemGroupList]) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDispatchGroupListRequest { groupList in
            success?(groupList)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
        
    }
}

// MARK: - Extension for selector methods
extension DispatchViewController {
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchGroupListRequest { groupList in
            let vc = DispatchSearchViewController(groupList: groupList)
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("rightBarButtonItem loadDispatchGroupListRequest API Error: \(errorMessage)")
        }
    }
    
    @objc func tappedMoveDayBeforeButton(_ sender: UIButton) {
        print("Day Before")
        let currentDate = SupportingMethods.shared.convertString(intoDate: self.dateLabel.text!)
        let beforeDate = SupportingMethods.shared.calculateDate(byValue: -1, component: .day, date: currentDate)
        let currentDateString = SupportingMethods.shared.convertDate(intoString: beforeDate)
        
        self.dateLabel.text = currentDateString
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest(date: currentDateString) { dailyInfo in
            self.dailyDispatchData = dailyInfo.regularly
            
            if !dailyInfo.regularly.isEmpty {
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
            print("setData loadDaliyDispatchRequest API Error: \(errorMessage)")
        }
    }
    
    @objc func tappedMoveDayAfterButton(_ sender: UIButton) {
        print("Day After")
        let currentDate = SupportingMethods.shared.convertString(intoDate: self.dateLabel.text!)
        let afterDate = SupportingMethods.shared.calculateDate(byValue: 1, component: .day, date: currentDate)
        let currentDateString = SupportingMethods.shared.convertDate(intoString: afterDate)
        
        print(currentDate)
        print(afterDate)
        print(currentDateString)
        self.dateLabel.text = currentDateString
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest(date: "2023-05-01") { dailyInfo in
            self.dailyDispatchData = dailyInfo.regularly
            
            if !dailyInfo.regularly.isEmpty {
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
            print("setData loadDaliyDispatchRequest API Error: \(errorMessage)")
        }
    }
    
    @objc func tappedPushDispatchMonthlyInfoButton(_ sender: UIButton) {
        print("tappedPushDispatchMonthlyInfoButton")
        
        let currentMonth = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM")
        print(currentMonth)
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadMonthlyDispatchRequest(month: currentMonth) { item in
            
            let vc = DispatchMonthlyViewController(item: item)
            
            for index in 0..<item.attendance.count {
                if item.attendance[index] != 0 {
                    let date: String = index < 9 ? currentMonth + "-0\(index + 1)" : currentMonth + "-\(index + 1)"
                    vc.eventsArray.append(date)
                }
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("calendarCurrentPageDidChange loadMonthlyDispatchRequest API Error: \(errorMessage)")
            
        }
    }
    
    @objc func tappedRefuelingCheckButton(_ sender: UIButton) {
        
    }
    
    @objc func dispatchCheck(_ noti: Notification) {
        guard let dateString = noti.userInfo?["dateString"] as? String else { return }
        
        let vc = DispatchHomeCheckViewController(date: dateString)
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailyDispatchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchTableViewCell", for: indexPath) as! DispatchTableViewCell
        
        cell.setCell(info: self.dailyDispatchData[indexPath.row])
        cell.delegate = self
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - Extension for DispatchDelegate
extension DispatchViewController: DispatchDelegate {
    func tapDriveCheckButton(current: DriveCheckType, info: DispatchRegularlyItem) {
        SupportingMethods.shared.turnCoverView(.on)
        self.checkPatchDispatchRequest(checkType: current.rawValue, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"), regularlyId: "\(info.id)", orderId: "") { item in
            
            self.setData()
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("tappedDriveCheckButton checkPatchDispatchRequest API Error: \(errorMessage)")
            
        }
    }
    
    func tapDetailMapButton(mapLink: String) {
        guard let url = URL(string: mapLink) else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension DispatchViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
}
