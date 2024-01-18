//
//  AccidentResponseViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/17/24.
//

import UIKit

final class AccidentResponseViewController: UIViewController {
    
    lazy var titleBaseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KingbusLogo")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사고발생 시 대응요령"
        label.textColor = .white
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AccidentResponseTableViewCell.self, forCellReuseIdentifier: "AccidentResponseTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var startAccidentResponseFlowButton: UIButton = {
        let button = UIButton()
        button.setTitle("사고발생", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(tappedStartButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var titleList: [String] = [
    "1. 승객 안전 유무 확인",
    "2. 승객 명단 작성",
    "3. 관리자에게 보고",
    "4. 사진 촬영 (5종류)\n내차량만, 상대차량만, 내차량/상대방차량 동시에, 가까운 사진(접촉 부위), 먼 사진",
    "5. 경위서 작성",
    "6. 이후 관리자 지시에 따라 경미한 사고는 정상 운행 하시면 됩니다."
    ]
    
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
        print("----------------------------------- AccidentResponseViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension AccidentResponseViewController: EssentialViewMethods {
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
            self.titleBaseView,
            self.titleImageView,
            self.titleLabel,
            self.tableView,
            self.startAccidentResponseFlowButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleBaseView
        NSLayoutConstraint.activate([
            self.titleBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.titleBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.titleBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            self.titleBaseView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // titleImageView
        NSLayoutConstraint.activate([
            self.titleImageView.leadingAnchor.constraint(equalTo: self.titleBaseView.leadingAnchor, constant: 8),
            self.titleImageView.centerYAnchor.constraint(equalTo: self.titleBaseView.centerYAnchor),
            self.titleImageView.heightAnchor.constraint(equalToConstant: 30),
            self.titleImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.titleImageView.trailingAnchor, constant: 8),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.titleImageView.centerYAnchor)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.titleBaseView.bottomAnchor, constant: 10),
            self.tableView.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        // startAccidentResponseFlowButton
        NSLayoutConstraint.activate([
            self.startAccidentResponseFlowButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.startAccidentResponseFlowButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.startAccidentResponseFlowButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -34),
            self.startAccidentResponseFlowButton.heightAnchor.constraint(equalToConstant: 44)
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
    
    private func setUpNavigationItem() {
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
extension AccidentResponseViewController {
    
}

// MARK: - Extension for selector methods
extension AccidentResponseViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedStartButton(_ sender: UIButton) {
        let vc = AccidentSafeCheckViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AccidentResponseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccidentResponseTableViewCell", for: indexPath) as! AccidentResponseTableViewCell
        let text = self.titleList[indexPath.row]
        
        cell.setCell(text: text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            // 승객 안전 확인
            let vc = AccidentSafeCheckViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            // 승객 명단 작성
            let vc = AccidentNameListViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            // 관리자에게 보고
            let vc = AccidentCallListViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            // 차량 사진
            let vc = AccidentPhotoViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            // 경위서 작성
            let vc = AccidentReasonViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
