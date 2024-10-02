//
//  NotYetDispatchCheckListViewController.swift
//  RPATest
//
//  Created by 이주성 on 10/1/24.
//

import UIKit

final class NotYetDispatchCheckListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NotYetDispatchCheckListTableViewCell.self, forCellReuseIdentifier: "NotYetDispatchCheckListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let dispatchModel = NewDispatchModel()
    var noCheckList: [DailyDispatchDetailItem] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        print("----------------------------------- NotYetDispatchCheckListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension NotYetDispatchCheckListViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        
        // Pop Slide
        if self.navigationController?.viewControllers.first === self  {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(dispatchAccept(_:)), name: Notification.Name("DispatchAccept"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dispatchRefusal(_:)), name: Notification.Name("DispatchRefusal"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dispatchRefusalCompleted(_:)), name: Notification.Name("DispatchRefusalCompleted"), object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest { noCheckList in
            self.noCheckList = noCheckList
            SupportingMethods.shared.turnCoverView(.off)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.noCheckList.isEmpty {
                    self.dismiss(animated: true) {
                        NotificationCenter.default.post(name: Notification.Name("NotYetDispatchCheckCompleted"), object: nil)
                        
                    }
                    
                }
                
            }
            
        }
        
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
        
        self.navigationItem.title = "미확인 배차"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "xmark")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension NotYetDispatchCheckListViewController {
    func loadDailyDispatchRequest(success: (([DailyDispatchDetailItem]) -> ())?) {
        let date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400), "yyyy-MM-dd")
        self.dispatchModel.loadDailyDispatchRequest(date: date) { item in
            var noCheckList: [DailyDispatchDetailItem] = []
            let itemList = item.regularly + item.order
            for item in itemList {
                if let orderConnect = item.checkOrderConnect {
                    if orderConnect.connectCheck == "" {
                        noCheckList.append(item)
                        
                    }
                    
                } else if let regularlyConnect = item.checkRegularlyConnect {
                    if regularlyConnect.connectCheck == "" {
                        noCheckList.append(item)
                        
                    }
                    
                }
                
            }
            
            success?(noCheckList)
            
        } failure: { message in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadWhetherOrNotDispatchCheckRequest API error: \(message)")
            
        }

    }
    
    func sendDispatchCheckDataRequest(check: Check, id: Int, dispatchType: DispatchKindType, success: (() -> ())?) {
        self.dispatchModel.sendDispatchCheckDataRequest(check: check, regularlyId: dispatchType == .regularly ? "\(id)" : "", orderId: dispatchType == .order ? "\(id)" : "") {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.turnCoverView(.off)
            print("sendDispatchCheckDataRequest API Error: \(message)")
            
        }

        
    }
    
}

// MARK: - Extension for selector methods
extension NotYetDispatchCheckListViewController {
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.dismiss(animated: true)
        
    }
    
    @objc func dispatchAccept(_ notification: Notification) {
        guard let item = notification.userInfo?["item"] as? DailyDispatchDetailItem else { return }
        print("item: \(item.id)")
        var dispatchKindType: DispatchKindType?
        
        if let _ = item.checkRegularlyConnect {
            dispatchKindType = .regularly
            
        } else if let _ = item.checkOrderConnect {
            dispatchKindType = .order
            
        }
        
        guard let dispatchKindType = dispatchKindType else { return }
        self.sendDispatchCheckDataRequest(check: .accept, id: item.id, dispatchType: dispatchKindType) {
            self.setData()
            
        }
        
    }
    
    @objc func dispatchRefusal(_ notification: Notification) {
        guard let item = notification.userInfo?["item"] as? DailyDispatchDetailItem else { return }
        print("item: \(item.id)")
        var dispatchKindType: DispatchKindType?
        
        if let _ = item.checkRegularlyConnect {
            dispatchKindType = .regularly
            
        } else if let _ = item.checkOrderConnect {
            dispatchKindType = .order
            
        }
        
        guard let dispatchKindType = dispatchKindType else { return }
        let vc = DispatchRefusalViewController(dispatchKindType: dispatchKindType, id: item.id)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func dispatchRefusalCompleted(_ notification: Notification) {
        self.setData()
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension NotYetDispatchCheckListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noCheckList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotYetDispatchCheckListTableViewCell", for: indexPath) as! NotYetDispatchCheckListTableViewCell
        let item = self.noCheckList[indexPath.row]
        
        cell.setCell(item: item)
        
        return cell
    }
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension NotYetDispatchCheckListViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.navigationController?.visibleViewController is DispatchDrivingPathViewController {
            return false
        }
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
}
