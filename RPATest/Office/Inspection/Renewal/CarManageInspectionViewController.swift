//
//  CarManageInspectionViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/22/24.
//

import UIKit

struct InspectionVehicle {
    let title: String
    let status: InspectionStatus
}

final class CarManageInspectionViewController: UIViewController {
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(tappedDismissButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.inspectionTitle
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
        tableView.register(CarManageInspectionTableViewCell.self, forCellReuseIdentifier: "CarManageInspectionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(kinds: DispatchInspectionType, title: String) {
        self.dataList = kinds.data
        self.inspectionTitle = title
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var inspectionTitle: String
    var dataList: [String]
    var status: (fine: Int, normal: Int, notFine: Int) = (1, 0, 0)
    
    var inspectionList: [InspectionVehicle] = []
    
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
        print("----------------------------------- CarManageInspectionViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CarManageInspectionViewController: EssentialViewMethods {
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
        SupportingMethods.shared.addSubviews([
            self.dismissButton,
            self.titleLabel,
            self.tableView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // dismissButton
        NSLayoutConstraint.activate([
            self.dismissButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            self.dismissButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.dismissButton.widthAnchor.constraint(equalToConstant: 40),
            self.dismissButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.dismissButton.centerYAnchor)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setData() {
        for index in 0..<self.dataList.count {
            self.inspectionList.append(InspectionVehicle(title: self.dataList[index], status: .fine))
            
        }
        
        self.tableView.reloadData()
                                       
    }
}

// MARK: - Extension for methods added
extension CarManageInspectionViewController {
    
}

// MARK: - Extension for selector methods
extension CarManageInspectionViewController {
    @objc func tappedDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - Extension for selector methods UITableViewDelegate, UITableViewDataSource
extension CarManageInspectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarManageInspectionTableViewCell", for: indexPath) as! CarManageInspectionTableViewCell
        let data = self.inspectionList[indexPath.row]
        
        cell.setCell(title: data.title, status: data.status)
        
        return cell
    }
}

