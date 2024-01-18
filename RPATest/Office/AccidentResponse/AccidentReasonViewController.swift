//
//  AccidentReasonViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/17/24.
//

import UIKit

final class AccidentReasonViewController: UIViewController {
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progress = 5/7
        view.trackTintColor = .useRGB(red: 233, green: 236, blue: 239)
        view.progressTintColor = .useRGB(red: 33, green: 37, blue: 41)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "정해진 양식에 맞게 경위서를 작성해주세요."
        label.textColor = .black
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subGuideLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "정확하고 빠른 사고 파악을 위해\n꼭! 운행 재개 전에 작성해주세요!"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var commentTextViewLineView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var commentPlaceholderTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .useRGB(red: 189, green: 189, blue: 189)
        textView.font = .useFont(ofSize: 16, weight: .Medium)
        textView.text = ""
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .useFont(ofSize: 16, weight: .Medium)
        textView.textColor = .useRGB(red: 66, green: 66, blue: 66)
        textView.backgroundColor = .clear
        textView.delegate = self
        textView.text = """
        \(UserInfo.shared.name ?? "")\n
        [사고발생]\n
        업체명| \n
        차량번호ㅣ 경기70사5009\n
        노선명ㅣ 퇴근(17:25)H3분당A\n
        사고발생지점ㅣ 죽전휴게소\n
        사고발생시간ㅣ \(SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"))\n
        운행재개시간ㅣ 18:10\n
        사고당시 차량속도ㅣ 정지상태\n
        탑승인원ㅣ 0명(명단확보완료)\n
        """
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 255, green: 106, blue: 106)
        label.textAlignment = .left
        label.text = "비속어는 사용할 수 없습니다."
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomGuideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var bottomGuideViewBottomAnchor: NSLayoutConstraint!
    
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
        print("----------------------------------- AccidentReasonViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension AccidentReasonViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.progressView,
            self.guideLabel,
            self.subGuideLabel,
            self.commentTextViewLineView,
            self.commentPlaceholderTextView,
            self.commentTextView,
            self.alertLabel,
            self.bottomGuideView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.progressView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.progressView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        // guideLabel
        NSLayoutConstraint.activate([
            self.guideLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.guideLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.guideLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 10)
        ])
        
        // subGuideLabel
        NSLayoutConstraint.activate([
            self.subGuideLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.subGuideLabel.topAnchor.constraint(equalTo: self.guideLabel.bottomAnchor, constant: 8)
        ])
        
        // commentTextViewLineView
        let commentTextViewLineView = self.commentTextViewLineView.heightAnchor.constraint(equalToConstant: 460)
        commentTextViewLineView.priority = UILayoutPriority(750)
        NSLayoutConstraint.activate([
            self.commentTextViewLineView.topAnchor.constraint(equalTo: self.subGuideLabel.bottomAnchor, constant: 40),
            commentTextViewLineView,
            self.commentTextViewLineView.bottomAnchor.constraint(equalTo: self.alertLabel.topAnchor, constant: -4),
            self.commentTextViewLineView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.commentTextViewLineView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
        
        // commentPlaceholderTextView
        NSLayoutConstraint.activate([
            self.commentPlaceholderTextView.topAnchor.constraint(equalTo: self.commentTextViewLineView.topAnchor, constant: 14),
            self.commentPlaceholderTextView.bottomAnchor.constraint(equalTo: self.commentTextViewLineView.bottomAnchor, constant: -14),
            self.commentPlaceholderTextView.leadingAnchor.constraint(equalTo: self.commentTextViewLineView.leadingAnchor, constant: 16),
            self.commentPlaceholderTextView.trailingAnchor.constraint(equalTo: self.commentTextViewLineView.trailingAnchor, constant: -16)
        ])
        
        // commentTextView
        NSLayoutConstraint.activate([
            self.commentTextView.topAnchor.constraint(equalTo: self.commentTextViewLineView.topAnchor, constant: 14),
            self.commentTextView.bottomAnchor.constraint(equalTo: self.commentTextViewLineView.bottomAnchor, constant: -14),
            self.commentTextView.leadingAnchor.constraint(equalTo: self.commentTextViewLineView.leadingAnchor, constant: 16),
            self.commentTextView.trailingAnchor.constraint(equalTo: self.commentTextViewLineView.trailingAnchor, constant: -16)
        ])
        
        // alertLabel
        NSLayoutConstraint.activate([
            self.alertLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomGuideView.topAnchor, constant: -20),
            self.alertLabel.heightAnchor.constraint(equalToConstant: 20),
            self.alertLabel.leadingAnchor.constraint(equalTo: self.commentTextView.leadingAnchor),
            self.alertLabel.trailingAnchor.constraint(equalTo: self.commentTextView.trailingAnchor)
        ])
        
        // bottomGuideView
        self.bottomGuideViewBottomAnchor = self.bottomGuideView.topAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([
            self.bottomGuideViewBottomAnchor,
            self.bottomGuideView.heightAnchor.constraint(equalToConstant: 1),
            self.bottomGuideView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.bottomGuideView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
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
        
        self.navigationItem.title = "5. 경위서 작성"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        
        let rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        rightBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 16, weight: .Bold),
            .foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189)
        ], for: .disabled)
        rightBarButtonItem.setTitleTextAttributes([
            .foregroundColor:UIColor.useRGB(red: 176, green: 0, blue: 32),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ], for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - Extension for methods added
extension AccidentReasonViewController {
    @objc func leftBarButtonItem(_ sender: UIBarButtonItem) {
        self.commentTextView.resignFirstResponder()
        
        self.navigationController?.popViewController(animated: false)
        
//        let comment = self.commentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
//        
//        if comment == "" {
//            self.navigationController?.popViewController(animated: true)
//            
//        } else {
//            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "사고 현장 경위서를 임시 저장하시겠습니까?", messageContent: "다시 작성하시려면, 홈 화면에 있는 사고 대응 버튼을 눌러주세요.", leftButtonTitle: "취소", leftAction: nil, rightButtonTitle: "나가기", rightAction: {
//                
//                ReferenceValues.isDoingAccidentResponse = true
//                self.navigationController?.popViewController(animated: true)
//                
//            }))
//            
//            self.present(vc, animated: true)
//        }
    }
    
    @objc func rightBarButtonItem(_ sender: UIBarButtonItem) {
        self.commentTextView.resignFirstResponder()
        let vc = AccidentBeforeDrivingViewController()
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

// MARK: - Extension for selector methods
extension AccidentReasonViewController {
    @objc func tapGesture(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            self.bottomGuideViewBottomAnchor.constant = -keyboardSize.height
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            self.bottomGuideViewBottomAnchor.constant = 0
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
}

// MARK: - Extension for UITextViewDelegate
extension AccidentReasonViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let comment = self.commentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let commentAttributed = self.commentTextView.attributedText.string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if comment != "" && commentAttributed != "" {
            self.commentPlaceholderTextView.isHidden = true
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            
        } else {
            self.commentPlaceholderTextView.isHidden = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
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
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.alertLabel.isHidden = true
        
        return true
    }
}

