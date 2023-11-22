//
//  RenewalDispatchViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/22/23.
//

import UIKit

final class RenewalDispatchViewController: UIViewController {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(tappedSearchButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var taskView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.text = "남은 업무 2/10"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchRegularlyTableViewCell.self, forCellReuseIdentifier: "DispatchRegularlyTableViewCell")
        tableView.register(DispatchOrderTableViewCell.self, forCellReuseIdentifier: "DispatchOrderTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
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
        
    }
    
    func setLayouts() {
        //let safeArea = self.view.safeAreaLayoutGuide
        
        //
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension RenewalDispatchViewController {
    
}

// MARK: - Extension for selector methods
extension RenewalDispatchViewController {
    @objc func tappedSearchButton(_ sender: UIButton) {
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension RenewalDispatchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchRegularlyTableViewCell", for: indexPath) as! DispatchRegularlyTableViewCell
            
            cell.setCell()
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchOrderTableViewCell", for: indexPath) as! DispatchOrderTableViewCell
            
            cell.setCell()
            
            return cell
            
        default:
            break
            
        }
        return UITableViewCell()
    }
}
