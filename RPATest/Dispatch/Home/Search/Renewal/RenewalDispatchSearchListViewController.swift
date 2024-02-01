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
        label.text = "노선이 없습니다"
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(group: DispatchSearchItemGroupList, search: String) {
        self.group = group
        self.search = search
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dispatchModel = DispatchModel()
    var group: DispatchSearchItemGroupList
    var search: String
    var page: Int = 1
    var nextRequest: String?
    var pathList: [DispatchPathRegularlyList] = []
    
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
        self.loadDispatchPathRequestAtBeginning()
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
    func loadDispatchPathRequest(page: Int, search: String, success: ((DispatchPathItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDispatchPathRequest(page: page, search: search, id: self.group.id) { item in
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
extension RenewalDispatchSearchListViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedMapButton(_ sender: UIButton) {
        guard let url = URL(string: self.pathList[sender.tag].maplink) else { return }
        UIApplication.shared.open(url)
        
    }
    
    @objc func tappedBookmarkButton(_ sender: UIButton) {
        self.pathList[sender.tag].isBookmark.toggle()
        
        self.tableView.reloadData()
    }
    
    @objc func tappedDispatchKnowButton(_ sender: UIButton) {
        if self.pathList[sender.tag].know == "true" {
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "노선 숙지를 취소하시겠습니까?", messageContent: "", leftButtonTitle: "취소", leftAction: { }, rightButtonTitle: "확인", rightAction: {
                SupportingMethods.shared.turnCoverView(.on)
                self.pathKnowDeleteRequest(id: self.pathList[sender.tag].id) {
                    self.pathList[sender.tag].know = "false"
                    
                    self.tableView.reloadData()
                    SupportingMethods.shared.turnCoverView(.off)
                    
                } failure: { errorMessage in
                    SupportingMethods.shared.turnCoverView(.off)
                    print("tapPathKnowDeleteButton pathKnowDeleteRequest API Error: \(errorMessage)")
                    
                }
            }))
            
            self.present(vc, animated: false)
            
        } else {
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "노선 숙지가 완료되었습니까?", messageContent: "", leftButtonTitle: "취소", leftAction: { }, rightButtonTitle: "확인", rightAction: {
                SupportingMethods.shared.turnCoverView(.on)
                self.pathKnowRequest(id: self.pathList[sender.tag].id) { item in
                    self.pathList[sender.tag].know = "true"
                    
                    self.tableView.reloadData()
                    SupportingMethods.shared.turnCoverView(.off)
                    
                } failure: { errorMessage in
                    SupportingMethods.shared.turnCoverView(.off)
                    print("tapPathKnowButton pathKnowRequest API Error: \(errorMessage)")
                    
                }
            }))
            
            self.present(vc, animated: false)
            
        }
    }
}

// MARK: - Extension for
extension RenewalDispatchSearchListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pathList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RenewalDispatchSearchListTableViewCell", for: indexPath) as! RenewalDispatchSearchListTableViewCell
        let path = self.pathList[indexPath.row]
        
        cell.setCell(path: path, index: indexPath.row)
        cell.mapButton.addTarget(self, action: #selector(tappedMapButton(_:)), for: .touchUpInside)
        cell.starButton.addTarget(self, action: #selector(tappedBookmarkButton(_:)), for: .touchUpInside)
        cell.dispatchKnowButton.addTarget(self, action: #selector(tappedDispatchKnowButton(_:)), for: .touchUpInside)
        
        if indexPath.row == self.pathList.count - 1 && self.nextRequest != nil {
            self.loadDispatchPathRequest(page: self.page + 1)
        }
        
        return cell
    }
}
