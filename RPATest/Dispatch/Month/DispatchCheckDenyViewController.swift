//
//  DispatchCheckDenyViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/14.
//

import UIKit

final class DispatchCheckDenyViewController: UIViewController {
    
    lazy var guidLabel: UILabel = {
        let label = UILabel()
        label.text = "특별한 사유 없이 배차를 거부할 경우\n징계사유(인사위원회 개최)가 될 수 있습니다."
        label.numberOfLines = 0
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var denyReasonTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.textColor = .useRGB(red: 189, green: 189, blue: 189)
        textView.font = .useFont(ofSize: 16, weight: .Medium)
        textView.text = "내용을 입력해주세요."
        textView.textContainerInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var bottomGuideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(id: Int) {
        self.id = id
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dispatchModel = DispatchModel()
    var id: Int
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.denyReasonTextView.resignFirstResponder()
    }
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return .portrait
//    }
    
    deinit {
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchCheckDenyViewController: EssentialViewMethods {
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
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.guidLabel,
            self.denyReasonTextView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // guidLabel
        NSLayoutConstraint.activate([
            self.guidLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.guidLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10)
        ])
        
        // denyReasonTextView
        NSLayoutConstraint.activate([
            self.denyReasonTextView.heightAnchor.constraint(equalToConstant: 315),
            self.denyReasonTextView.topAnchor.constraint(equalTo: self.guidLabel.bottomAnchor, constant: 14),
            self.denyReasonTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.denyReasonTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNavigationItem() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // No bar line appears
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "운행 불가 사유 작성"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        let rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        rightBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 16, weight: .Bold),
            .foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189)
        ], for: .disabled)
        rightBarButtonItem.setTitleTextAttributes([
            .foregroundColor:UIColor.useRGB(red: 151, green: 157, blue: 242),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ], for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - Extension for methods added
extension DispatchCheckDenyViewController {
    func checkDispatchRequest(check: String, refusal: String, regularlyId: String, orderId: String, success: (() -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.checkDispatchRequest(check: check, refusal: refusal, regularlyId: regularlyId, orderId: orderId) {
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension DispatchCheckDenyViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.denyReasonTextView.resignFirstResponder()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.denyReasonTextView.resignFirstResponder()
        
        SupportingMethods.shared.turnCoverView(.on)
        self.checkDispatchRequest(check: "0", refusal: self.denyReasonTextView.text, regularlyId: "\(self.id)", orderId: "") {
            NotificationCenter.default.post(name: Notification.Name("DispatchDenyComplete"), object: nil)
            
            self.navigationController?.popViewController(animated: true)
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("tapDenyButton checkDispatchRequest API Error: \(errorMessage)")
            
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
//            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
//            
//            UIView.animate(withDuration: duration) {
//                self.view.layoutIfNeeded()
//                
//            } completion: { finished in
//                
//            }
//        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
//        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
//            
//            UIView.animate(withDuration: duration) {
//                self.view.layoutIfNeeded()
//                
//            } completion: { finished in
//                
//            }
//        }
    }
}

// MARK: - Extension for UITextViewDelegate
extension DispatchCheckDenyViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        if changedText.count <= ReferenceValues.TextCount.Comment.comment {
            return true
            
        } else {
            return false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "내용을 입력해주세요."
            textView.textColor = .useRGB(red: 189, green: 189, blue: 189)
            textView.font = .useFont(ofSize: 16, weight: .Medium)
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "내용을 입력해주세요." {
            textView.text = ""
            textView.font = .useFont(ofSize: 16, weight: .Medium)
            textView.textColor = .useRGB(red: 66, green: 66, blue: 66)
        }
        
        return true
    }
}
