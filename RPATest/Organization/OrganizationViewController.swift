//
//  OrganizationViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/03.
//

import UIKit

enum SeparateCurrent {
    case top
    case oneDepth
    case otherCompany
}

final class OrganizationViewController: UIViewController {
    
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
        label.text = "검색 결과가 없습니다"
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(OrganizationTableViewCell.self, forCellReuseIdentifier: "OrganizationTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.useRGB(red: 238, green: 238, blue: 238).cgColor
        button.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 20
        button.setTitle("TOP", for: .normal)
        button.setTitleColor(.useRGB(red: 97, green: 97, blue: 97), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.addTarget(self, action: #selector(tappedBackButton(_:)), for: .touchUpInside)
        
        if self.separateCurrent == .otherCompany {
            button.isEnabled = false
            
        } else {
            button.isEnabled = true
            
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var currentButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.useRGB(red: 97, green: 97, blue: 97), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var navigationViewBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(separateCurrent: SeparateCurrent = .top) {
        self.separateCurrent = separateCurrent
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let organizationModel = OrganizationModel()
    var roleList: [String] = ["관리자", "운전원", "용역"]
    var memberList: [MemberDetailItem] = []
    var clientList: [ClientDetailItem] = []
    var page: Int = 1
    var nextRequest: String?
    
    var current: String = ""
    var separateCurrent: SeparateCurrent = .top
    
    var role: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        
        if self.separateCurrent == .otherCompany {
            self.clientSearchRequestAtBeginning()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    deinit {
            print("----------------------------------- OrganizationViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension OrganizationViewController: EssentialViewMethods {
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
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.noDataStackView)
        self.view.addSubview(self.navigationView)
        self.view.addSubview(self.navigationViewBottomView)
        
        SupportingMethods.shared.addSubviews([
            self.backButton,
            self.currentButton
        ], to: self.navigationView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // navigationView
        NSLayoutConstraint.activate([
            self.navigationView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.navigationView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.navigationView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.navigationView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // backButton
        NSLayoutConstraint.activate([
            self.backButton.leadingAnchor.constraint(equalTo: self.navigationView.leadingAnchor),
            self.backButton.topAnchor.constraint(equalTo: self.navigationView.topAnchor),
            self.backButton.bottomAnchor.constraint(equalTo: self.navigationView.bottomAnchor),
            self.backButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // currentButton
        NSLayoutConstraint.activate([
            self.currentButton.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor),
            self.currentButton.topAnchor.constraint(equalTo: self.navigationView.topAnchor),
            self.currentButton.bottomAnchor.constraint(equalTo: self.navigationView.bottomAnchor),
            self.currentButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        // navigationViewBottomView
        NSLayoutConstraint.activate([
            self.navigationViewBottomView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.navigationViewBottomView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.navigationViewBottomView.topAnchor.constraint(equalTo: self.navigationView.bottomAnchor),
            self.navigationViewBottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.navigationViewBottomView.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // noDataStackView
        NSLayoutConstraint.activate([
            self.noDataStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.noDataStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension OrganizationViewController {
    func memberSearchRequest(page: Int, role: String, success: ((MemberItem) -> ())?, failure: ((String) -> ())?) {
        self.organizationModel.memberSearchRequest(page: page, search: "", role: role) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
    }
    
    func clientSearchRequest(page: Int, success: ((ClientItem) -> ())?, failure: ((String) -> ())?) {
        self.organizationModel.clientSearchRequest(page: page, search: "") { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
    }
    
    func memberSearchRequestAtBeginning() {
        SupportingMethods.shared.turnCoverView(.on)
        self.memberSearchRequest(page: 1, role: self.role) { item in
            self.page = 1
            self.nextRequest = item.next
            self.memberList = item.memberList
            
            if item.memberList.isEmpty {
                self.noDataStackView.isHidden = false
                
            } else {
                self.noDataStackView.isHidden = true
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        } failure: { errorMessage in
            print("setData memberSearchRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }
    }
    
    func memberSearchRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.memberSearchRequest(page: page, role: self.role) { item in
            self.page = page
            self.nextRequest = item.next
            
            self.memberList.append(contentsOf: item.memberList)
            
            if !item.memberList.isEmpty {
                self.tableView.reloadData()
                
            }
            
            if self.memberList.isEmpty {
                self.noDataStackView.isHidden = false
                
            } else {
                self.noDataStackView.isHidden = true
                
            }
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("memberSearchRequest API Error: \(errorMessage)")
        }

    }
    
    func clientSearchRequestAtBeginning() {
        SupportingMethods.shared.turnCoverView(.on)
        self.clientSearchRequest(page: 1) { item in
            self.page = 1
            self.nextRequest = item.next
            self.clientList = item.clientList
            
            if item.clientList.isEmpty {
                self.noDataStackView.isHidden = false
                
            } else {
                self.noDataStackView.isHidden = true
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        } failure: { errorMessage in
            print("setData clientSearchRequestAtBeginning API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }
    }
    
    func clientSearchRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.clientSearchRequest(page: page) { item in
            self.page = page
            self.nextRequest = item.next
            
            self.clientList.append(contentsOf: item.clientList)
            
            if !item.clientList.isEmpty {
                self.tableView.reloadData()
                
            }
            
            if self.clientList.isEmpty {
                self.noDataStackView.isHidden = false
                
            } else {
                self.noDataStackView.isHidden = true
                
            }
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("clientSearchRequest API Error: \(errorMessage)")
        }

    }
}

// MARK: - Extension for selector methods
extension OrganizationViewController {
    @objc func tappedBackButton(_ sender: UIButton) {
        self.separateCurrent = .top
        self.role = ""
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension OrganizationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.separateCurrent {
        case .top:
            return self.roleList.count
            
        case .oneDepth:
            return self.memberList.count
            
        case .otherCompany:
            return self.clientList.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.separateCurrent {
        case .top:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationTableViewCell", for: indexPath) as! OrganizationTableViewCell
            let role = self.roleList[indexPath.row]
            
            self.currentButton.isHidden = true
            cell.profileView.isHidden = true
            cell.profileImageView.isHidden = false
            
            if role == "운전원" {
                cell.nameLabel.text = "정규기사"
                self.current = "정규기사"
                
            } else {
                cell.nameLabel.text = "\(role)"
                
            }
            cell.positionLabel.isHidden = true
            
            cell.arrowImageView.isHidden = false
            
            return cell
            
        case .oneDepth:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationTableViewCell", for: indexPath) as! OrganizationTableViewCell
            let member = self.memberList[indexPath.row]
            
            cell.setCell(member: member)
            
            self.currentButton.isHidden = false
            self.currentButton.setTitle(self.current, for: .normal)
            cell.profileView.isHidden = false
            cell.profileImageView.isHidden = true
            
            cell.positionLabel.isHidden = false
            
            cell.arrowImageView.isHidden = true
            
            if indexPath.row == self.memberList.count - 1 && self.nextRequest != nil {
                self.memberSearchRequest(page: self.page + 1)
                
            }
            
            return cell
            
        case .otherCompany:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationTableViewCell", for: indexPath) as! OrganizationTableViewCell
            let client = self.clientList[indexPath.row]
            
            cell.setCell(client: client)
            
            cell.profileView.isHidden = false
            cell.profileImageView.isHidden = true
            
            cell.positionLabel.isHidden = false
            
            cell.arrowImageView.isHidden = true
            
            if indexPath.row == self.clientList.count - 1 && self.nextRequest != nil {
                self.clientSearchRequest(page: self.page + 1)
                
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.separateCurrent {
        case .top:
            let role = self.roleList[indexPath.row]
            self.separateCurrent = .oneDepth
            self.role = role
            if role == "운전원" {
                self.current = "정규기사"
                
            } else {
                self.current = role
                
            }
            
            
            self.memberSearchRequestAtBeginning()
            
        case .oneDepth:
            let member = self.memberList[indexPath.row]
            
            if let url = URL(string: "tel://\(member.phoneNum)") {
                UIApplication.shared.open(url)
                
            }
            
        case .otherCompany:
            let member = self.clientList[indexPath.row]
            
            if let url = URL(string: "tel://\(member.phoneNum)") {
                UIApplication.shared.open(url)
                
            }
            
        }
    }
}
