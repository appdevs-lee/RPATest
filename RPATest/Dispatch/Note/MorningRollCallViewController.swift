//
//  MorningRollCallViewController.swift
//  RPATest
//
//  Created by Awesomepia on 12/7/23.
//

import UIKit

final class MorningRollCallViewController: UIViewController {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.date)"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rollCallArrivalTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "점호지 도착시간"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rollCallTimeTextField: UITextField = {
        let textField = UITextField()
        textField.isUserInteractionEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: "시간을 입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var rollCallTimeSelectButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedRollCallTimeSelectButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var busLabel: UILabel = {
        let label = UILabel()
        label.text = "배정 차량: "
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var alcoholTestTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "음주측정"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var alcoholTestTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "수치를 입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MorningRollCallTableViewCell.self, forCellReuseIdentifier: "MorningRollCallTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 22, weight: .Bold)
        button.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(tappedCompleteButton(_:)), for: .touchUpInside)
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
    
    let statusList: [String] = ["건강상태", "청소상태", "노선숙지"]
    var resultList: [String] = ["양호", "양호", "양호"]
    var date: String
    
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
        print("----------------------------------- MorningRollCallViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MorningRollCallViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(reload(_:)), name: Notification.Name("MorningRollCallStatus"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.dateLabel,
            self.busLabel,
            self.rollCallArrivalTimeTitleLabel,
            self.rollCallTimeTextField,
            self.rollCallTimeSelectButton,
            self.alcoholTestTitleLabel,
            self.alcoholTestTextField,
            self.tableView,
            self.completeButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            self.dateLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        // busLabel
        NSLayoutConstraint.activate([
            self.busLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.busLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 20)
        ])
        
        // rollCallArrivalTimeTitleLabel
        NSLayoutConstraint.activate([
            self.rollCallArrivalTimeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.rollCallArrivalTimeTitleLabel.topAnchor.constraint(equalTo: self.busLabel.bottomAnchor, constant: 20)
        ])
        
        // rollCallTimeTextField
        NSLayoutConstraint.activate([
            self.rollCallTimeTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.rollCallTimeTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.rollCallTimeTextField.topAnchor.constraint(equalTo: self.rollCallArrivalTimeTitleLabel.bottomAnchor, constant: 8),
            self.rollCallTimeTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // rollCallTimeSelectButton
        NSLayoutConstraint.activate([
            self.rollCallTimeSelectButton.leadingAnchor.constraint(equalTo: self.rollCallTimeTextField.leadingAnchor),
            self.rollCallTimeSelectButton.trailingAnchor.constraint(equalTo: self.rollCallTimeTextField.trailingAnchor),
            self.rollCallTimeSelectButton.topAnchor.constraint(equalTo: self.rollCallTimeTextField.topAnchor),
            self.rollCallTimeSelectButton.bottomAnchor.constraint(equalTo: self.rollCallTimeTextField.bottomAnchor)
        ])
        
        // alcoholTestTitleLabel
        NSLayoutConstraint.activate([
            self.alcoholTestTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.alcoholTestTitleLabel.topAnchor.constraint(equalTo: self.rollCallTimeTextField.bottomAnchor, constant: 20)
        ])
        
        // alcoholTestTextField
        NSLayoutConstraint.activate([
            self.alcoholTestTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.alcoholTestTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.alcoholTestTextField.topAnchor.constraint(equalTo: self.alcoholTestTitleLabel.bottomAnchor, constant: 8),
            self.alcoholTestTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.alcoholTestTextField.bottomAnchor, constant: 20),
            self.tableView.bottomAnchor.constraint(equalTo: self.completeButton.topAnchor, constant: -4)
        ])
        
        // completeButton
        NSLayoutConstraint.activate([
            self.completeButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.completeButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.completeButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.completeButton.heightAnchor.constraint(equalToConstant: 44)
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
        
        self.navigationItem.title = "아침점호"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension MorningRollCallViewController {
    
}

// MARK: - Extension for selector methods
extension MorningRollCallViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedRollCallTimeSelectButton(_ sender: UIButton) {
        
    }
    
    @objc func tappedCompleteButton(_ sender: UIButton) {
        
    }
    
    @objc func reload(_ notification: Notification) {
        guard let status = notification.userInfo?["selectedCellInfo"] as? (index: Int, status: RollCallStatus) else { return }
        
        self.resultList[status.index] = status.status.status
        
    }
}

// MARK: - Extension for UITextFieldDelegate
extension MorningRollCallViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.rollCallTimeTextField.text != "" && self.alcoholTestTextField.text != "" {
            self.completeButton.isEnabled = true
            self.completeButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            
        } else {
            self.completeButton.isEnabled = false
            self.completeButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
        }
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension MorningRollCallViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MorningRollCallTableViewCell", for: indexPath) as! MorningRollCallTableViewCell
        let status = self.statusList[indexPath.row]
        
        cell.setCell(title: status, index: indexPath.row)
        
        return cell
    }
}
