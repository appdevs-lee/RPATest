//
//  InspectionCreateViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2023/09/21.
//

import UIKit
import PhotosUI

final class InspectionCreateViewController: UIViewController {
    
    lazy var vehicleNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "차량번호: "
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var vehicleNumberButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Other"), for: .normal)
        button.addTarget(self, action: #selector(tappedVehicleListView(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.useRGB(red: 224, green: 224, blue: 224).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setImage(UIImage(named: "plusImage"), for: .normal)
        button.addTarget(self, action: #selector(plusButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var contentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.itemSize = CGSize(width: 83, height: 83)
        //flowLayout.minimumLineSpacing = 4
        //flowLayout.minimumInteritemSpacing = 0
        //flowLayout.headerReferenceSize = CGSize(width: 4, height: 83)
        //flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(AddingContentCell.self, forCellWithReuseIdentifier: "AddingContentCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
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
        textView.text = "내용을 입력해주세요."
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
    
    var pickerType: PickerType = .image
    
    var selectedImageIdentifiers: [String] = []
    var selectedVideoIdentifiers: [String] = []
    var pickedImageResults: [String:PHPickerResult] = [:]
    var pickedVideoResults: [String:PHPickerResult] = [:]
    var imageData: [String:Data] = [:] {
        didSet {
            
        }
    }
    var videoData: [String:Data] = [:] {
        didSet {
            
        }
    }
    var imageMetaData: [String:PHAsset] = [:]
    var videoMetaData: [String:PHAsset] = [:]
    
    var bottomGuideViewBottomAnchor: NSLayoutConstraint!
    
    let inspectionModel = InspectionModel()
    let commonModel = OldCommonModel()
    let dispatchModel = DispatchModel()
    
    var vehicleList: [VehicleListItem] = []
    var type: CommentType
    var vehicleId: Int?
    var contentNumber: Int
    var parentNumber: Int
    
    init(_ type: CommentType, vehicleList: [VehicleListItem] = [], contentNumber: Int = 0, parentNumber: Int = 0) {
        self.type = type
        self.vehicleList = vehicleList
        self.contentNumber = contentNumber
        self.parentNumber = parentNumber
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    deinit {
            print("----------------------------------- WriteCommentViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension InspectionCreateViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // No bar line appears
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "민원 작성"
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
        rightBarButtonItem.isEnabled = false
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func initializeObjects() {
        if !self.vehicleList.isEmpty {
            let vc = InspectionVehicleListViewController(vehicleList: self.vehicleList)
            
            self.present(vc, animated: true)
        }
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
        NotificationCenter.default.addObserver(self, selector: #selector(addVehicleData), name: Notification.Name("SendVehicle"), object: nil)
    }
    
    func setSubviews() {
        if self.type == .inspector {
            self.view.addSubview(self.vehicleNumberLabel)
            self.view.addSubview(self.vehicleNumberButton)
        }
        
        SupportingMethods.shared.addSubviews([
            self.plusButton,
            self.contentCollectionView,
            self.commentTextViewLineView,
            self.commentPlaceholderTextView,
            self.commentTextView,
            self.alertLabel,
            self.bottomGuideView
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        switch self.type {
        case .consulting:
            // plusButton
            NSLayoutConstraint.activate([
                self.plusButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
                self.plusButton.heightAnchor.constraint(equalToConstant: 83),
                self.plusButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                self.plusButton.widthAnchor.constraint(equalToConstant: 83)
            ])
            
        case .inspector:
            // vehicleNumberLabel
            NSLayoutConstraint.activate([
                self.vehicleNumberLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
                self.vehicleNumberLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
            ])
            
            // vehicleNumberButton
            NSLayoutConstraint.activate([
                self.vehicleNumberButton.centerYAnchor.constraint(equalTo: self.vehicleNumberLabel.centerYAnchor),
                self.vehicleNumberButton.heightAnchor.constraint(equalToConstant: 20),
                self.vehicleNumberButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
                self.vehicleNumberButton.widthAnchor.constraint(equalToConstant: 20)
            ])
            
            // plusButton
            NSLayoutConstraint.activate([
                self.plusButton.topAnchor.constraint(equalTo: self.vehicleNumberLabel.bottomAnchor, constant: 16),
                self.plusButton.heightAnchor.constraint(equalToConstant: 83),
                self.plusButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                self.plusButton.widthAnchor.constraint(equalToConstant: 83)
            ])
        }
        
        // contentCollectionView
        NSLayoutConstraint.activate([
            self.contentCollectionView.topAnchor.constraint(equalTo: self.plusButton.topAnchor),
            self.contentCollectionView.heightAnchor.constraint(equalToConstant: 83),
            self.contentCollectionView.leadingAnchor.constraint(equalTo: self.plusButton.trailingAnchor, constant: 4),
            self.contentCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        // commentTextViewLineView
        let commentTextViewLineView = self.commentTextViewLineView.heightAnchor.constraint(equalToConstant: 312)
        commentTextViewLineView.priority = UILayoutPriority(750)
        NSLayoutConstraint.activate([
            self.commentTextViewLineView.topAnchor.constraint(equalTo: self.contentCollectionView.bottomAnchor, constant: 40),
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
}

// MARK: - Extension for methods added
extension InspectionCreateViewController {
    func writeRequest(content: String, success: (() -> ())?, failure:((String) -> ())?) {
        self.commonModel.writeRequest(type: self.type, content: content, vehicleId: self.vehicleId, imageData: self.selectedImageIdentifiers.map({ self.imageData[$0] }).compactMap({ $0 })) {
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
        }
    }
    
    func loadVehicleListRequest(success: (([VehicleListItem]) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.dispatchModel.loadVehicleListRequest { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func openPhoto() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = self.pickerType == .image ? .images : .videos
        config.selectionLimit = self.pickerType == .image ? 10 : 1
        config.selection = self.pickerType == .image ? .ordered : .default
        config.preferredAssetRepresentationMode = .current
        if self.pickerType == .image {
            config.preselectedAssetIdentifiers = self.selectedImageIdentifiers // more than 1
        }
        
        let vc = PHPickerViewController(configuration: config)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
}

// MARK: - Extension for selector methods
extension InspectionCreateViewController {
    @objc func leftBarButtonItem(_ sender: UIBarButtonItem) {
        self.commentTextView.resignFirstResponder()
        
        let comment = self.commentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if comment == "" && self.selectedImageIdentifiers.isEmpty && self.selectedVideoIdentifiers.isEmpty {
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "댓글 등록을 취소하시겠어요?", messageContent: "나가시면 작성된 내용은 저장되지 않습니다.", leftButtonTitle: "취소", leftAction: nil, rightButtonTitle: "나가기", rightAction: {
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(vc, animated: true)
        }
    }
    
    @objc func rightBarButtonItem(_ sender: UIBarButtonItem) {
        self.commentTextView.resignFirstResponder()
        
        SupportingMethods.shared.turnCoverView(.on)
        self.writeRequest(content: self.commentTextView.text) {
            SupportingMethods.shared.turnCoverView(.off)
            
            SupportingMethods.shared.showAlertNoti(title: "민원이 등록되었습니다.")
            self.navigationController?.popViewController(animated: true)

        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
        }
    }
    
    @objc func tapGesture(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func plusButton(_ sender: UIButton) {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized:
            self.pickerType = .image
            
            self.openPhoto()
        case .limited:
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 안내", messageContent: "사진 접근 권한이\n선택한 사진에만 허용되어 있습니다.\n설정에서 “모든 사진”으로 변경할 수 있습니다.", leftButtonTitle: "선택 유지", leftAction: {
                self.pickerType = .image
                
                self.openPhoto()
                
            }, rightButtonTitle: "설정", rightAction: {
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }))
            
            self.present(vc, animated: true)
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized:
                    self.pickerType = .image
                    
                    self.openPhoto()
                    
                case .limited:
                    let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 안내", messageContent: "사진 접근 권한이\n선택한 사진에만 허용되어 있습니다.\n설정에서 “모든 사진”으로 변경할 수 있습니다.", leftButtonTitle: "선택 유지", leftAction: {
                        self.pickerType = .image
                        
                        self.openPhoto()
                        
                    }, rightButtonTitle: "설정", rightAction: {
                        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }))
                    
                    self.present(vc, animated: true)
                    
                default:
                    let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 필요", messageContent: "사진/동영상 업로드를 위해\n설정에서 ‘사진 접근 권한’을 허용해야 합니다.", leftButtonTitle: "취소", leftAction: nil, rightButtonTitle: "설정", rightAction: {
                        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }))
                    
                    self.present(vc, animated: true)
                }
            }
            
        default:
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 필요", messageContent: "사진/동영상 업로드를 위해\n설정에서 ‘사진 접근 권한’을 허용해야 합니다.", leftButtonTitle: "취소", leftAction: nil, rightButtonTitle: "설정", rightAction: {
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }))
            
            self.present(vc, animated: true)
        }
    }
    
    @objc func deleteButton(_ sender: IndexPathButton) {
        if sender.indexPath.section == 0 { // video
            self.videoData.removeValue(forKey: self.selectedVideoIdentifiers[sender.indexPath.item])
            self.selectedVideoIdentifiers.remove(at: sender.indexPath.item)
            
        } else { // 1 - image
            self.imageData.removeValue(forKey: self.selectedImageIdentifiers[sender.indexPath.item])
            self.selectedImageIdentifiers.remove(at: sender.indexPath.item)
        }
        
        self.contentCollectionView.reloadData()
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
    
    @objc func tappedVehicleListView(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadVehicleListRequest { item in
            let vc = InspectionVehicleListViewController(vehicleList: item)
            
            self.present(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("tappedVehicleListView loadVehicleListRequest API Error: \(errorMessage)")
        }

    }
    
    @objc func addVehicleData(_ noti: Notification) {
        SupportingMethods.shared.turnCoverView(.on)
        guard let vehicleId = noti.userInfo?["vehicleId"] as? Int else {
            SupportingMethods.shared.turnCoverView(.off)
            return
        }
        
        guard let vehicleNumber = noti.userInfo?["vehicleNumber"] as? String else {
            SupportingMethods.shared.turnCoverView(.off)
            return
        }
        
        self.vehicleId = vehicleId
        self.vehicleNumberLabel.text = "차량번호: \(vehicleNumber)"
        
        SupportingMethods.shared.turnCoverView(.off)
    }
}

// MARK: - Extension for UICollectionViewDelegate, UICollectionViewDataSource
extension InspectionCreateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return .zero
            
        } else {
            return self.selectedVideoIdentifiers.isEmpty || self.selectedImageIdentifiers.isEmpty ? .zero : CGSize(width: 4, height: 83)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { // video
            return self.selectedVideoIdentifiers.count
            
        } else { // 1 - image
            return self.selectedImageIdentifiers.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 83, height: 83)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddingContentCell", for: indexPath) as! AddingContentCell
        
        if indexPath.section == 0 { // video
            cell.setCell(self.videoData["thumbnailData"] ?? Data(), isMovie: false, indexPath: indexPath)
            
        } else { // 1 - image
            cell.setCell(self.imageData[self.selectedImageIdentifiers[indexPath.item]] ?? Data(), isMovie: false, indexPath: indexPath)
        }
        
        cell.deleteButton.addTarget(self, action: #selector(deleteButton(_:)), for: .touchUpInside)
        
        return cell
    }
}

// MARK: - Extension for UITextViewDelegate
extension InspectionCreateViewController: UITextViewDelegate {
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

// MARK: Extension for PHPickerViewControllerDelegate
extension InspectionCreateViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard !results.isEmpty else {
            return
        }
        
        var pickedResults: [String:PHPickerResult] = [:]
        var selectedIdentifiers: [String] = []
        var contentsMetaData: [String:PHAsset] = [:]
        
        var tempPickedResults: [String:PHPickerResult] = [:]
        
        for result in results {
            if let identifier = result.assetIdentifier {
                if self.pickerType == .image {
                    tempPickedResults[identifier] = self.pickedImageResults[identifier] ?? result
                    
                } else { // video
                    tempPickedResults[identifier] = self.pickedVideoResults[identifier] ?? result
                }
            }
        }
        
        if self.pickerType == .image {
            pickedResults = tempPickedResults
            
            selectedIdentifiers = results.compactMap {
                $0.assetIdentifier
            }
            
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: selectedIdentifiers, options: nil)
            for index in 0..<assets.count {
                contentsMetaData.updateValue(assets[index], forKey: assets[index].localIdentifier)
            }
            
        } else { // video
            pickedResults = tempPickedResults
            
            selectedIdentifiers = results.compactMap {
                $0.assetIdentifier
            }
            
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: selectedIdentifiers, options: nil)
            for index in 0..<assets.count {
                contentsMetaData.updateValue(assets[index], forKey: assets[index].localIdentifier)
            }
            
            if let videoDuration = contentsMetaData.first?.value.duration, videoDuration > 60.0 {
                DispatchQueue.main.async {
                    SupportingMethods.shared.showAlertNoti(title: "1분 이내의 영상으로 등록해 주세요.")
                }
                
                return
            }
        }
        
        DispatchQueue.main.async {
            SupportingMethods.shared.turnCoverView(.on)
            SupportingMethods.shared.gatherDataFromPickedContents(index: 0, pickerType: self.pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: [:]) { pickedResults, selectedIdentifiers, contentsData, _ in
                switch self.pickerType {
                case .image:
                    self.pickedImageResults = pickedResults
                    self.selectedImageIdentifiers = selectedIdentifiers
                    self.imageData = contentsData
                    
                case .video:
                    self.pickedVideoResults = pickedResults
                    self.selectedVideoIdentifiers = selectedIdentifiers
                    self.videoData = contentsData
                }
                
                self.contentCollectionView.reloadData()
                
                DispatchQueue.main.async {
                    SupportingMethods.shared.turnCoverView(.off)
                }
                
            } failure: {
                switch self.pickerType {
                case .image:
                    SupportingMethods.shared.showAlertNoti(title: "사진을 가져오지 못했습니다.")
                    
                case .video:
                    SupportingMethods.shared.showAlertNoti(title: "영상을 가져오지 못했습니다.")
                }
                
                SupportingMethods.shared.turnCoverView(.off)
            }
        }
    }
}
