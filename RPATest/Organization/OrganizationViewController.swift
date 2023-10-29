//
//  OrganizationViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/03.
//

import UIKit

final class OrganizationViewController: UIViewController {
    
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    let organizationModel = OrganizationModel()
    var memberList: [MemberDetailItem] = []
    var isSearching: Bool = false
    
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
        self.setData()
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchController.searchBar.resignFirstResponder()
        self.tableView.isUserInteractionEnabled = true
    }
    
    deinit {
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
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
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
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
        self.memberSearchRequest(search: "") { memberList in
            self.memberList = memberList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
            
            SupportingMethods.shared.turnCoverView(.off)
        } failure: { errorMessage in
            print("setData memberSearchRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

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
extension OrganizationViewController {
    func memberSearchRequest(search: String, success: (([MemberDetailItem]) -> ())?, failure: ((String) -> ())?) {
        self.organizationModel.memberSearchRequest(search: search) { memberList in
            success?(memberList)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension OrganizationViewController {
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension OrganizationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrganizationTableViewCell", for: indexPath) as! OrganizationTableViewCell
        let member = self.memberList[indexPath.row]
        
        cell.setCell(member: member)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let member = self.memberList[indexPath.row]
        
        if let url = URL(string: "tel://\(member.phoneNum)") {
            UIApplication.shared.open(url)
            
        }
    }
}

extension OrganizationViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.isUserInteractionEnabled = true
        SupportingMethods.shared.turnCoverView(.on)
        self.memberSearchRequest(search: searchBar.text ?? "") { memberList in
            self.memberList = memberList
            
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
        self.setData()
        self.tableView.isUserInteractionEnabled = false
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.setData()
        
    }
}
