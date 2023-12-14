//
//  DispatchHomeCheckViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/26.
//

import UIKit

final class DispatchHomeCheckViewController: UIViewController {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        label.text = "배차 수락이 완료되었습니다."
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
        tableView.register(DispatchCheckTableViewCell.self, forCellReuseIdentifier: "DispatchCheckTableViewCell")
//        tableView.register(DispatchCheckOrderTableViewCell.self, forCellReuseIdentifier: "DispatchCheckOrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.useRGB(red: 66, green: 66, blue: 66), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.addTarget(self, action: #selector(tappedCompleteButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var date: String?
    let dispatchModel = DispatchModel()
    var regularlyItem: [DispatchRegularlyItem] = []
    var orderItem: [DispatchOrderItem] = []
    
    init(date: String?) {
        self.date = date
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
        self.setData()
    }
    
    deinit {
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchHomeCheckViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.4)
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
        // view
        self.view.addSubview(self.backgroundView)
        
        // backgroundView
        SupportingMethods.shared.addSubviews([
            self.noDataStackView,
            self.tableView,
            self.completeButton
        ], to: self.backgroundView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // backgroundView
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.backgroundView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.backgroundView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.backgroundView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
        ])
        
        // noDataStackView
        NSLayoutConstraint.activate([
            self.noDataStackView.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor),
            self.noDataStackView.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.completeButton.bottomAnchor)
        ])
        
        // completeButton
        NSLayoutConstraint.activate([
            self.completeButton.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -16),
            self.completeButton.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 10)
        ])
    }
    
    func setViewAfterTransition() {
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest { item in
            self.orderItem = item.order
            self.regularlyItem = item.regularly
            
            if !item.regularly.isEmpty {
                self.noDataStackView.isHidden = true
            } else {
                self.noDataStackView.isHidden = false
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
                SupportingMethods.shared.showAlertNoti(title: "다음날 배차 수락이 완료되지 않았습니다. 배차 수락 화면으로 이동합니다.")
            }
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("setData loadDailyDispatchRequest API Error: \(errorMessage)")
        }

    }
}

// MARK: - Extension for methods added
extension DispatchHomeCheckViewController {
    func loadDailyDispatchRequest(success: ((DispatchDailyItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDailyDispatchRequest(date: self.date!) { dailyInfo in
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
    
    func checkDispatchRequest(check: String, regularlyId: String, orderId: String, success: (() -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.checkDispatchRequest(check: check, regularlyId: regularlyId, orderId: orderId) {
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension DispatchHomeCheckViewController {
    @objc func tappedCompleteButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest { items in
            var isDispatchCheck: Bool = true
            
            for item in items.regularly {
                if item.checkRegularlyConnect.connectCheck == "" {
                    isDispatchCheck = false
                    break
                }
            }
            
            if !isDispatchCheck {
                for item in items.order {
                    if item.checkOrderConnect.connectCheck == "" {
                        isDispatchCheck = false
                        break
                    }
                }
            }
            
            if isDispatchCheck {
                SupportingMethods.shared.showAlertNoti(title: "배차 수락이 완료되었습니다.\n홈화면으로 이동합니다.")
                
                self.dismiss(animated: true)
            } else {
                SupportingMethods.shared.showAlertNoti(title: "배차 수락이 완료되지 않았습니다.\n배차 확인을 눌러주세요.")
            }
            
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadDailyDispatchRequest API Errpr \(errorMessage)")
            
        }
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchHomeCheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.regularlyItem.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchCheckTableViewCell", for: indexPath) as! DispatchCheckTableViewCell
        
        cell.setCell(info: self.regularlyItem[indexPath.row])
        cell.delegate = self
        
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - Extension for DispatchDailyDelegate
extension DispatchHomeCheckViewController: DispatchDailyDelegate {
    func tapDetailMapButton(mapLink: String) {
        guard let url = URL(string: mapLink) else { return }
        UIApplication.shared.open(url)
    }
    
    func tapCheckButton(info: DispatchRegularlyItem) {
        let vc = DispatchCheckPopViewController(regularlyItem: info)
        
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true)
    }
    
    func tapDenyButton(info: DispatchRegularlyItem) {
        SupportingMethods.shared.turnCoverView(.on)
        self.checkDispatchRequest(check: "0", regularlyId: "\(info.id)", orderId: "") {
            self.setData()
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("tapDenyButton checkDispatchRequest API Error: \(errorMessage)")
            
        }

    }
}
