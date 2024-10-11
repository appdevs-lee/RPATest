//
//  RenwalDispatchRunningViewController.swift
//  RPATest
//
//  Created by Awesomepia on 10/8/24.
//

import UIKit

final class RenewalDispatchRunningViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RunningMapTableViewCell.self, forCellReuseIdentifier: "RunningMapTableViewCell")
        tableView.register(RunningMainInfoTableViewCell.self, forCellReuseIdentifier: "RunningMainInfoTableViewCell")
        tableView.register(RunningPathTableViewCell.self, forCellReuseIdentifier: "RunningPathTableViewCell")
        tableView.register(RunningReferenceTableViewCell.self, forCellReuseIdentifier: "RunningReferenceTableViewCell")
        tableView.register(RunningInputTableViewCell.self, forCellReuseIdentifier: "RunningInputTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var runningStartButton: UIButton = {
        let button = UIButton()
        button.setTitle("기상 및 운행 시작", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(runningStartButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let vehicleModel = VehicleModel()
    var item: DailyDispatchDetailItem
    var isRunningStart: Bool = false
    var isDoneTyping: Bool = false
    var isReadyDriving: Bool = false
    var isDriving: Bool = false
    var isRunningDone: Bool = false
    
    init(item: DailyDispatchDetailItem) {
        self.item = item
        
        super.init(nibName: nil, bundle: nil)
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
        print("----------------------------------- RenwalDispatchRunningViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalDispatchRunningViewController: EssentialViewMethods {
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
            self.buttonView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.runningStartButton,
        ], to: self.buttonView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.buttonView.topAnchor),
        ])
        
        // buttonView
        NSLayoutConstraint.activate([
            self.buttonView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.buttonView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.buttonView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.buttonView.heightAnchor.constraint(equalToConstant: 58),
        ])
        
        // runningStartButton
        NSLayoutConstraint.activate([
            self.runningStartButton.leadingAnchor.constraint(equalTo: self.buttonView.leadingAnchor, constant: 16),
            self.runningStartButton.trailingAnchor.constraint(equalTo: self.buttonView.trailingAnchor, constant: -16),
            self.runningStartButton.topAnchor.constraint(equalTo: self.buttonView.topAnchor, constant: 5),
            self.runningStartButton.bottomAnchor.constraint(equalTo: self.buttonView.bottomAnchor, constant: -5),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "운행 상세"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension RenewalDispatchRunningViewController {
    func loadMonrningCheckDataRequest(success: ((Bool) -> ())?) {
        self.vehicleModel.loadMonrningCheckDataRequest { morningCheck in
            success?(morningCheck.submitCheck)
            
        } failure: { message in
            print("loadMonrningCheckDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension RenewalDispatchRunningViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // FIXME: 운행과 관련된 API 및 로직 등 구현 보완 해야함.(값 저장 등)
    @objc func runningStartButton(_ sender: UIButton) {
        self.loadMonrningCheckDataRequest { submitCheck in
            if submitCheck {
                if self.isRunningStart {
                    if self.isDoneTyping {
                        if self.isReadyDriving {
                            if self.isDriving {
                                if self.isRunningDone {
                                    self.runningStartButton.isEnabled = false
                                    self.runningStartButton.setTitle("종료된 배차입니다.", for: .normal)
                                    self.runningStartButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                                    
                                } else {
                                    // 운행종료
                                    // 운행일보 작성
                                    // 도착시 계기 km를 작성해주셔야 배차가 완료됩니다.
                                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                                    cell.diaryView.isHidden = false
                                    
                                    self.tableView.reloadData()
                                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                    
                                    self.runningStartButton.setTitle("작성 완료", for: .normal)
                                    self.isRunningDone = true
                                    
                                }
                                
                            } else {
                                // '출발지' post
                                // 운행중(정류장마다 인원체크)
                                guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
        //                        cell.stationView.isHidden = false
                                
                                self.tableView.reloadData()
                                self.runningStartButton.setTitle("운행 종료", for: .normal)
                                self.isDriving = true
                                
                            }
                            
                        } else {
                            // '운행' post
                            // 탑승 및 출발 준비
                            self.runningStartButton.setTitle("첫 출발지 도착", for: .normal)
                            self.isReadyDriving = true
                            
                        }
                        
                    } else {
                        // 운행일보 저장
                        // 운행일보 post api 사용
                        guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                        cell.diaryView.isHidden = true
                        
                        self.tableView.reloadData()
                        
                        self.runningStartButton.setTitle("탑승 및 출발 준비", for: .normal)
                        self.isDoneTyping = true
                        
                    }
                    
                } else {
                    // 운행일보(출발 전)
                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                    
                    cell.diaryView.isHidden = false
                    
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                    
                    self.runningStartButton.setTitle("작성 완료", for: .normal)
                    self.isRunningStart = true
                    
                }
                
            } else {
                let vc = RenewalMorningCheckViewController()
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
        }
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension RenewalDispatchRunningViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RunningMapTableViewCell", for: indexPath) as! RunningMapTableViewCell
            
            cell.setCell(item: self.item)
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RunningMainInfoTableViewCell", for: indexPath) as! RunningMainInfoTableViewCell
            
            cell.setCell(item: self.item)
            
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RunningPathTableViewCell", for: indexPath) as! RunningPathTableViewCell
            
            cell.setCell(item: self.item)
            
            return cell
            
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RunningReferenceTableViewCell", for: indexPath) as! RunningReferenceTableViewCell
            
            cell.setCell(item: self.item)
            
            return cell
            
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RunningInputTableViewCell", for: indexPath) as! RunningInputTableViewCell
            
            cell.setCell()
            
            return cell
            
        }
        
        return UITableViewCell()
    }
}

