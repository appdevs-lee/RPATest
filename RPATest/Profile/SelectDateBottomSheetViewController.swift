//
//  SelectDateBottomSheetViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2/1/24.
//

import UIKit

final class SelectDateBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    // 바텀 시트 높이
    let bottomHeight: CGFloat = 360
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    private lazy var baseView: UIView = {
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
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.date = SupportingMethods.shared.convertString(intoDate: self.date, "yyyy-MM-dd")
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        return picker
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(doneButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(date: String) {
        self.date = date
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        print("----------------------------------- SelectDateBottomSheetViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension SelectDateBottomSheetViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
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
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
            self.bottomSheetView,
            self.dismissIndicatorView,
            self.datePicker,
            self.doneButton
        ], to: self.view)
        
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
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
        
        // datePicker
        NSLayoutConstraint.activate([
            self.datePicker.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.datePicker.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.datePicker.topAnchor.constraint(equalTo: self.dismissIndicatorView.bottomAnchor, constant: 10),
            self.datePicker.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.doneButton.topAnchor.constraint(equalTo: self.datePicker.bottomAnchor, constant: 10),
            self.doneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - Extension for methods added
extension SelectDateBottomSheetViewController {
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        self.bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack(completionHandler: (() -> ())? = nil) {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        self.bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false) {
                    completionHandler?()
                    
                }
            }
        }
    }
}

// MARK: - Extension for selector methods
extension SelectDateBottomSheetViewController {
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
    
    @objc func doneButton(_ sender: UIButton) {
        self.hideBottomSheetAndGoBack() {
            NotificationCenter.default.post(name: Notification.Name("SelectDate"), object: nil, userInfo: ["date": self.datePicker.date])
            
        }
    }
}

