//
//  DispatchRefusalViewController.swift
//  RPATest
//
//  Created by Awesomepia on 10/2/24.
//

import UIKit

final class DispatchRefusalViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "경조사 & 건강 이상만\n경위서 작성이 가능합니다."
        label.numberOfLines = 0
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.asColor(targetString: "경조사 & 건강 이상", color: .useRGB(red: 176, green: 0, blue: 32))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아래 사항 이외에는 반드시 운행을 이행해주셔야 합니다."
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reasonLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var reasonPlaceholderTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .useRGB(red: 189, green: 189, blue: 189)
        textView.font = .useFont(ofSize: 16, weight: .Medium)
        textView.text = "사유를 작성해주세요."
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var reasonTextView: UITextView = {
        let textView = UITextView()
        textView.font = .useFont(ofSize: 16, weight: .Medium)
        textView.textColor = .useRGB(red: 66, green: 66, blue: 66)
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("제출하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(submitButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let dispatchModel = NewDispatchModel()
    var dispatchKindType: DispatchKindType
    var id: Int
    
    init(dispatchKindType: DispatchKindType, id: Int) {
        self.dispatchKindType = dispatchKindType
        self.id = id
        
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
        self.setUpNavigationItem()
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
        self.reasonTextView.endEditing(true)
    }
    
    deinit {
        print("----------------------------------- DispatchRefusalViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchRefusalViewController: EssentialViewMethods {
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
            self.titleLabel,
            self.subTitleLabel,
            self.reasonLineView,
            self.reasonPlaceholderTextView,
            self.reasonTextView,
            self.submitButton,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
        ])
        
        // commentTextViewLineView
        NSLayoutConstraint.activate([
            self.reasonLineView.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 20),
            self.reasonLineView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.reasonLineView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.reasonLineView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        // reasonPlaceholderTextView
        NSLayoutConstraint.activate([
            self.reasonPlaceholderTextView.topAnchor.constraint(equalTo: self.reasonLineView.topAnchor, constant: 14),
            self.reasonPlaceholderTextView.bottomAnchor.constraint(equalTo: self.reasonLineView.bottomAnchor, constant: -14),
            self.reasonPlaceholderTextView.leadingAnchor.constraint(equalTo: self.reasonLineView.leadingAnchor, constant: 16),
            self.reasonPlaceholderTextView.trailingAnchor.constraint(equalTo: self.reasonLineView.trailingAnchor, constant: -16)
        ])
        
        // reasonTextView
        NSLayoutConstraint.activate([
            self.reasonTextView.topAnchor.constraint(equalTo: self.reasonLineView.topAnchor, constant: 14),
            self.reasonTextView.bottomAnchor.constraint(equalTo: self.reasonLineView.bottomAnchor, constant: -14),
            self.reasonTextView.leadingAnchor.constraint(equalTo: self.reasonLineView.leadingAnchor, constant: 16),
            self.reasonTextView.trailingAnchor.constraint(equalTo: self.reasonLineView.trailingAnchor, constant: -16)
        ])
        
        // submitButton
        NSLayoutConstraint.activate([
            self.submitButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.submitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -34),
            self.submitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
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
        
        self.navigationItem.title = "경위서 작성"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension DispatchRefusalViewController {
    func sendDispatchCheckDataRequest(refusal: String, id: Int, dispatchType: DispatchKindType, success: (() -> ())?) {
        self.dispatchModel.sendDispatchCheckDataRequest(check: .refusal, refusal: refusal, regularlyId: dispatchType == .regularly ? "\(id)" : "", orderId: dispatchType == .order ? "\(id)" : "") {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.turnCoverView(.off)
            print("sendDispatchCheckDataRequest API Error: \(message)")
            
        }

        
    }
    
}

// MARK: - Extension for selector methods
extension DispatchRefusalViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func submitButton(_ sender: UIButton) {
        let vc = AlertPopViewController(.normalTwoButton(messageTitle: "경위서 작성을 완료하셨나요?", messageContent: "회사 내규에 맞지 않는 이유로 배차 거부 시, 불이익이 있을 수 있습니다. 다시 한 번 확인해주세요.", leftButtonTitle: "취소", leftAction: { }, rightButtonTitle: "제출하기", rightAction: {
            SupportingMethods.shared.turnCoverView(.on)
            self.sendDispatchCheckDataRequest(refusal: self.reasonTextView.text, id: self.id, dispatchType: self.dispatchKindType) {
                self.navigationController?.popViewController(animated: true)
                NotificationCenter.default.post(name: Notification.Name("DispatchRefusalCompleted"), object: nil)
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }))
        
        self.present(vc, animated: true)
        
    }
    
}

// MARK: - Extension for UITextViewDelegate
extension DispatchRefusalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let reason = self.reasonTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let reasonAttributed = self.reasonTextView.attributedText.string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if reason != "" && reasonAttributed != "" {
            self.reasonPlaceholderTextView.isHidden = true
            self.submitButton.isEnabled = true
            self.submitButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            
        } else {
            self.reasonPlaceholderTextView.isHidden = false
            self.submitButton.isEnabled = false
            self.submitButton.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
            
        }
        
    }
    
}

