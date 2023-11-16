//
//  OrganizationSearchViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/16/23.
//

import UIKit

final class OrganizationSearchViewController: UIViewController {
    
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
        tableView.keyboardDismissMode = .none
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(OrganizationSearchTableViewCell.self, forCellReuseIdentifier: "OrganizationSearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let organizationModel = OrganizationModel()
    var memberList: [MemberDetailItem] = []
    var isSearching: Bool = false
    var page: Int = 1
    var nextRequest: String?
    var searchText: String = ""
    
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
        self.setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- OtherCompanyViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension OrganizationSearchViewController: EssentialViewMethods {
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
            self.tableView,
            self.noDataStackView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // noDataStackView
        NSLayoutConstraint.activate([
            self.noDataStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.noDataStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
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
        
        self.navigationItem.title = "검색"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setUpSearchController() {
        self.searchController.searchBar.placeholder = "이름으로 검색해 주세요."
        self.searchController.searchBar.searchTextField.textColor = .black
        self.searchController.searchBar.searchTextField.backgroundColor = .white
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.automaticallyShowsCancelButton = false
        
        // searchbar에 text가 업데이트 될 때마다 불리는 메소드를 위한 설정
        self.searchController.searchResultsUpdater = self
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
}

// MARK: - Extension for methods added
extension OrganizationSearchViewController {
    func memberSearchRequest(page: Int, search: String, success: ((MemberItem) -> ())?, failure: ((String) -> ())?) {
        self.organizationModel.memberSearchRequest(page: page, search: search, role: "") { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func memberSearchRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.memberSearchRequest(page: page, search: self.searchText) { item in
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
            print("loadDispatchPathRequest API Error: \(errorMessage)")
        }

    }
}

// MARK: - Extension for selector methods
extension OrganizationSearchViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension OrganizationSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationSearchTableViewCell", for: indexPath) as! OrganizationSearchTableViewCell
        let member = self.memberList[indexPath.row]
        
        cell.setCell(member: member)
        
        if indexPath.row == self.memberList.count - 1 && self.nextRequest != nil {
            self.memberSearchRequest(page: self.page + 1)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = self.memberList[indexPath.row]
        
        if let url = URL(string: "tel://\(member.phoneNum)") {
            UIApplication.shared.open(url)
            
        }
    }
}


// MARK: - Extension for UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating 
extension OrganizationSearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text ?? ""
        
        SupportingMethods.shared.turnCoverView(.on)
        self.memberSearchRequest(page: 1, search: self.searchText) { item in
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
            print("searchBarSearchButtonClicked memberSearchRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
