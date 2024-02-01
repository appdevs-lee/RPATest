//
//  DayAnalysisViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2/1/24.
//

import UIKit

final class DayAnalysisViewController: UIViewController {
    
    lazy var drivingInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 정보"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var drivingInfoSeparateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var entireMovingDistanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 이동거리"
        label.textColor = .black
        label.font = .useFont(ofSize: 12, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireMovingDistanceBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var entireMovingDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "540"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireMovingDistanceUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "KM"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireFuelTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 주유량"
        label.textColor = .black
        label.font = .useFont(ofSize: 12, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireFuelBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var entireFuelLabel: UILabel = {
        let label = UILabel()
        label.text = "200"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireFuelUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "L"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "총 시간"
        label.textColor = .black
        label.font = .useFont(ofSize: 12, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireTimeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var entireTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "9"
        label.textColor = .black
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var entireTimeUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchListTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배차 목록"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchListSeparateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 242, green: 242, blue: 247)
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DayAnalysisDispatchTableViewCell.self, forCellReuseIdentifier: "DayAnalysisDispatchTableViewCell")
        tableView.register(DayAnalysisDispatchTableViewCell.self, forCellReuseIdentifier: "DayAnalysisDispatchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
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
        label.text = "배차가 없습니다"
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dispatchModel = DispatchModel()
    
    var date: String = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd")
    var regularlyList: [DispatchRegularlyItem] = []
    var orderList: [DispatchOrderItem] = []
    
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
        print("----------------------------------- DayAnalysisViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DayAnalysisViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(selectTime(_:)), name: Notification.Name("SelectDate"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.drivingInfoTitleLabel,
            self.drivingInfoSeparateView,
            
            self.entireMovingDistanceTitleLabel,
            self.entireMovingDistanceBaseView,
            self.entireMovingDistanceLabel,
            self.entireMovingDistanceUnitLabel,
            
            self.entireFuelTitleLabel,
            self.entireFuelBaseView,
            self.entireFuelLabel,
            self.entireFuelUnitLabel,
            
            self.entireTimeTitleLabel,
            self.entireTimeBaseView,
            self.entireTimeLabel,
            self.entireTimeUnitLabel,
            
            self.dispatchListTitleLabel,
            self.dispatchListSeparateView,
            
            self.tableView,
            self.noDataStackView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // drivingInfoTitleLabel
        NSLayoutConstraint.activate([
            self.drivingInfoTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.drivingInfoTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16)
        ])
        
        // drivingInfoSeparateView
        NSLayoutConstraint.activate([
            self.drivingInfoSeparateView.leadingAnchor.constraint(equalTo: self.drivingInfoTitleLabel.trailingAnchor, constant: 4),
            self.drivingInfoSeparateView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.drivingInfoSeparateView.centerYAnchor.constraint(equalTo: self.drivingInfoTitleLabel.centerYAnchor),
            self.drivingInfoSeparateView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // entireMovingDistanceTitleLabel
        NSLayoutConstraint.activate([
            self.entireMovingDistanceTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.entireMovingDistanceTitleLabel.topAnchor.constraint(equalTo: self.drivingInfoTitleLabel.bottomAnchor, constant: 10)
        ])
        
        // entireMovingDistanceBaseView
        NSLayoutConstraint.activate([
            self.entireMovingDistanceBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.entireMovingDistanceBaseView.topAnchor.constraint(equalTo: self.entireMovingDistanceTitleLabel.bottomAnchor, constant: 8),
            self.entireMovingDistanceBaseView.heightAnchor.constraint(equalToConstant: 30),
            self.entireMovingDistanceBaseView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        // entireMovingDistanceLabel
        NSLayoutConstraint.activate([
            self.entireMovingDistanceLabel.trailingAnchor.constraint(equalTo: self.entireMovingDistanceBaseView.trailingAnchor, constant: -4),
            self.entireMovingDistanceLabel.centerYAnchor.constraint(equalTo: self.entireMovingDistanceBaseView.centerYAnchor)
        ])
        
        // entireMovingDistanceUnitLabel
        NSLayoutConstraint.activate([
            self.entireMovingDistanceUnitLabel.leadingAnchor.constraint(equalTo: self.entireMovingDistanceBaseView.trailingAnchor, constant: 4),
            self.entireMovingDistanceUnitLabel.centerYAnchor.constraint(equalTo: self.entireMovingDistanceBaseView.centerYAnchor)
        ])
        
        // entireFuelTitleLabel
        NSLayoutConstraint.activate([
            self.entireFuelTitleLabel.leadingAnchor.constraint(equalTo: self.entireFuelBaseView.leadingAnchor),
            self.entireFuelTitleLabel.topAnchor.constraint(equalTo: self.drivingInfoTitleLabel.bottomAnchor, constant: 10)
        ])
        
        // entireFuelBaseView
        NSLayoutConstraint.activate([
            self.entireFuelBaseView.trailingAnchor.constraint(equalTo: self.entireFuelUnitLabel.leadingAnchor, constant: -4),
            self.entireFuelBaseView.topAnchor.constraint(equalTo: self.entireFuelTitleLabel.bottomAnchor, constant: 8),
            self.entireFuelBaseView.heightAnchor.constraint(equalToConstant: 30),
            self.entireFuelBaseView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        // entireFuelLabel
        NSLayoutConstraint.activate([
            self.entireFuelLabel.trailingAnchor.constraint(equalTo: self.entireFuelBaseView.trailingAnchor, constant: -4),
            self.entireFuelLabel.centerYAnchor.constraint(equalTo: self.entireFuelBaseView.centerYAnchor)
        ])
        
        // entireFuelUnitLabel
        NSLayoutConstraint.activate([
            self.entireFuelUnitLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.entireFuelUnitLabel.centerYAnchor.constraint(equalTo: self.entireFuelBaseView.centerYAnchor)
        ])
        
        // entireTimeTitleLabel
        NSLayoutConstraint.activate([
            self.entireTimeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.entireTimeTitleLabel.topAnchor.constraint(equalTo: self.entireMovingDistanceBaseView.bottomAnchor, constant: 10)
        ])
        
        // entireTimeBaseView
        NSLayoutConstraint.activate([
            self.entireTimeBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.entireTimeBaseView.topAnchor.constraint(equalTo: self.entireTimeTitleLabel.bottomAnchor, constant: 8),
            self.entireTimeBaseView.heightAnchor.constraint(equalToConstant: 30),
            self.entireTimeBaseView.widthAnchor.constraint(equalToConstant: 140)
        ])
        
        // entireTimeLabel
        NSLayoutConstraint.activate([
            self.entireTimeLabel.trailingAnchor.constraint(equalTo: self.entireTimeBaseView.trailingAnchor, constant: -4),
            self.entireTimeLabel.centerYAnchor.constraint(equalTo: self.entireTimeBaseView.centerYAnchor)
        ])
        
        // entireTimeUnitLabel
        NSLayoutConstraint.activate([
            self.entireTimeUnitLabel.leadingAnchor.constraint(equalTo: self.entireTimeBaseView.trailingAnchor, constant: 4),
            self.entireTimeUnitLabel.centerYAnchor.constraint(equalTo: self.entireTimeBaseView.centerYAnchor)
        ])
        
        // dispatchListTitleLabel
        NSLayoutConstraint.activate([
            self.dispatchListTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.dispatchListTitleLabel.topAnchor.constraint(equalTo: self.entireTimeBaseView.bottomAnchor, constant: 20),
        ])
        
        // dispatchListSeparateView
        NSLayoutConstraint.activate([
            self.dispatchListSeparateView.leadingAnchor.constraint(equalTo: self.dispatchListTitleLabel.trailingAnchor, constant: 4),
            self.dispatchListSeparateView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.dispatchListSeparateView.centerYAnchor.constraint(equalTo: self.dispatchListTitleLabel.centerYAnchor),
            self.dispatchListSeparateView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.dispatchListTitleLabel.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        // noDataStackView
        NSLayoutConstraint.activate([
            self.noDataStackView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor),
            self.noDataStackView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor)
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
        
        self.navigationItem.title = "\(self.date) 일일 운행 분석"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .useRGB(red: 176, green: 0, blue: 32)
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest(date: self.date) { item in
            self.regularlyList = item.regularly
            self.orderList = item.order
            
            if item.regularly.isEmpty && item.order.isEmpty {
                self.noDataStackView.isHidden = false
                
            } else {
                self.noDataStackView.isHidden = true
                
            }
            
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            print("setData loadDailyDispatchRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
}

// MARK: - Extension for methods added
extension DayAnalysisViewController {
    func loadDailyDispatchRequest(date: String, success: ((DispatchDailyItem) -> ())?, failure: ((String) -> ())?) {
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
}

// MARK: - Extension for selector methods
extension DayAnalysisViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    } 
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = SelectDateBottomSheetViewController(date: self.date)
        
        self.present(vc, animated: false)
    }
    
    @objc func selectTime(_ noti: Notification) {
        guard let date = noti.userInfo?["date"] as? Date else { return }
        let dateString = SupportingMethods.shared.convertDate(intoString: date, "yyyy-MM-dd")
        self.date = dateString
        self.navigationItem.title = "\(self.date) 일일 운행 분석"
        
        self.setData()
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DayAnalysisViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            self.regularlyList.count
            
        } else {
            self.orderList.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayAnalysisDispatchTableViewCell", for: indexPath) as! DayAnalysisDispatchTableViewCell
            let item = self.regularlyList[indexPath.row]
            
            cell.setCell(item: item)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayAnalysisDispatchTableViewCell", for: indexPath) as! DayAnalysisDispatchTableViewCell
            let item = self.orderList[indexPath.row]
            
            cell.setCell(item: item)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let item = self.regularlyList[indexPath.row]
            
            let vc = DispatchNoteDetailViewController(type: .regularly, id: (regularly: "\(item.id)", order: ""), date: (departure: item.departureDate, arrival: item.arrivalDate))
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let item = self.orderList[indexPath.row]
            
            let vc = DispatchNoteDetailViewController(type: .order, id: (regularly: "\(item.id)", order: ""), date: (departure: item.departureDate, arrival: item.arrivalDate))
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
