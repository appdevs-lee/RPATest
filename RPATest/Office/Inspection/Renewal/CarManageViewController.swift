//
//  CarManageViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/22/24.
//

import UIKit

struct CarManage {
    let title: String
    let status: Bool // true: 완료, false: 미완료
    let kinds: DispatchInspectionType
}

final class CarManageViewController: UIViewController {
    
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
        formatter.dateFormat = "yyyy-MM"
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
        button.setImage(UIImage(named: "DayLeftButton"), for: .normal)
        button.addTarget(self, action: #selector(tappedMoveDayBeforeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "DayRightButton"), for: .normal)
        button.addTarget(self, action: #selector(tappedMoveDayAfterButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CarManageTableViewCell.self, forCellReuseIdentifier: "CarManageTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let dataList: [CarManage] = [
        CarManage(title: "\(SupportingMethods.shared.convertDate(intoString: Date(), "yyyy년 MM월 dd일")) 일일점검", status: true, kinds: .daily),
        CarManage(title: "2024년 01월 1주차", status: true, kinds: .weekly),
        CarManage(title: "2024년 01월 2주차", status: true, kinds: .weekly),
        CarManage(title: "2024년 01월 3주차", status: true, kinds: .weekly),
        CarManage(title: "2024년 01월 4주차", status: true, kinds: .weekly),
        CarManage(title: "2024년 01월 5주차", status: false, kinds: .weekly),
        CarManage(title: "2024년 01월 월간점검", status: true, kinds: .monthly)
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
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- CarManageViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CarManageViewController: EssentialViewMethods {
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
            self.dateStackView,
            self.tableView
        ], to: self.view)
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
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.dateStackView.bottomAnchor, constant: 10),
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
        self.view.backgroundColor = .white
        
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
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension CarManageViewController {
    
}

// MARK: - Extension for selector methods
extension CarManageViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedMoveDayBeforeButton(_ sender: UIButton) {
        print("Month Before")
        let currentMonth = SupportingMethods.shared.convertString(intoDate: self.dateLabel.text!, "yyyy-MM")
        let beforeMonth = SupportingMethods.shared.calculateDate(byValue: -1, component: .month, date: currentMonth)
        let currentMonthString = SupportingMethods.shared.convertDate(intoString: beforeMonth, "yyyy-MM")
        
        self.dateLabel.text = currentMonthString
        
        // api 넣기
    }
    
    @objc func tappedMoveDayAfterButton(_ sender: UIButton) {
        print("Month After")
        let currentMonth = SupportingMethods.shared.convertString(intoDate: self.dateLabel.text!, "yyyy-MM")
        let afterMonth = SupportingMethods.shared.calculateDate(byValue: 1, component: .month, date: currentMonth)
        let currentMonthString = SupportingMethods.shared.convertDate(intoString: afterMonth, "yyyy-MM")
        
        print(currentMonthString)
        self.dateLabel.text = currentMonthString
        
        // api 넣기
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension CarManageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarManageTableViewCell", for: indexPath) as! CarManageTableViewCell
        let data = self.dataList[indexPath.row]
        
        cell.setCell(data: data)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.dataList[indexPath.row]
        let vc = CarManageInspectionViewController(kinds: data.kinds, title: data.title)
        
        self.present(vc, animated: true)
    }
}
