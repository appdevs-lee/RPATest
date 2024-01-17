//
//  AccidentPhotoViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/17/24.
//

import UIKit
import PhotosUI

class PhotoData {
    let title: String
    var selectedImageIdentifiers: [String] = []
    var pickedImageResults: [String:PHPickerResult] = [:]
    var imageData: [String: Data] = [:]
    
    init(title: String) {
        self.title = title
        
    }
}

final class AccidentPhotoViewController: UIViewController {
    
    lazy var accidentPhotoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "차량 사진을 찍어주세요."
        label.textColor = .black
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AccidentPhotoTableViewCell.self, forCellReuseIdentifier: "AccidentPhotoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("전송하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.addTarget(self, action: #selector(sendButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var photoList: [PhotoData] = [PhotoData(title: "내 차량"), PhotoData(title: "상대방 차량"), PhotoData(title: "가까운 사진"), PhotoData(title: "먼 사진")]
    
    var index: Int = 0
    var selectedImageIdentifiers: [String] = []
    var pickedImageResults: [String:PHPickerResult] = [:]
    var imageData: [String: Data] = [:]
    
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
        print("----------------------------------- AccidentPhotoViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension AccidentPhotoViewController: EssentialViewMethods {
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
            self.accidentPhotoTitleLabel,
            self.tableView,
            self.sendButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // accidentPhotoTitleLabel
        NSLayoutConstraint.activate([
            self.accidentPhotoTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.accidentPhotoTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.sendButton.topAnchor)
        ])
        
        // sendButton
        NSLayoutConstraint.activate([
            self.sendButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.sendButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.sendButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.sendButton.heightAnchor.constraint(equalToConstant: 48)
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
        
        self.navigationItem.title = "현장 사진 촬영"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "phone.fill")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension AccidentPhotoViewController {
    func openPhoto() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 3
        config.selection = .ordered
        config.preferredAssetRepresentationMode = .current
        config.preselectedAssetIdentifiers = self.photoList[self.index].selectedImageIdentifiers
        
        let vc = PHPickerViewController(configuration: config)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
}

// MARK: - Extension for selector methods
extension AccidentPhotoViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        if let url = URL(string: "tel://010-1234-1234") {
            UIApplication.shared.open(url)
            
        }
    }
    
    @objc func plusButton(_ sender: UIButton) {
        self.index = sender.tag
        
        let vc = AlertPopViewController(.normalTwoButton(messageTitle: "사진 등록 방법 선택", messageContent: "사진을 어떻게 등록하시겠습니까?", leftButtonTitle: "촬영", leftAction: {
            
        }, rightButtonTitle: "앨범", rightAction: {
            switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
            case .authorized:
                self.openPhoto()
                
            case .limited:
                let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 안내", messageContent: "사진 접근 권한이\n선택한 사진에만 허용되어 있습니다.\n설정에서 “모든 사진”으로 변경할 수 있습니다.", leftButtonTitle: "선택 유지", leftAction: {
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
                        self.openPhoto()
                        
                    case .limited:
                        let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 안내", messageContent: "사진 접근 권한이\n선택한 사진에만 허용되어 있습니다.\n설정에서 “모든 사진”으로 변경할 수 있습니다.", leftButtonTitle: "선택 유지", leftAction: {
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
        }))
        
        self.present(vc, animated: true)
    }
    
    @objc func sendButton(_ sender: UIButton) {
        let vc = AccidentReasonViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension AccidentPhotoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccidentPhotoTableViewCell", for: indexPath) as! AccidentPhotoTableViewCell
        let photo = self.photoList[indexPath.row]
        
        cell.setCell(photo: photo, index: indexPath.row)
        
        cell.plusButton.addTarget(self, action: #selector(plusButton(_:)), for: .touchUpInside)
        
        return cell
    }
}

// MARK: Extension for PHPickerViewControllerDelegate
extension AccidentPhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard !results.isEmpty else {
            self.photoList[self.index].pickedImageResults = [:]
            self.photoList[self.index].selectedImageIdentifiers = []
            self.photoList[self.index].imageData = [:]
            
            self.tableView.reloadData()
            return
        }
        
        var pickedResults: [String:PHPickerResult] = [:]
        var selectedIdentifiers: [String] = []
        var contentsMetaData: [String:PHAsset] = [:]
        
        var tempPickedResults: [String:PHPickerResult] = [:]
        
        for result in results {
            if let identifier = result.assetIdentifier {
                tempPickedResults[identifier] = self.photoList[self.index].pickedImageResults[identifier] ?? result
                
            }
        }
        
        pickedResults = tempPickedResults
        
        selectedIdentifiers = results.compactMap {
            $0.assetIdentifier
        }
        
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: selectedIdentifiers, options: nil)
        for index in 0..<assets.count {
            contentsMetaData.updateValue(assets[index], forKey: assets[index].localIdentifier)
        }
        
        DispatchQueue.main.async {
            SupportingMethods.shared.turnCoverView(.on)
            SupportingMethods.shared.gatherDataFromPickedContents(index: 0, pickerType: .image, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: [:]) { pickedResults, selectedIdentifiers, contentsData, _ in
                self.pickedImageResults = pickedResults
                self.selectedImageIdentifiers = selectedIdentifiers
                self.imageData = contentsData
                
                self.photoList[self.index].pickedImageResults = pickedResults
                self.photoList[self.index].selectedImageIdentifiers = selectedIdentifiers
                self.photoList[self.index].imageData = contentsData
                
                self.tableView.reloadData()
                
                DispatchQueue.main.async {
                    SupportingMethods.shared.turnCoverView(.off)
                }
                
            } failure: {
                SupportingMethods.shared.showAlertNoti(title: "사진을 가져오지 못했습니다.")
                
                SupportingMethods.shared.turnCoverView(.off)
            }
        }
    }
}
