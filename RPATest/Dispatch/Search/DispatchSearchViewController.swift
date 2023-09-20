//
//  DispatchSearchViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/18.
//

import UIKit

final class DispatchSearchViewController: UIViewController {
    
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
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchSearchTableViewCell.self, forCellReuseIdentifier: "DispatchSearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init(groupList: [DispatchSearchItemGroupList]) {
        self.groupList = groupList
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dispatchModel = DispatchModel()
    let searchController = UISearchController(searchResultsController: nil)
    var groupList: [DispatchSearchItemGroupList] = []
    var group: DispatchSearchItemGroupList?
    var search: String = ""
    var page: Int = 1
    var nextRequest: String?
    
    var pathList: [DispatchPathRegularlyList] = []
    
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
        self.setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchController.searchBar.resignFirstResponder()
    }
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    deinit {
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchSearchViewController: EssentialViewMethods {
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
        NotificationCenter.default.addObserver(self, selector: #selector(addGroupData(_:)), name: Notification.Name("SendGroup"), object: nil)
    }
    
    func setSubviews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.noDataStackView)
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
            self.noDataStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.noDataStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
        
        let vc = DispatchCategoryViewController(groupList: self.groupList)
        
        self.present(vc, animated: true)
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
//        appearance.backgroundColor = .useRGB(red: 176, green: 0, blue: 32) // Navigation bar is transparent and root view appears on it.
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
//        self.navigationItem.titleView = self.setUpNavigationTitle()
        self.navigationItem.title = "노선 검색"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setUpSearchController() {
        self.searchController.searchBar.placeholder = "원하는 내용을 입력해 주세요."
        self.searchController.searchBar.searchTextField.textColor = .white
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.automaticallyShowsCancelButton = false
        
        // filterButton 추가
        self.searchController.searchBar.showsBookmarkButton = true
        self.searchController.searchBar.setImage(UIImage(systemName: "text.alignleft"), for: .bookmark, state: .normal)
        
        // searchbar에 text가 업데이트 될 때마다 불리는 메소드를 위한 설정
        self.searchController.searchResultsUpdater = self
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Extension for methods added
extension DispatchSearchViewController {
    func loadDispatchPathRequest(page: Int, search: String, success: ((DispatchPathItem) -> ())?, failure: ((String) -> ())?) {
        guard let id = self.group?.id else {
            SupportingMethods.shared.turnCoverView(.off)
            return
        }
        self.dispatchModel.loadDispatchPathRequest(page: page, search: search, id: id) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
    }
    
    func loadDispatchPathRequestAtBeginning() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchPathRequest(page: 1, search: self.search) { item in
            self.page = 1
            self.pathList = item.regularlyList
            self.nextRequest = item.next
            
            self.tableView.reloadData()
            
            if self.pathList.isEmpty {
                self.noDataStackView.isHidden = false
            } else {
                self.noDataStackView.isHidden = true
            }
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadDispatchPathRequestAtBeginning API Error: \(errorMessage)")
        }
    }
    
    func loadDispatchPathRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchPathRequest(page: page, search: self.search) { item in
            self.page = page
            self.nextRequest = item.next
            
            let list = item.regularlyList
            self.pathList.append(contentsOf: list)
            
            if !list.isEmpty {
                self.tableView.reloadData()
            }
            
            if self.pathList.isEmpty {
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
    
    func pathKnowRequest(id: Int, success: ((DispatchPathKnowItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.pathKnowRequest(id: id) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func pathKnowDeleteRequest(id: Int, success: (() -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.pathKnowDeleteRequest(id: id) { 
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
    }
}

// MARK: - Extension for selector methods
extension DispatchSearchViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func addGroupData(_ noti: Notification) {
        
        SupportingMethods.shared.turnCoverView(.on)
        guard let group = noti.userInfo?["group"] as? DispatchSearchItemGroupList else {
            SupportingMethods.shared.turnCoverView(.off)
            return
        }
        
        self.group = group
        self.searchController.searchBar.placeholder = "\(group.name)에서 검색합니다."
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
        }
        
    }
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension DispatchSearchViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
}

extension DispatchSearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let vc = DispatchCategoryViewController(groupList: self.groupList)
        
        self.present(vc, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search = searchBar.text ?? ""
        self.loadDispatchPathRequestAtBeginning()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pathList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchSearchTableViewCell", for: indexPath) as! DispatchSearchTableViewCell
        let searchResult = self.pathList[indexPath.row]
        
        cell.setCell(searchResult: searchResult)
        cell.delegate = self
        
        cell.selectionStyle = .none
        
        if indexPath.row == self.pathList.count - 1 && self.nextRequest != nil {
            self.loadDispatchPathRequest(page: self.page + 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension DispatchSearchViewController: DispatchSearchDelegate {
    func tapPathKnowButton(id: Int, button: UIButton) {
        let vc = AlertPopViewController(.normalTwoButton(messageTitle: "노선 숙지가 완료되었습니까?", messageContent: "", leftButtonTitle: "취소", leftAction: { }, rightButtonTitle: "확인", rightAction: {
            SupportingMethods.shared.turnCoverView(.on)
            self.pathKnowRequest(id: id) { item in
                button.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                button.setTitle("노선숙지 취소", for: .normal)
                
                SupportingMethods.shared.turnCoverView(.off)
                self.loadDispatchPathRequestAtBeginning()
                
            } failure: { errorMessage in
                SupportingMethods.shared.turnCoverView(.off)
                print("tapPathKnowButton pathKnowRequest API Error: \(errorMessage)")
                
            }
        }))
        
        self.present(vc, animated: false)
    }
    
    func tapPathKnowDeleteButton(id: Int, button: UIButton) {
        let vc = AlertPopViewController(.normalTwoButton(messageTitle: "노선 숙지를 취소하시겠습니까?", messageContent: "", leftButtonTitle: "취소", leftAction: { }, rightButtonTitle: "확인", rightAction: {
            SupportingMethods.shared.turnCoverView(.on)
            self.pathKnowDeleteRequest(id: id) {
                button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
                button.setTitle("노선숙지 완료", for: .normal)
                
                SupportingMethods.shared.turnCoverView(.off)
                self.loadDispatchPathRequestAtBeginning()
            } failure: { errorMessage in
                SupportingMethods.shared.turnCoverView(.off)
                print("tapPathKnowDeleteButton pathKnowDeleteRequest API Error: \(errorMessage)")
                
            }
        }))
        
        self.present(vc, animated: false)
    }
    
    func tapKakaoMapButton(mapLink: String) {
        guard let url = URL(string: mapLink) else { return }
        UIApplication.shared.open(url)
    }
}
