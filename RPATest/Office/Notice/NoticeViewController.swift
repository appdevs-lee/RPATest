//
//  NoticeViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit

final class NoticeViewController: UIViewController {
    
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
        label.text = "공지가 없습니다"
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
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: "NoticeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let noticeModel = NoticeModel()
    var noticeList: [NoticeItem] = []
    var page: Int = 1
    var nextRequest: String?
    
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
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension NoticeViewController: EssentialViewMethods {
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
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        self.loadNoticeListRequestAtBeginning()
    }
}

// MARK: - Extension for methods added
extension NoticeViewController {
    func loadNoticeListRequest(page: Int, success: ((Notice) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.noticeModel.loadNoticeListRequest(page: page) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func loadNoticeListRequestAtBeginning() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadNoticeListRequest(page: 1) { item in
            self.page = 1
            self.noticeList = item.results
            self.nextRequest = item.next
            
            self.tableView.reloadData()
            
            if self.noticeList.isEmpty {
                self.noDataStackView.isHidden = false
            } else {
                self.noDataStackView.isHidden = true
            }
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadNoticeListRequestAtBeginning API Error: \(errorMessage)")
        }

    }
    
    func loadNoticeListRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadNoticeListRequest(page: page) { item in
            self.page = page
            self.nextRequest = item.next
            
            let list = item.results
            self.noticeList.append(contentsOf: list)
            
            if !list.isEmpty {
                self.tableView.reloadData()
            }
            
            if self.noticeList.isEmpty {
                self.noDataStackView.isHidden = false
            } else {
                self.noDataStackView.isHidden = true
            }
            
            DispatchQueue.main.async {
                SupportingMethods.shared.turnCoverView(.off)
            }
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadNoticeListRequest API Error: \(errorMessage)")
        }

    }
    
    func loadNoticeDetailRequest(id: Int, success: ((NoticeDetail) -> ())?, failure: ((String) -> ())?) {
        self.noticeModel.loadNoticeDetailRequest(id: id) { notice in
            success?(notice)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
    }
}

// MARK: - Extension for selector methods
extension NoticeViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell", for: indexPath) as! NoticeTableViewCell
        let notice = self.noticeList[indexPath.row]
        
        cell.setCell(notice: notice)
        
        if indexPath.row == self.noticeList.count - 1 && self.nextRequest != nil {
            self.loadNoticeListRequest(page: self.page + 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notice = self.noticeList[indexPath.row]
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadNoticeDetailRequest(id: notice.id) { noticeDetail in
            let vc = NoticeDetailViewController(noticeDetail: noticeDetail)
            
            self.navigationController?.pushViewController(vc, animated: true)
            self.noticeModel.saveReadStatus(noticeId: notice.id)
            
            DispatchQueue.main.async {
                tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
            }
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("didSelectRowAt loadNoticeDetailRequest API Error: \(errorMessage)")
        }
    }
}
