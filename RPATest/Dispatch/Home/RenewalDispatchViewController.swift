//
//  RenewalDispatchViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/22/23.
//

import UIKit

final class RenewalDispatchViewController: UIViewController {
    
    lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "안전 운행하세요\n\(UserInfo.shared.name!) 기사님"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var alarmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(tappedAlarmButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "homeSearch"), for: .normal)
        button.addTarget(self, action: #selector(tappedSearchButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchCheckView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var dispatchCheckLabel: UILabel = {
        let label = UILabel()
        label.text = "운행수락"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchCheckButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedDispatchCheckButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchNoteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchNoteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var dispatchNoteLabel: UILabel = {
        let label = UILabel()
        label.text = "운행일보"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchNoteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedDispatchNoteButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var taskView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 외 업무"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 외 업무가 3개 남았습니다."
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var taskImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var taskButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedTaskButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var todayDispatchLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 배차"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RenewalDispatchRegularlyTableViewCell.self, forCellReuseIdentifier: "RenewalDispatchRegularlyTableViewCell")
        tableView.register(RenewalDispatchOrderTableViewCell.self, forCellReuseIdentifier: "RenewalDispatchOrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.layer.cornerRadius = 10
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
        label.text = "금일 등록된 배차가 없습니다"
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var accidentResponseButton: UIButton = {
        let button = UIButton()
        button.setTitle("사고 발생", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(tappedAccidentResponseButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if ReferenceValues.currentCompany == "dev" {
            button.isHidden = false
            
        } else {
            button.isHidden = true
            
        }
        
        return button
    }()
    
    let dispatchModel = DispatchModel()
    var regularlyList: [DispatchRegularlyItem] = []
    var orderList: [DispatchOrderItem] = []
    
    var regularlyItem: DispatchRegularlyItem?
    var orderItem: DispatchOrderItem?
    
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
        print("----------------------------------- RenewalDispatchViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalDispatchViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(dispatchCheck(_:)), name: Notification.Name("LoginDispatchCheck"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drivingDone(_:)), name: Notification.Name("NoteWriteCompleted"), object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.nameTitleLabel,
            self.alarmButton,
            self.searchButton,
            self.dispatchCheckView,
            self.dispatchCheckImageView,
            self.dispatchCheckLabel,
            self.dispatchCheckButton,
            self.dispatchNoteView,
            self.dispatchNoteImageView,
            self.dispatchNoteLabel,
            self.dispatchNoteButton,
            self.taskView,
            self.taskLabel,
            self.subTaskLabel,
            self.taskImageView,
            self.taskButton,
            self.todayDispatchLabel,
            self.tableView,
            self.noDataStackView,
            self.accidentResponseButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // nameTitleLabel
        NSLayoutConstraint.activate([
            self.nameTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.nameTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16)
        ])
        
        // alarmButton
        NSLayoutConstraint.activate([
            self.alarmButton.trailingAnchor.constraint(equalTo: self.searchButton.leadingAnchor, constant: -8),
            self.alarmButton.centerYAnchor.constraint(equalTo: self.searchButton.centerYAnchor),
            self.alarmButton.widthAnchor.constraint(equalToConstant: 16),
            self.alarmButton.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        // searchButton
        NSLayoutConstraint.activate([
            self.searchButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.searchButton.centerYAnchor.constraint(equalTo: self.nameTitleLabel.centerYAnchor),
            self.searchButton.widthAnchor.constraint(equalToConstant: 25),
            self.searchButton.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        // dispatchCheckView
        NSLayoutConstraint.activate([
            self.dispatchCheckView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.dispatchCheckView.topAnchor.constraint(equalTo: self.nameTitleLabel.bottomAnchor, constant: 10),
            self.dispatchCheckView.heightAnchor.constraint(equalToConstant: 80),
            self.dispatchCheckView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 52) / 2.0)
        ])
        
        // dispatchCheckImageView
        NSLayoutConstraint.activate([
            self.dispatchCheckImageView.leadingAnchor.constraint(equalTo: self.dispatchCheckView.leadingAnchor, constant: 16),
            self.dispatchCheckImageView.centerYAnchor.constraint(equalTo: self.dispatchCheckView.centerYAnchor),
            self.dispatchCheckImageView.heightAnchor.constraint(equalToConstant: 28),
            self.dispatchCheckImageView.widthAnchor.constraint(equalToConstant: 28)
        ])
        
        // dispatchCheckLabel
        NSLayoutConstraint.activate([
            self.dispatchCheckLabel.leadingAnchor.constraint(equalTo: self.dispatchCheckImageView.trailingAnchor, constant: 10),
            self.dispatchCheckLabel.centerYAnchor.constraint(equalTo: self.dispatchCheckImageView.centerYAnchor)
        ])
        
        // dispatchCheckButton
        NSLayoutConstraint.activate([
            self.dispatchCheckButton.leadingAnchor.constraint(equalTo: self.dispatchCheckView.leadingAnchor),
            self.dispatchCheckButton.trailingAnchor.constraint(equalTo: self.dispatchCheckView.trailingAnchor),
            self.dispatchCheckButton.topAnchor.constraint(equalTo: self.dispatchCheckView.topAnchor),
            self.dispatchCheckButton.bottomAnchor.constraint(equalTo: self.dispatchCheckView.bottomAnchor)
        ])
        
        // dispatchNoteView
        NSLayoutConstraint.activate([
            self.dispatchNoteView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.dispatchNoteView.topAnchor.constraint(equalTo: self.nameTitleLabel.bottomAnchor, constant: 10),
            self.dispatchNoteView.heightAnchor.constraint(equalToConstant: 80),
            self.dispatchNoteView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 52) / 2.0)
        ])
        
        // dispatchNoteImageView
        NSLayoutConstraint.activate([
            self.dispatchNoteImageView.leadingAnchor.constraint(equalTo: self.dispatchNoteView.leadingAnchor, constant: 16),
            self.dispatchNoteImageView.centerYAnchor.constraint(equalTo: self.dispatchNoteView.centerYAnchor),
            self.dispatchNoteImageView.heightAnchor.constraint(equalToConstant: 28),
            self.dispatchNoteImageView.widthAnchor.constraint(equalToConstant: 28)
        ])
        
        // dispatchNoteLabel
        NSLayoutConstraint.activate([
            self.dispatchNoteLabel.leadingAnchor.constraint(equalTo: self.dispatchNoteImageView.trailingAnchor, constant: 10),
            self.dispatchNoteLabel.centerYAnchor.constraint(equalTo: self.dispatchNoteImageView.centerYAnchor)
        ])
        
        // dispatchNoteButton
        NSLayoutConstraint.activate([
            self.dispatchNoteButton.leadingAnchor.constraint(equalTo: self.dispatchNoteView.leadingAnchor),
            self.dispatchNoteButton.trailingAnchor.constraint(equalTo: self.dispatchNoteView.trailingAnchor),
            self.dispatchNoteButton.topAnchor.constraint(equalTo: self.dispatchNoteView.topAnchor),
            self.dispatchNoteButton.bottomAnchor.constraint(equalTo: self.dispatchNoteView.bottomAnchor)
        ])
        
        // taskView
        NSLayoutConstraint.activate([
            self.taskView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.taskView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.taskView.topAnchor.constraint(equalTo: self.dispatchCheckView.bottomAnchor, constant: 16),
        ])
        
        // taskLabel
        NSLayoutConstraint.activate([
            self.taskLabel.leadingAnchor.constraint(equalTo: self.taskView.leadingAnchor, constant: 16),
            self.taskLabel.topAnchor.constraint(equalTo: self.taskView.topAnchor, constant: 10),
            self.taskLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // subTaskLabel
        NSLayoutConstraint.activate([
            self.subTaskLabel.leadingAnchor.constraint(equalTo: self.taskView.leadingAnchor, constant: 16),
            self.subTaskLabel.topAnchor.constraint(equalTo: self.taskLabel.bottomAnchor, constant: 8),
            self.subTaskLabel.bottomAnchor.constraint(equalTo: self.taskView.bottomAnchor, constant: -10),
            self.subTaskLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // taskImageView
        NSLayoutConstraint.activate([
            self.taskImageView.trailingAnchor.constraint(equalTo: self.taskView.trailingAnchor, constant: -16),
            self.taskImageView.centerYAnchor.constraint(equalTo: self.taskView.centerYAnchor),
            self.taskImageView.heightAnchor.constraint(equalToConstant: 28),
            self.taskImageView.widthAnchor.constraint(equalToConstant: 28)
        ])
        
        // taskButton
        NSLayoutConstraint.activate([
            self.taskButton.leadingAnchor.constraint(equalTo: self.taskView.leadingAnchor),
            self.taskButton.trailingAnchor.constraint(equalTo: self.taskView.trailingAnchor),
            self.taskButton.topAnchor.constraint(equalTo: self.taskView.topAnchor),
            self.taskButton.bottomAnchor.constraint(equalTo: self.taskView.bottomAnchor),
        ])
        
        // todayDispatchLabel
        NSLayoutConstraint.activate([
            self.todayDispatchLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.todayDispatchLabel.topAnchor.constraint(equalTo: self.taskView.bottomAnchor, constant: 16),
            self.todayDispatchLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.todayDispatchLabel.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16)
        ])
        
        // noDataStackView
        NSLayoutConstraint.activate([
            self.noDataStackView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            self.noDataStackView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor)
        ])
        
        // accidentResponseButton
        NSLayoutConstraint.activate([
            self.accidentResponseButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            self.accidentResponseButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
            self.accidentResponseButton.heightAnchor.constraint(equalToConstant: 40),
            self.accidentResponseButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest { item in
            self.regularlyList = item.regularly
            self.orderList = item.order
            
            if item.regularly.isEmpty && item.order.isEmpty {
                self.noDataStackView.isHidden = false
                
            }
            
            for index in 0..<item.regularly.count {
                self.loadDispatchNoteDetailRequest(regularlyId: "\(self.regularlyList[index].id)", orderId: "") { item in
                    self.regularlyList[index].doneCheck = item.submitCheck
                    SupportingMethods.shared.turnCoverView(.off)
                    
                    self.tableView.reloadData()
                } failure: { errorMessage in
                    print("setData loadDispatchNoteDetailRequest API Error: \(errorMessage)")
                    SupportingMethods.shared.turnCoverView(.off)
                    
                }
            }
            
        } failure: { errorMessage in
            print("setData loadDailyDispatchRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
}

// MARK: - Extension for methods added
extension RenewalDispatchViewController {
    func loadDailyDispatchRequest(success: ((DispatchDailyItem) -> ())?, failure: ((String) -> ())?) {
        let date = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd")
        
        self.dispatchModel.loadDailyDispatchRequest(date: date) { dailyInfo in
            success?(dailyInfo)
            
        } dispatchFailure: { reason in
            if reason == 1 {
                print("날짜 입력이 잘못되었습니다.")
            }
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func loadMonthlyDispatchRequest(month: String, success: ((DispatchMonthlyItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadMonthlyDispatchRequest(month: month) { monthlyItem in
            success?(monthlyItem)
            
        } dispatchFailure: { reason in
            if reason == 1 {
                print("날짜가 틀림")
            }
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func loadDispatchGroupListRequest(success: (([DispatchSearchItemGroupList]) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDispatchGroupListRequest { groupList in
            success?(groupList)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
        
    }
    
    func checkPatchDispatchRequest(checkType: String, time: String, regularlyId: String, orderId: String, success: ((CheckDriveItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.checkPatchDispatchRequest(checkType: checkType, time: time, regularlyId: regularlyId, orderId: orderId) { item in
            success?(item)
            
        } dispatchFailure: { reason in
            print(reason)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
        }
        
    }
    
    // MARK: - 운행일보 작성 여부 Check 및 운행 종료 Check
    func loadDispatchNoteDetailRequest(regularlyId: String = "", orderId: String = "", success: ((DispatchNoteDetailItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.dispatchModel.loadDispatchNoteDetailRequest(regularlyId: regularlyId, orderId: orderId) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
        }

    }
}

// MARK: - Extension for selector methods
extension RenewalDispatchViewController {
    @objc func tappedSearchButton(_ sender: UIButton) {
//        SupportingMethods.shared.turnCoverView(.on)
//        self.loadDispatchGroupListRequest { groupList in
//            let vc = DispatchSearchViewController(groupList: groupList)
//            
//            self.navigationController?.pushViewController(vc, animated: true)
//            SupportingMethods.shared.turnCoverView(.off)
//            
//        } failure: { errorMessage in
//            SupportingMethods.shared.turnCoverView(.off)
//            print("rightBarButtonItem loadDispatchGroupListRequest API Error: \(errorMessage)")
//            
//        }
        
        let vc = RenewalDispatchSearchViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func tappedAlarmButton(_ sender: UIButton) {
        
    }
    
    @objc func tappedDispatchCheckButton(_ sender: UIButton) {
        let currentMonth = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM")
        print(currentMonth)
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadMonthlyDispatchRequest(month: currentMonth) { item in
            
            let vc = DispatchMonthlyViewController(item: item)
            
            for index in 0..<item.attendance.count {
                if item.attendance[index] != 0 {
                    let date: String = index < 9 ? currentMonth + "-0\(index + 1)" : currentMonth + "-\(index + 1)"
                    vc.eventsArray.append(date)
                }
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("calendarCurrentPageDidChange loadMonthlyDispatchRequest API Error: \(errorMessage)")
            
        }
    }
    
    @objc func tappedDispatchNoteButton(_ sender: UIButton) {
        let currentMonth = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM")
        print(currentMonth)
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadMonthlyDispatchRequest(month: currentMonth) { item in
            
            let vc = DispatchMonthlyNoteViewController(item: item)
            
            for index in 0..<item.attendance.count {
                if item.attendance[index] != 0 {
                    let date: String = index < 9 ? currentMonth + "-0\(index + 1)" : currentMonth + "-\(index + 1)"
                    vc.eventsArray.append(date)
                }
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("calendarCurrentPageDidChange loadMonthlyDispatchRequest API Error: \(errorMessage)")
            
        }
    }
    
    @objc func tappedTaskButton(_ sender: UIButton) {
        let vc = TaskViewController()
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
    
    @objc func dispatchCheck(_ noti: Notification) {
        guard let dateString = noti.userInfo?["dateString"] as? String else { return }
        
        let vc = DispatchHomeCheckViewController(date: dateString)
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
    
    @objc func drivingDone(_ noti: Notification) {
        self.setData()
        
        self.regularlyItem = nil
        
    }
    
    @objc func tappedAccidentResponseButton(_ sender: UIButton) {
        if ReferenceValues.currentCompany == "dev" {
            let vc = AccidentResponseViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension RenewalDispatchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.regularlyList.count
            
        } else {
            return self.orderList.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RenewalDispatchRegularlyTableViewCell", for: indexPath) as! RenewalDispatchRegularlyTableViewCell
            let item = self.regularlyList[indexPath.row]
            
            cell.setCell(item: item, submitCheck: item.doneCheck)
            cell.delegate = self
            cell.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RenewalDispatchOrderTableViewCell", for: indexPath) as! RenewalDispatchOrderTableViewCell
            let item = self.orderList[indexPath.row]
            
            cell.setCell(item: item)
            cell.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
            
            return cell
        }
    }
}



// MARK: - Extension for UIGestureRecognizerDelegate
extension RenewalDispatchViewController: RenewalDispatchDelegate {
    func tappedStatusButton(item: DispatchRegularlyItem?) {
        guard let item = item else { return }
        self.regularlyItem = item
        
        if item.type == .wake || item.type == .boarding || item.type == .departureArrive {
            SupportingMethods.shared.turnCoverView(.on)
            self.checkPatchDispatchRequest(checkType: item.type.rawValue, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"), regularlyId: "\(item.id)", orderId: "") { item in
                
                self.setData()
            } failure: { errorMessage in
                SupportingMethods.shared.turnCoverView(.off)
                print("tappedDriveCheckButton checkPatchDispatchRequest API Error: \(errorMessage)")
                
            }
        } else {
            if item.type == .driving || item.type == .drivingStart {
                let vc = DispatchDrivingDetailViewController(type: .regularly, regularlyItem: item)
                
                self.navigationController?.pushViewController(vc, animated: true)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            
        }

    }
    
    func tapDetailMapButton(mapLink: String) {
        guard let url = URL(string: mapLink) else { return }
        UIApplication.shared.open(url)
        
    }
    
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension RenewalDispatchViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
}
