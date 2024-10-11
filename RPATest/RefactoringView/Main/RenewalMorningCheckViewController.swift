//
//  RenewalMorningCheckViewController.swift
//  RPATest
//
//  Created by Awesomepia on 10/10/24.
//

import UIKit

class Question {
    let question: String
    let goodButton: String
    let notGoodButton: String
    var selectedIndex: Int = 0
    
    init(question: String, goodButton: String, notGoodButton: String) {
        self.question = question
        self.goodButton = goodButton
        self.notGoodButton = notGoodButton
    }
}

final class RenewalMorningCheckViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아침 점호 및 일일 점검을 진행해 주세요"
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 20, weight: .SemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "차량의 상태 파악 및 기사님의 안전을 위해\n꼭 운행 전 점검하여 주세요."
        label.textColor = .useRGB(red: 168, green: 168, blue: 168)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var morningCheckTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "점호지 도착시간: "
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 14, weight: .SemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var morningCheckTimeLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(), "a hh:mm")
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var alcoholTestTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "음주 측정 결과를 입력해주세요."
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .SemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var alcoholTestTextField: UITextField = {
        let textField = UITextField()
        textField.setPlaceholder(placeholder: "수치를 입력해주세요.")
        textField.setBorder()
        textField.keyboardType = .decimalPad
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
        tableView.register(MorningCheckTableViewCell.self, forCellReuseIdentifier: "MorningCheckTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var vehicleListBackgroundView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var vehicleListView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var vehicleTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ChangeVehicleListTableViewCell.self, forCellReuseIdentifier: "ChangeVehicleListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var vehicleNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 16, weight: .SemiBold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var changeVehicleButton: UIButton = {
        let button = UIButton()
        button.setTitle("차량 변경", for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Regular)
        button.addTarget(self, action: #selector(changeVehicleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("제출하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let vehicleModel = VehicleModel()
    
    let questionList: [Question] = [
        Question(question: "건강 상태는 어떠신가요?", goodButton: "좋아요", notGoodButton: "안 좋아요"),
        Question(question: "청소 상태는 어떤가요?", goodButton: "깨긋해요", notGoodButton: "더러워요"),
        Question(question: "노선 숙지는 되어 있나요?", goodButton: "네", notGoodButton: "아니요"),
        Question(question: "엔진오일 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "파워오일, 클러치 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "냉각수, 부동액 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "외부차체상태(파손 여부) 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "등화장치(실내/외) 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "블랙박스(작동 여부) 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "타이어 상태(나사, 못 등) 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "실내(복도, 선반, 청소 등) 상태 확인", goodButton: "양호", notGoodButton: "이상"),
        Question(question: "제복 착용", goodButton: "착용", notGoodButton: "미착용"),
        Question(question: "안전벨트/슬라이드 확인", goodButton: "양호", notGoodButton: "이상"),
    ]
    
    var vehicleList: [VehicleItem] = []
    var selectedVehicle: VehicleItem?
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- RenewalMorningCheckViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalMorningCheckViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let bgGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBackgroundView(_:)))
        self.vehicleListBackgroundView.addGestureRecognizer(bgGesture)
        self.vehicleListBackgroundView.isUserInteractionEnabled = true
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.subTitleLabel,
            
            self.morningCheckTimeTitleLabel,
            self.morningCheckTimeLabel,
            
            self.alcoholTestTitleLabel,
            self.alcoholTestTextField,
            
            self.tableView,
            self.buttonView,
            self.vehicleListBackgroundView,
            self.vehicleListView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.indicatorView,
            self.vehicleNumberLabel,
            self.changeVehicleButton,
            self.doneButton,
        ], to: self.buttonView)
        
        SupportingMethods.shared.addSubviews([
            self.vehicleTableView,
        ], to: self.vehicleListView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
        ])
        
        // morningCheckTimeTitleLabel
        NSLayoutConstraint.activate([
            self.morningCheckTimeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.morningCheckTimeTitleLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 40),
        ])
        
        // morningCheckTimeLabel
        NSLayoutConstraint.activate([
            self.morningCheckTimeLabel.leadingAnchor.constraint(equalTo: self.morningCheckTimeTitleLabel.trailingAnchor, constant: 5),
            self.morningCheckTimeLabel.centerYAnchor.constraint(equalTo: self.morningCheckTimeTitleLabel.centerYAnchor),
        ])
        
        // alcoholTestTitleLabel
        NSLayoutConstraint.activate([
            self.alcoholTestTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.alcoholTestTitleLabel.topAnchor.constraint(equalTo: self.morningCheckTimeTitleLabel.bottomAnchor, constant: 16),
        ])
        
        // alcoholTestTextField
        NSLayoutConstraint.activate([
            self.alcoholTestTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.alcoholTestTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.alcoholTestTextField.topAnchor.constraint(equalTo: self.alcoholTestTitleLabel.bottomAnchor, constant: 10),
            self.alcoholTestTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.alcoholTestTextField.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.buttonView.topAnchor),
        ])
        
        // vehicleListBackgroundView
        NSLayoutConstraint.activate([
            self.vehicleListBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.vehicleListBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.vehicleListBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.vehicleListBackgroundView.bottomAnchor.constraint(equalTo: self.buttonView.topAnchor),
        ])
        
        // vehicleListView
        NSLayoutConstraint.activate([
            self.vehicleListView.leadingAnchor.constraint(equalTo: self.vehicleListBackgroundView.leadingAnchor, constant: 10),
            self.vehicleListView.bottomAnchor.constraint(equalTo: self.vehicleListBackgroundView.bottomAnchor, constant: -10),
            self.vehicleListView.widthAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width / 2),
            self.vehicleListView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width / 2 * 1.3),
        ])
        
        // vehicleTableView
        NSLayoutConstraint.activate([
            self.vehicleTableView.leadingAnchor.constraint(equalTo: self.vehicleListView.leadingAnchor),
            self.vehicleTableView.trailingAnchor.constraint(equalTo: self.vehicleListView.trailingAnchor),
            self.vehicleTableView.topAnchor.constraint(equalTo: self.vehicleListView.topAnchor),
            self.vehicleTableView.bottomAnchor.constraint(equalTo: self.vehicleListView.bottomAnchor),
        ])
        
        // buttonView
        NSLayoutConstraint.activate([
            self.buttonView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.buttonView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.buttonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // indicatorView
        NSLayoutConstraint.activate([
            self.indicatorView.centerXAnchor.constraint(equalTo: self.buttonView.centerXAnchor),
            self.indicatorView.topAnchor.constraint(equalTo: self.buttonView.topAnchor, constant: 10),
            self.indicatorView.widthAnchor.constraint(equalToConstant: 64),
            self.indicatorView.heightAnchor.constraint(equalToConstant: 4),
        ])
        
        // vehicleNumberLabel
        NSLayoutConstraint.activate([
            self.vehicleNumberLabel.leadingAnchor.constraint(equalTo: self.buttonView.leadingAnchor, constant: 16),
            self.vehicleNumberLabel.topAnchor.constraint(equalTo: self.indicatorView.bottomAnchor, constant: 20),
        ])
        
        // changeVehicleButton
        NSLayoutConstraint.activate([
            self.changeVehicleButton.trailingAnchor.constraint(equalTo: self.buttonView.trailingAnchor, constant: -16),
            self.changeVehicleButton.centerYAnchor.constraint(equalTo: self.vehicleNumberLabel.centerYAnchor),
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.buttonView.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: self.buttonView.trailingAnchor, constant: -16),
            self.doneButton.bottomAnchor.constraint(equalTo: self.buttonView.bottomAnchor, constant: -25),
            self.doneButton.topAnchor.constraint(equalTo: self.vehicleNumberLabel.bottomAnchor, constant: 20),
            self.doneButton.heightAnchor.constraint(equalToConstant: 48),
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
        
        self.navigationItem.title = "아침점호 & 일일점검"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadVehicleListDataRequest { vehicle in
            self.vehicleNumberLabel.text = "\(vehicle.driverVehicleList.first!.vehicleSubNum) \(vehicle.driverVehicleList.first!.vehicleMainNum)"
            self.selectedVehicle = vehicle.driverVehicleList.first
            
            self.vehicleList = vehicle.vehicleList
            
            DispatchQueue.main.async {
                self.vehicleTableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
    }
}

// MARK: - Extension for methods added
extension RenewalMorningCheckViewController {
    func loadVehicleListDataRequest(success: ((Vehicle) -> ())?) {
        self.vehicleModel.loadVehicleListDataRequest { vehicle in
            success?(vehicle)
            
        } failure: { message in
            print("loadVehicleListDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

        
    }
    
    func sendDailyCheckDataRequest(success: (() -> ())?) {
        self.vehicleModel.sendDailyCheckDataRequest(busId: self.selectedVehicle!.id, engineOil: CheckResult(rawValue: self.questionList[3].selectedIndex)!, powerClutch: CheckResult(rawValue: self.questionList[4].selectedIndex)!, washer: CheckResult(rawValue: self.questionList[5].selectedIndex)!, externalBody: CheckResult(rawValue: self.questionList[6].selectedIndex)!, lightingDevice: CheckResult(rawValue: self.questionList[7].selectedIndex)!, blackbox: CheckResult(rawValue: self.questionList[8].selectedIndex)!, tire: CheckResult(rawValue: self.questionList[9].selectedIndex)!, interior: CheckResult(rawValue: self.questionList[10].selectedIndex)!, safetyBelt: CheckResult(rawValue: self.questionList[12].selectedIndex)!, uniform: CheckResult(rawValue: self.questionList[11].selectedIndex)!) {
            success?()
            
        } failure: { message in
            print("sendDailyCheckDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
    func sendMorningCheckDataRequest(success: (() -> ())?) {
        self.vehicleModel.sendMorningCheckDataRequest(time: String(self.morningCheckTimeLabel.text!.split(separator: " ")[1]), health: CheckResult(rawValue: self.questionList[0].selectedIndex)!, clean: CheckResult(rawValue: self.questionList[1].selectedIndex)!, route: CheckResult(rawValue: self.questionList[2].selectedIndex)!, alcoholValue: Double(self.alcoholTestTextField.text!)!) {
            success?()
            
        } failure: { message in
            print("sendMorningCheckDataRequest API Error: \(message)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension RenewalMorningCheckViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func changeVehicleButton(_ sender: UIButton) {
        self.vehicleListBackgroundView.isHidden = false
        self.vehicleListView.isHidden = false
        
        
    }
    
    @objc func tappedBackgroundView(_ gesture: UITapGestureRecognizer) {
        self.vehicleListBackgroundView.isHidden = true
        self.vehicleListView.isHidden = true
        
    }
    
    @objc func doneButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.sendMorningCheckDataRequest {
            self.sendDailyCheckDataRequest {
                SupportingMethods.shared.turnCoverView(.off)
                SupportingMethods.shared.showAlertNoti(title: "완료 되었습니다.")
                self.navigationController?.popViewController(animated: true)
                
            }
            
        }
        
    }
    
}

extension RenewalMorningCheckViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "" {
            self.doneButton.isEnabled = false
            self.doneButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
        } else {
            self.doneButton.isEnabled = true
            self.doneButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            
        }
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension RenewalMorningCheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return self.questionList.count
            
        } else {
            return self.vehicleList.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MorningCheckTableViewCell", for: indexPath) as! MorningCheckTableViewCell
            let question = self.questionList[indexPath.row]
            
            cell.setCell(question: question)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeVehicleListTableViewCell", for: indexPath) as! ChangeVehicleListTableViewCell
            let vehicle = self.vehicleList[indexPath.row]
            
            cell.setCell(vehicleNumber: "\(vehicle.vehicleSubNum) \(vehicle.vehicleMainNum)")
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.vehicleTableView {
            let vehicle = self.vehicleList[indexPath.row]
            self.selectedVehicle = vehicle
            
            self.vehicleNumberLabel.text = "\(vehicle.vehicleSubNum) \(vehicle.vehicleMainNum)"
            self.vehicleListBackgroundView.isHidden = true
            self.vehicleListView.isHidden = true
            
        }
        
    }
    
}

