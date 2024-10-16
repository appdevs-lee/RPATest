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
    let dispatchModel = NewDispatchModel()
    var item: DailyDispatchDetailItem
    var diaryItem: RunningDiaryItem?
    var dispatchKindType: DispatchKindType
    var isRunningStart: Bool = false
    var isDoneTyping: Bool = false
    var isReadyDriving: Bool = false
    var isDriving: Bool = false
    var isRunningDone: Bool = false
    
    init(item: DailyDispatchDetailItem) {
        self.item = item
        if let _ = item.checkRegularlyConnect {
            self.dispatchKindType = .regularly
            
        } else if let _ = item.checkOrderConnect {
            self.dispatchKindType = .order
            
        } else {
            self.dispatchKindType = .regularly
        }
        
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
        self.setData()
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
    
    func setData() {
        /*
         기상 -> 운행일보 작성 + 아침점호 체크(departureKM 무조건 채워야 함)
         wakeTime이 빈값이면 default 상태.
         departureKM가 빈 값이면 isDoneTyping = false -> 버튼 : 작성 완료
         departureKM가 채워져 있고, driveTime이 빈값이면 -> 버튼 : 탑승 및 출발 준비
         departureKM가 채워져 있고, driveTime이 빈값이 아니면 + departureTime이 빈값이면 -> 버튼 : 첫 출발지 도착
         departureKM가 채워져 있고, departureTime이 빈값이 아니면 -> 버튼 : 운행 종료
         arrivalKM가 채워져 있으면 -> 종료된 배차입니다.
         */
        var connect: ConnectCheck?
        if self.dispatchKindType == .regularly {
            connect = self.item.checkRegularlyConnect
            
        } else {
            connect = self.item.checkOrderConnect
            
        }
        
        SupportingMethods.shared.turnCoverView(.on)
        if connect?.wakeTime != "" {
            self.loadRunningDiaryDataRequest(id: self.item.id) { diaryItem in
                self.diaryItem = diaryItem
                SupportingMethods.shared.turnCoverView(.off)
                if diaryItem.departureKM == "" {
                    // 운행일보 작성 전
                    // 버튼 : 작성 완료
                    // isDoneTyping == false
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                    
                    cell.diaryView.isHidden = false
                    
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                    self.runningStartButton.setTitle("작성 완료", for: .normal)
                    self.isDoneTyping = false
                    
                } else {
                    if connect?.driveTime == "" {
                        // 운행일보 작성 후
                        // 버튼 : 탑승 및 출발 준비
                        // isDoneTyping == true, isReadyDriving == false
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                        guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                        cell.diaryView.isHidden = true
                        
                        self.tableView.reloadData()
                        
                        self.runningStartButton.setTitle("탑승 및 출발 준비", for: .normal)
                        self.isDoneTyping = true
                        
                    } else {
                        if connect?.departureTime == "" {
                            // 탑승 및 출발 준비 이후
                            // 버튼 : 첫 출발지 도착
                            // isDoneTyping == true, isReadyDriving == true, isDriving == false
                            self.runningStartButton.setTitle("첫 출발지 도착", for: .normal)
                            self.isDoneTyping = true
                            self.isReadyDriving = true
                            
                        } else {
                            if diaryItem.arrivalKM == "" {
                                // 운행 중인 상태
                                // 버튼 : 운행 종료
                                // isDoneTyping == true, isReadyDriving == true, isDriving == true, isRunningDone == false
                                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                                if let _ = self.item.detailedRoute {
                                    cell.stationView.reloadData(item: self.item)
                                    cell.diaryView.isHidden = false
                                    cell.stationView.isHidden = false
                                    
                                    self.tableView.reloadData()
                                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                    
                                } else {
                                    cell.diaryView.isHidden = false
                                    cell.stationView.isHidden = true
                                    
                                }
                                
                                self.tableView.reloadData()
                                self.runningStartButton.setTitle("운행 종료", for: .normal)
                                self.isDoneTyping = true
                                self.isReadyDriving = true
                                self.isDriving = true
                                
                            } else {
                                // 운행이 종료된 상태
                                // 버튼 : 종료된 배차입니다.
                                // isDoneTyping == true, isReadyDriving == true, isDriving == true, isRunningDone == true
                                
                                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                                cell.diaryView.isHidden = false
                                cell.stationView.isHidden = true
                                
                                self.tableView.reloadData()
                                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                
                                self.runningStartButton.isEnabled = false
                                self.runningStartButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                                self.runningStartButton.setTitle("종료된 배차입니다.", for: .normal)
                                self.isDoneTyping = true
                                self.isReadyDriving = true
                                self.isDriving = true
                                self.isRunningDone = true
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
        } else {
            self.loadRunningDiaryDataRequest(id: self.item.id) { diaryItem in
                self.diaryItem = diaryItem
                
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
        
    }
}

// MARK: - Extension for methods added
extension RenewalDispatchRunningViewController {
    // 아침점호
    func loadMonrningCheckDataRequest(success: ((Bool) -> ())?) {
        self.vehicleModel.loadMonrningCheckDataRequest { morningCheck in
            success?(morningCheck.submitCheck)
            
        } failure: { message in
            print("loadMonrningCheckDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    // 운행일보 Get
    func loadRunningDiaryDataRequest(id: Int, success: ((RunningDiaryItem) -> ())?) {
        self.dispatchModel.loadRunningDiaryDataRequest(regularlyId: self.dispatchKindType == .regularly ? "\(id)" : "", orderId: self.dispatchKindType == .order ? "\(id)" : "") { item in
            success?(item)
            
        } failure: { message in
            print("loadRunningDiaryDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }

    // 운행일보 Patch
    func sendRunningDiaryDataRequest(id: Int, departureKM: String = "", arrivalKM: String = "", passengerNumber: String = "0", specialNotes: String = "", success: (() -> ())?) {
        self.dispatchModel.sendRunningDiaryDataRequest(regularlyId: self.dispatchKindType == .regularly ? "\(id)" : "", orderId: self.dispatchKindType == .order ? "\(id)" : "", departureDate: self.item.departureDate, arrivalDate: self.item.arrivalDate, departureKM: departureKM, arrivalKM: arrivalKM, passengerNumber: passengerNumber, specialNotes: specialNotes) {
            success?()
            
        } failure: { message in
            print("loadRunningDiaryDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    // 배차확인 Patch
    func sendRunningDataRequest(checkType: String, success: (() -> ())?) {
        // checkType:  기상 -> 운행 -> 출발지
        let regularlyId = self.dispatchKindType == .regularly ? "\(self.item.id)" : ""
        let orderId = self.dispatchKindType == .order ? "\(self.item.id)" : ""
        self.dispatchModel.sendRunningDataRequest(checkType: checkType, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"), regularlyId: regularlyId, orderId: orderId) {
            success?()
            
        } failure: { message in
            print("sendRunningDataRequest API Error: \(message)")
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
        var connect: ConnectCheck?
        if self.dispatchKindType == .regularly {
            connect = self.item.checkRegularlyConnect
            
        } else {
            connect = self.item.checkOrderConnect
            
        }
        
        if connect?.wakeTime == "" {
            // '기상' patch
            // 운행일보(출발 전)
            self.sendRunningDataRequest(checkType: "기상") {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                
                cell.diaryView.isHidden = false
                
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                
                self.runningStartButton.setTitle("작성 완료", for: .normal)
                
            }
            
        } else {
            // 아침점호 check
            self.loadMonrningCheckDataRequest { submitCheck in
                if submitCheck {
                    if self.isDoneTyping {
                        if self.isReadyDriving {
                            if self.isDriving {
                                if self.isRunningDone {
                                    // arrivalKM 적고 운행일보 작성 완료 시 해당 부분 노출
                                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                                    guard cell.diaryView.arrivalFigureTextField.text != "" else {
                                        SupportingMethods.shared.showAlertNoti(title: "도착 시 계기 KM를 입력해주세요.")
                                        return
                                    }
                                    self.sendRunningDiaryDataRequest(id: self.item.id, departureKM: cell.diaryView.departureFigureTextField.text ?? "", arrivalKM: cell.diaryView.arrivalFigureTextField.text ?? "", passengerNumber: cell.diaryView.passengerNumberTextField.text ?? "", specialNotes: cell.diaryView.additionalInfoTextView.text ?? "") {
                                        self.runningStartButton.isEnabled = false
                                        self.runningStartButton.setTitle("종료된 배차입니다.", for: .normal)
                                        self.runningStartButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
                                        
                                    }
                                    
                                } else {
                                    // 운행종료 클릭
                                    // 운행일보 작성
                                    // 도착시 계기 km를 작성해주셔야 배차가 완료됩니다.
                                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                                    cell.diaryView.passengerNumberTextField.text = cell.stationView.calculatePeopleCount()
                                    self.sendRunningDiaryDataRequest(id: self.item.id, departureKM: cell.diaryView.departureFigureTextField.text ?? "", arrivalKM: cell.diaryView.arrivalFigureTextField.text ?? "", passengerNumber: cell.diaryView.passengerNumberTextField.text ?? "", specialNotes: cell.diaryView.additionalInfoTextView.text ?? "") {
                                        self.loadRunningDiaryDataRequest(id: self.item.id) { diaryItem in
                                            self.diaryItem = diaryItem
                                            
                                            cell.diaryView.isHidden = false
                                            cell.stationView.isHidden = true
                                            
                                            self.tableView.reloadData()
                                            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                            
                                            self.runningStartButton.setTitle("작성 완료", for: .normal)
                                            self.isRunningDone = true
                                        }
                                        
                                    }
                                    
                                }
                                
                            } else {
                                // 첫 출발지 도착 클릭
                                // '출발지' patch
                                // 운행중(정류장마다 인원체크)
                                self.sendRunningDataRequest(checkType: "출발지") {
                                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                                    if let _ = self.item.detailedRoute {
                                        cell.stationView.reloadData(item: self.item)
                                        cell.stationView.isHidden = false
                                        
                                        self.tableView.reloadData()
                                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                                        
                                    } else {
                                        cell.stationView.isHidden = true
                                        
                                    }
                                    
                                    self.tableView.reloadData()
                                    self.runningStartButton.setTitle("운행 종료", for: .normal)
                                    self.isDriving = true
                                    
                                }
                                
                            }
                            
                        } else {
                            // 탑승 및 출발 준비 클릭
                            // '운행' patch
                            self.sendRunningDataRequest(checkType: "운행") {
                                self.runningStartButton.setTitle("첫 출발지 도착", for: .normal)
                                self.isReadyDriving = true
                                
                            }
                            
                        }
                        
                    } else {
                        // 작성 완료 클릭
                        // 운행일보 저장
                        // 운행일보 post api 사용
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                        guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? RunningInputTableViewCell else { return }
                        guard cell.diaryView.departureFigureTextField.text != "" else {
                            SupportingMethods.shared.showAlertNoti(title: "출발 시 계기 KM를 입력해주세요.")
                            return
                        }
                        self.sendRunningDiaryDataRequest(id: self.item.id, departureKM: cell.diaryView.departureFigureTextField.text ?? "", arrivalKM: cell.diaryView.arrivalFigureTextField.text ?? "", passengerNumber: cell.diaryView.passengerNumberTextField.text ?? "", specialNotes: cell.diaryView.additionalInfoTextView.text ?? "") {
                            self.loadRunningDiaryDataRequest(id: self.item.id) { diaryItem in
                                self.diaryItem = diaryItem
                                
                                cell.diaryView.isHidden = true
                                
                                self.tableView.reloadData()
                                
                                self.runningStartButton.setTitle("탑승 및 출발 준비", for: .normal)
                                self.isDoneTyping = true
                            }
                            
                        }
                        
                    }
                    
                } else {
                    let vc = RenewalMorningCheckViewController()
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
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
            
            cell.setCell(diaryItem: self.diaryItem)
            
            return cell
            
        }
        
        return UITableViewCell()
    }
}

