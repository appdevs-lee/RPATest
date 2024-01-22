//
//  DispatchInspectionViewController.swift
//  RPATest
//
//  Created by Awesomepia on 12/14/23.
//

import UIKit

enum DispatchInspectionType {
    case daily
    case weekly
    case monthly
    
    var data: [String] {
        switch self {
        case .daily:
            return ["오일/엔진,부동액","오일/파워,클러치","냉각수,워셔액","외부자체상태(파손확인)","등화장치(실내/외)","블랙박스(작동여부확인)","타이어상태(나사,못)","실내상태(복도,선반,청소상태)","안전벨트/슬라이드 상태","제복착용"]
            
        case .weekly:
            return ["유리/선팅", "자격증/차고지증명서/운행기록증", "타이어 휠 상태", "차량청결(외부)", "비상망치(수량 및 야과스티커)", "소화기(수량 및 충전상태)", "블랙박스 포맷확인"]
            
        case .monthly:
            return ["TV", "DVD", "노래방", "바닥스피커", "길성테크", "바닥파워", "인버터", "블랙박스", "전광판", "블라인드"]
            
        }
    }
}

final class DispatchInspectionViewController: UIViewController {
    
    // MARK: - Properties
    // 바텀 시트 높이
    let bottomHeight: CGFloat = 500
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // 바텀 시트 뷰
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // dismiss Indicator View UI 구성 부분
    private let dismissIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var carNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.carNumber)번"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        switch self.type {
        case .daily:
            label.text = "일일 점검"
            
        case .weekly:
            label.text = "주간 점검"
            
        case .monthly:
            label.text = "비품 점검"
            
        }
        
        return label
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchInspectionTableViewCell.self, forCellReuseIdentifier: "DispatchInspectionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 13.5
        button.addTarget(self, action: #selector(tappedDoneButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(type: DispatchInspectionType, carNumber: String) {
        self.type = type
        self.dataList = self.type.data
        self.carNumber = carNumber
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var type: DispatchInspectionType
    var dataList: [String] = []
    var carNumber: String
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showBottomSheet()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- DispatchInspectionViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchInspectionViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.modalPresentationStyle = .overFullScreen
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        self.baseView.addGestureRecognizer(dimmedTap)
        self.baseView.isUserInteractionEnabled = true
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        dismissIndicatorView.addGestureRecognizer(swipeGesture)
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
            self.bottomSheetView,
            self.dismissIndicatorView,
            self.carNumberLabel,
            self.titleLabel,
            self.dividerView,
            self.tableView,
            self.doneButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
        
        let topConstant = self.view.safeAreaInsets.bottom + safeArea.layoutFrame.height
        self.bottomSheetViewTopConstraint = self.bottomSheetView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            self.bottomSheetView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.bottomSheetViewTopConstraint
        ])
        
        NSLayoutConstraint.activate([
            self.dismissIndicatorView.widthAnchor.constraint(equalToConstant: 64),
            self.dismissIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            self.dismissIndicatorView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor, constant: 12),
            self.dismissIndicatorView.centerXAnchor.constraint(equalTo: self.bottomSheetView.centerXAnchor)
        ])
        
        // carNumberLabel
        NSLayoutConstraint.activate([
            self.carNumberLabel.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.carNumberLabel.topAnchor.constraint(equalTo: self.dismissIndicatorView.bottomAnchor, constant: 10),
            self.carNumberLabel.bottomAnchor.constraint(equalTo: self.dividerView.topAnchor, constant: -8)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.carNumberLabel.trailingAnchor, constant: 8),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.carNumberLabel.centerYAnchor)
        ])
        
        // dividerView
        NSLayoutConstraint.activate([
            self.dividerView.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.dividerView.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.doneButton.topAnchor, constant: -10)
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.doneButton.heightAnchor.constraint(equalToConstant: 44),
            self.doneButton.bottomAnchor.constraint(equalTo: self.bottomSheetView.bottomAnchor, constant: -34)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - Extension for methods added
extension DispatchInspectionViewController {
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        self.bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - self.bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        self.bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}

// MARK: - Extension for selector methods
extension DispatchInspectionViewController {
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        self.hideBottomSheetAndGoBack()
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                self.hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
    
    @objc func tappedDoneButton(_ sender: UIButton) {
        self.hideBottomSheetAndGoBack()
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchInspectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchInspectionTableViewCell", for: indexPath) as! DispatchInspectionTableViewCell
        let title = self.dataList[indexPath.row]
        
        cell.setCell(title: title)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - Extension for DispatchInspectionDelegate
extension DispatchInspectionViewController: DispatchInspectionDelegate {
    func tappedFineButton(status: (fine: Int, normal: Int, notFine: Int)) {
        
    }
    
    func tappedNormalButton(status: (fine: Int, normal: Int, notFine: Int)) {
        
    }
    
    func tappedNotFineButton(status: (fine: Int, normal: Int, notFine: Int)) {
        
    }
    

}
