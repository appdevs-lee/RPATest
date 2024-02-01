//
//  DepartureFigureBottomSheetViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/24/24.
//

import UIKit

final class DepartureFigureBottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    // 바텀 시트 높이
    let bottomHeight: CGFloat = 256
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private var bottomSheetViewBottomConstraint: NSLayoutConstraint!
    
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
    
    // MARK: - Departure Figure Property
    lazy var departureFigureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발 전 계기판을 확인하여 현재 KM를 적어주세요."
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureFigureTextfield: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.attributedPlaceholder = NSAttributedString(string: "KM를 입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.setBorder()
        textField.borderStyle = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 18, weight: .Medium)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedDoneButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dispatchModel = DispatchModel()
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.departureFigureTextfield.resignFirstResponder()
    }
    
    deinit {
        print("----------------------------------- DepartureFigureBottomSheetViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DepartureFigureBottomSheetViewController: EssentialViewMethods {
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
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
            self.bottomSheetView,
            self.dismissIndicatorView,
            self.departureFigureTitleLabel,
            self.departureFigureTextfield,
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
        self.bottomSheetViewBottomConstraint = self.bottomSheetView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor)
        NSLayoutConstraint.activate([
            self.bottomSheetView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.bottomSheetViewBottomConstraint,
            self.bottomSheetViewTopConstraint
        ])
        
        NSLayoutConstraint.activate([
            self.dismissIndicatorView.widthAnchor.constraint(equalToConstant: 64),
            self.dismissIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            self.dismissIndicatorView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor, constant: 12),
            self.dismissIndicatorView.centerXAnchor.constraint(equalTo: self.bottomSheetView.centerXAnchor)
        ])
        
        // departureFigureTitleLabel
        NSLayoutConstraint.activate([
            self.departureFigureTitleLabel.topAnchor.constraint(equalTo: self.dismissIndicatorView.bottomAnchor, constant: 10),
            self.departureFigureTitleLabel.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.departureFigureTitleLabel.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16)
        ])
        
        // departureFigureTextfield
        NSLayoutConstraint.activate([
            self.departureFigureTextfield.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.departureFigureTextfield.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.departureFigureTextfield.topAnchor.constraint(equalTo: self.departureFigureTitleLabel.bottomAnchor, constant: 20),
            self.departureFigureTextfield.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.doneButton.topAnchor.constraint(equalTo: self.departureFigureTextfield.bottomAnchor, constant: 10),
            self.doneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - Extension for methods added
extension DepartureFigureBottomSheetViewController {
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
extension DepartureFigureBottomSheetViewController {
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
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            NSLayoutConstraint.deactivate([
                self.bottomSheetViewTopConstraint
            ])
            
            self.bottomSheetViewTopConstraint.constant -= keyboardSize.height
            
            NSLayoutConstraint.activate([
                self.bottomSheetViewTopConstraint
            ])
            
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            let topConstant = self.view.safeAreaInsets.bottom + self.view.safeAreaLayoutGuide.layoutFrame.height
            self.bottomSheetViewTopConstraint.constant = topConstant
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func tappedDoneButton(_ sender: UIButton) {
        self.departureFigureTextfield.resignFirstResponder()
        
        self.hideBottomSheetAndGoBack()
        
    }
}

