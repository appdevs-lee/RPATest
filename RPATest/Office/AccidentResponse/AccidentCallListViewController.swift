//
//  AccidenCallListViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/18/24.
//

import UIKit

struct EmergencyPhoneBook {
    let name: String
    let part: String
    let phoneNumber: String
}

final class AccidentCallListViewController: UIViewController {
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 3/7
        view.trackTintColor = .useRGB(red: 233, green: 236, blue: 239)
        view.progressTintColor = .useRGB(red: 33, green: 37, blue: 41)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "해당하는 관리자에게 보고"
        label.textColor = .black
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AccidentCallListTableViewCell.self, forCellReuseIdentifier: "AccidentCallListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var phoneList: [EmergencyPhoneBook] = [
        EmergencyPhoneBook(name: "이학현", part: "반도체", phoneNumber: "010-1234-1234"),
        EmergencyPhoneBook(name: "문병근", part: "반도체", phoneNumber: "010-1234-1234"),
        EmergencyPhoneBook(name: "이세명", part: "남양/학단", phoneNumber: "010-1234-1234"),
        EmergencyPhoneBook(name: "김인숙", part: "기타", phoneNumber: "010-1234-1234"),
        EmergencyPhoneBook(name: "홍성철", part: "기타", phoneNumber: "010-1234-1234")
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
    
    deinit {
        print("----------------------------------- AccidenCallListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension AccidentCallListViewController: EssentialViewMethods {
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
            self.progressView,
            self.titleLabel,
            self.tableView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.progressView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.progressView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 10),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
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
        
        self.navigationItem.title = "3. 관리자에게 보고"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        let rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        rightBarButtonItem.setTitleTextAttributes([
            .foregroundColor:UIColor.useRGB(red: 176, green: 0, blue: 32),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ], for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - Extension for methods added
extension AccidentCallListViewController {
    
}

// MARK: - Extension for selector methods
extension AccidentCallListViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = AccidentPhotoViewController()
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func tappedCallButton(_ sender: UIButton) {
        if let url = URL(string: "tel://\(self.phoneList[sender.tag].phoneNumber)") {
            UIApplication.shared.open(url)
            
        }
        
    }
    
}

extension AccidentCallListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.phoneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccidentCallListTableViewCell", for: indexPath) as! AccidentCallListTableViewCell
        let data = self.phoneList[indexPath.row]
        
        cell.setCell(data: data, index: indexPath.row)
        cell.callButton.addTarget(self, action: #selector(tappedCallButton(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.phoneList[indexPath.row]
        if let url = URL(string: "tel://\(data.phoneNumber)") {
            UIApplication.shared.open(url)
            
        }
    }
}
