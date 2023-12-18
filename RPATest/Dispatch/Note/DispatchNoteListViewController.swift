//
//  DispatchNoteListViewController.swift
//  RPATest
//
//  Created by Awesomepia on 12/6/23.
//

import UIKit

enum DispatchKindType {
    case regularly
    case order
}

final class DispatchNoteListViewController: UIViewController {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "\(self.date)\n운행일지"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var morningAndEveningStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.morningView, self.eveningView])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var morningView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 189, green: 189, blue: 189).cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var morningStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.morningImageView, self.morningLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var morningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Morning")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var morningLabel: UILabel = {
        let label = UILabel()
        label.text = "아침 점호"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var morningButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedMorningButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var eveningView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 189, green: 189, blue: 189).cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var eveningStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.eveningImageView, self.eveningLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var eveningImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Evening")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var eveningLabel: UILabel = {
        let label = UILabel()
        label.text = "저녁 점호"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var eveningButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedEveningButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchNoteRegularlyTableViewCell.self, forCellReuseIdentifier: "DispatchNoteRegularlyTableViewCell")
        tableView.register(DispatchNoteOrderTableViewCell.self, forCellReuseIdentifier: "DispatchNoteOrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var dispatchNoteButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.layer.cornerRadius = 22
        button.setTitle("운행일보 작성하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tappedDispatchNoteButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    init(date: String) {
        self.date = date
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dispatchModel = DispatchModel()
    var date: String
    var regularlyList: [DispatchRegularlyItem] = []
    var orderList: [DispatchOrderItem] = []
    var selectedIndex: (section: Int, row: Int)?
    var type: DispatchKindType = .regularly
    
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
        print("----------------------------------- DispatchNoteListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchNoteListViewController: EssentialViewMethods {
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
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.dateLabel,
            self.morningAndEveningStackView,
            self.morningStackView,
            self.morningButton,
            self.eveningStackView,
            self.eveningButton,
            self.tableView,
            self.dispatchNoteButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.dateLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
        ])
        
        // morningAndEveningStackView
        NSLayoutConstraint.activate([
            self.morningAndEveningStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.morningAndEveningStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.morningAndEveningStackView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10),
        ])
        
        // morningView
        NSLayoutConstraint.activate([
            self.morningView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // morningStackView
        NSLayoutConstraint.activate([
            self.morningStackView.centerYAnchor.constraint(equalTo: self.morningView.centerYAnchor),
            self.morningStackView.centerXAnchor.constraint(equalTo: self.morningView.centerXAnchor),
        ])
        
        // monringImageView
        NSLayoutConstraint.activate([
            self.morningImageView.widthAnchor.constraint(equalToConstant: 20),
            self.morningImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // morningButton
        NSLayoutConstraint.activate([
            self.morningButton.leadingAnchor.constraint(equalTo: self.morningView.leadingAnchor),
            self.morningButton.trailingAnchor.constraint(equalTo: self.morningView.trailingAnchor),
            self.morningButton.bottomAnchor.constraint(equalTo: self.morningView.bottomAnchor),
            self.morningButton.topAnchor.constraint(equalTo: self.morningView.topAnchor)
        ])
        
        // eveningView
        NSLayoutConstraint.activate([
            self.eveningView.widthAnchor.constraint(equalTo: self.morningView.widthAnchor, multiplier: 1.0),
            self.eveningView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // eveningStackView
        NSLayoutConstraint.activate([
            self.eveningStackView.centerYAnchor.constraint(equalTo: self.eveningView.centerYAnchor),
            self.eveningStackView.centerXAnchor.constraint(equalTo: self.eveningView.centerXAnchor),
        ])
        
        // eveningImageView
        NSLayoutConstraint.activate([
            self.eveningImageView.widthAnchor.constraint(equalToConstant: 20),
            self.eveningImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // eveningButton
        NSLayoutConstraint.activate([
            self.eveningButton.leadingAnchor.constraint(equalTo: self.eveningView.leadingAnchor),
            self.eveningButton.trailingAnchor.constraint(equalTo: self.eveningView.trailingAnchor),
            self.eveningButton.bottomAnchor.constraint(equalTo: self.eveningView.bottomAnchor),
            self.eveningButton.topAnchor.constraint(equalTo: self.eveningView.topAnchor)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.morningAndEveningStackView.bottomAnchor, constant: 10)
        ])
        
        // dispatchNoteButton
        NSLayoutConstraint.activate([
            self.dispatchNoteButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.dispatchNoteButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.dispatchNoteButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.dispatchNoteButton.heightAnchor.constraint(equalToConstant: 44)
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
        
        self.navigationItem.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest(date: self.date) { item in
            self.regularlyList = item.regularly
            self.orderList = item.order
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        } failure: { errorMessage in
            print("setData loadDailyDispatchRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
}

// MARK: - Extension for methods added
extension DispatchNoteListViewController {
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
extension DispatchNoteListViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedMorningButton(_ sender: UIButton) {
        let vc = MorningRollCallViewController(date: self.date)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappedEveningButton(_ sender: UIButton) {
        let vc = EveningRollCallViewController(date: self.date)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tappedDispatchNoteButton(_ sender: UIButton) {
        guard let selectedIndex = self.selectedIndex else { return }
        var regularlyItem: DispatchRegularlyItem?
        var orderItem: DispatchOrderItem?
        
        switch selectedIndex.section {
        case 0:
            self.type = .regularly
            regularlyItem = self.regularlyList[selectedIndex.row]
            
            let vc = DispatchNoteDetailViewController(type: .regularly, id: (regularly: "\(regularlyItem?.id ?? 0)", order: ""))
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            self.type = .order
            orderItem = self.orderList[selectedIndex.row]
            
            let vc = DispatchNoteDetailViewController(type: .order, id: (regularly: "", order: "\(orderItem?.id ?? 0)"))
            
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchNoteListViewController: UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchNoteRegularlyTableViewCell", for: indexPath) as! DispatchNoteRegularlyTableViewCell
            let item = self.regularlyList[indexPath.row]
            
            cell.setCell(item: item)
            
            if self.selectedIndex?.section == 0 && self.selectedIndex?.row == indexPath.row {
                cell.checkImageView.image = UIImage(named: "Check_Yes")
                
            } else {
                cell.checkImageView.image = UIImage(named: "Check_No")
                
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchNoteOrderTableViewCell", for: indexPath) as! DispatchNoteOrderTableViewCell
            let item = self.orderList[indexPath.row]
            
            cell.setCell(item: item)
            
            if self.selectedIndex?.section == 1 && self.selectedIndex?.row == indexPath.row {
                cell.checkImageView.image = UIImage(named: "Check_Yes")
                
            } else {
                cell.checkImageView.image = UIImage(named: "Check_No")
                
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndex == nil {
            self.selectedIndex = (section: indexPath.section, row: indexPath.row)
            
            self.dispatchNoteButton.isHidden = false
        } else {
            if self.selectedIndex! == (section: indexPath.section, row: indexPath.row) {
                self.selectedIndex = nil
                
                self.dispatchNoteButton.isHidden = true
            } else {
                self.selectedIndex = (section: indexPath.section, row: indexPath.row)
                
                self.dispatchNoteButton.isHidden = false
            }
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
}
