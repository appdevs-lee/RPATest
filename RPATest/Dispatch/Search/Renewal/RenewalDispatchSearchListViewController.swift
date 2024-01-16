//
//  RenewalDispatchSearchListViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/16/24.
//

import UIKit

final class RenewalDispatchSearchListViewController: UIViewController {
    
    lazy var topBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 224, green: 224, blue: 227)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var busTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "버스구분"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var busLabel: UILabel = {
        let label = UILabel()
        label.text = "출근"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var firstSeparateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var searchClassificationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색구분"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var searchClassificationLabel: UILabel = {
        let label = UILabel()
        label.text = "노선명"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var secondSeparateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var searchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색어"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RenewalDispatchSearchListTableViewCell.self, forCellReuseIdentifier: "RenewalDispatchSearchListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
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
        print("----------------------------------- RenewalDispatchSearchListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalDispatchSearchListViewController: EssentialViewMethods {
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
            self.topBaseView,
            self.busTitleLabel,
            self.busLabel,
            self.firstSeparateView,
            self.searchClassificationTitleLabel,
            self.searchClassificationLabel,
            self.secondSeparateView,
            self.searchTitleLabel,
            self.searchLabel,
            self.tableView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // topBaseView
        NSLayoutConstraint.activate([
            self.topBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.topBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.topBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
        ])
        
        // busTitleLabel
        NSLayoutConstraint.activate([
            self.busTitleLabel.leadingAnchor.constraint(equalTo: self.topBaseView.leadingAnchor, constant: 32),
            self.busTitleLabel.topAnchor.constraint(equalTo: self.topBaseView.topAnchor, constant: 10)
        ])
        
        // busLabel
        NSLayoutConstraint.activate([
            self.busLabel.centerXAnchor.constraint(equalTo: self.busTitleLabel.centerXAnchor),
            self.busLabel.topAnchor.constraint(equalTo: self.busTitleLabel.bottomAnchor, constant: 8),
            self.busLabel.bottomAnchor.constraint(equalTo: self.topBaseView.bottomAnchor, constant: -20)
        ])
        
        // firstSeparateView
        NSLayoutConstraint.activate([
            self.firstSeparateView.leadingAnchor.constraint(equalTo: self.busTitleLabel.trailingAnchor, constant: 32),
            self.firstSeparateView.topAnchor.constraint(equalTo: self.topBaseView.topAnchor, constant: 10),
            self.firstSeparateView.bottomAnchor.constraint(equalTo: self.topBaseView.bottomAnchor, constant: -10),
            self.firstSeparateView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        // searchClassificationTitleLabel
        NSLayoutConstraint.activate([
            self.searchClassificationTitleLabel.topAnchor.constraint(equalTo: self.topBaseView.topAnchor, constant: 10),
            self.searchClassificationTitleLabel.leadingAnchor.constraint(equalTo: self.firstSeparateView.trailingAnchor, constant: 32),
        ])
        
        // searchClassificationLabel
        NSLayoutConstraint.activate([
            self.searchClassificationLabel.centerXAnchor.constraint(equalTo: self.searchClassificationTitleLabel.centerXAnchor),
            self.searchClassificationLabel.topAnchor.constraint(equalTo: self.searchClassificationTitleLabel.bottomAnchor, constant: 8),
            self.searchClassificationLabel.bottomAnchor.constraint(equalTo: self.topBaseView.bottomAnchor, constant: -10)
        ])
        
        // secondSeparateView
        NSLayoutConstraint.activate([
            self.secondSeparateView.leadingAnchor.constraint(equalTo: self.searchClassificationTitleLabel.trailingAnchor, constant: 32),
            self.secondSeparateView.topAnchor.constraint(equalTo: self.topBaseView.topAnchor, constant: 10),
            self.secondSeparateView.bottomAnchor.constraint(equalTo: self.topBaseView.bottomAnchor, constant: -10),
            self.secondSeparateView.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        // searchTitleLabel
        NSLayoutConstraint.activate([
            self.searchTitleLabel.topAnchor.constraint(equalTo: self.topBaseView.topAnchor, constant: 10),
            self.searchTitleLabel.leadingAnchor.constraint(equalTo: self.secondSeparateView.trailingAnchor, constant: 32)
        ])
        
        // searchLabel
        NSLayoutConstraint.activate([
            self.searchLabel.centerXAnchor.constraint(equalTo: self.searchTitleLabel.centerXAnchor),
            self.searchLabel.topAnchor.constraint(equalTo: self.searchTitleLabel.bottomAnchor, constant: 8),
            self.searchLabel.bottomAnchor.constraint(equalTo: self.topBaseView.bottomAnchor, constant: -10)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topBaseView.bottomAnchor),
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
    
    func setUpNavigationItem() {
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
extension RenewalDispatchSearchListViewController {
    
}

// MARK: - Extension for selector methods
extension RenewalDispatchSearchListViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

// MARK: - Extension for
extension RenewalDispatchSearchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RenewalDispatchSearchListTableViewCell", for: indexPath) as! RenewalDispatchSearchListTableViewCell
        
        cell.setCell()
        
        return cell
    }
}
