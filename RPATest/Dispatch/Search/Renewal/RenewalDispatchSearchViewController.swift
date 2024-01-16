//
//  RenewalDispatchSearchViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/16/24.
//

import UIKit

final class RenewalDispatchSearchViewController: UIViewController {
    
    lazy var titleBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 224, green: 224, blue: 227)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "노선검색"
        label.textColor = .black
        label.font = .useFont(ofSize: 24, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var placeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사업장"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var placeBaseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 189, green: 189, blue: 189).cgColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.text = "사업장을 선택해주세요."
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var downImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .useRGB(red: 176, green: 0, blue: 32)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var placeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var searchClassificationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 구분"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 70, height: 30)
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(SearchClassificationCollectionViewCell.self, forCellWithReuseIdentifier: "SearchClassificationCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var searchClassificationTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "노선명을 입력하세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 22, weight: .Medium)
            ])
        textField.addLeftPadding()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.useRGB(red: 189, green: 189, blue: 189).cgColor
        textField.layer.cornerRadius = 5
        textField.borderStyle = .none
        textField.textColor = .useRGB(red: 97, green: 97, blue: 97)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        label.textColor = .useRGB(red: 176, green: 0, blue: 32)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var timeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.startTimeBaseView, self.middleImageView, self.finishTimeBaseView,])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var startTimeBaseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 189, green: 189, blue: 189).cgColor
        view.layer.cornerRadius = 5
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var startTimeLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm")
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var startTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var middleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "alternatingcurrent")
        imageView.tintColor = .useRGB(red: 97, green: 97, blue: 97)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var finishTimeBaseView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 189, green: 189, blue: 189).cgColor
        view.layer.cornerRadius = 5
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var finishTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "23:59"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var finishTimeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 22, weight: .Bold)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedSearchButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var classificationList: [String] = ["노선명", "정류장", "내위치", "지역명", "지 도"]
    var selectedIndex: Int = 0
    
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
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- RenewalDispatchSearchViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalDispatchSearchViewController: EssentialViewMethods {
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
            self.titleBaseView,
            self.titleLabel,
            self.placeTitleLabel,
            self.placeBaseView,
            self.placeLabel,
            self.downImageView,
            self.placeButton,
            self.searchClassificationTitleLabel,
            self.collectionView,
            self.searchClassificationTextField,
            self.timeTitleLabel,
            self.timeStackView,
            self.searchButton
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.startTimeLabel,
            self.startTimeButton,
        ], to: self.startTimeBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.finishTimeLabel,
            self.finishTimeButton,
        ], to: self.finishTimeBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleBaseView
        NSLayoutConstraint.activate([
            self.titleBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.titleBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.titleBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.titleBaseView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.centerYAnchor.constraint(equalTo: self.titleBaseView.centerYAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.titleBaseView.leadingAnchor, constant: 16)
        ])
        
        // placeTitleLabel
        NSLayoutConstraint.activate([
            self.placeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.placeTitleLabel.topAnchor.constraint(equalTo: self.titleBaseView.bottomAnchor, constant: 16),
            self.placeTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // placeBaseView
        NSLayoutConstraint.activate([
            self.placeBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.placeBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.placeBaseView.topAnchor.constraint(equalTo: self.placeTitleLabel.bottomAnchor, constant: 4),
            self.placeBaseView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // placeLabel
        NSLayoutConstraint.activate([
            self.placeLabel.leadingAnchor.constraint(equalTo: self.placeBaseView.leadingAnchor, constant: 8),
            self.placeLabel.centerYAnchor.constraint(equalTo: self.placeBaseView.centerYAnchor)
        ])
        
        // downImageView
        NSLayoutConstraint.activate([
            self.downImageView.centerYAnchor.constraint(equalTo: self.placeBaseView.centerYAnchor),
            self.downImageView.trailingAnchor.constraint(equalTo: self.placeBaseView.trailingAnchor, constant: -8),
            self.downImageView.widthAnchor.constraint(equalToConstant: 24),
            self.downImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // placeButton
        NSLayoutConstraint.activate([
            self.placeButton.leadingAnchor.constraint(equalTo: self.placeBaseView.leadingAnchor),
            self.placeButton.trailingAnchor.constraint(equalTo: self.placeBaseView.trailingAnchor),
            self.placeButton.topAnchor.constraint(equalTo: self.placeBaseView.topAnchor),
            self.placeButton.bottomAnchor.constraint(equalTo: self.placeBaseView.bottomAnchor)
        ])
        
        // searchClassificationTitleLabel
        NSLayoutConstraint.activate([
            self.searchClassificationTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.searchClassificationTitleLabel.topAnchor.constraint(equalTo: self.placeBaseView.bottomAnchor, constant: 20),
            self.searchClassificationTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.collectionView.topAnchor.constraint(equalTo: self.searchClassificationTitleLabel.bottomAnchor, constant: 8),
            self.collectionView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // searchClassificationTextField
        NSLayoutConstraint.activate([
            self.searchClassificationTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.searchClassificationTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.searchClassificationTextField.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 8),
            self.searchClassificationTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // timeTitleLabel
        NSLayoutConstraint.activate([
            self.timeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.timeTitleLabel.topAnchor.constraint(equalTo: self.searchClassificationTextField.bottomAnchor, constant: 20),
            self.timeTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // timeStackView
        NSLayoutConstraint.activate([
            self.timeStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.timeStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.timeStackView.topAnchor.constraint(equalTo: self.timeTitleLabel.bottomAnchor, constant: 8),
            self.timeStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // startTimeBaseView
        NSLayoutConstraint.activate([
            self.startTimeBaseView.heightAnchor.constraint(equalToConstant: 44),
            self.startTimeBaseView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 48) / 2)
        ])
        
        // startTimeLabel
        NSLayoutConstraint.activate([
            self.startTimeLabel.centerYAnchor.constraint(equalTo: self.startTimeBaseView.centerYAnchor),
            self.startTimeLabel.centerXAnchor.constraint(equalTo: self.startTimeBaseView.centerXAnchor)
        ])
        
        // startTimeButton
        NSLayoutConstraint.activate([
            self.startTimeButton.leadingAnchor.constraint(equalTo: self.startTimeBaseView.leadingAnchor),
            self.startTimeButton.trailingAnchor.constraint(equalTo: self.startTimeBaseView.trailingAnchor),
            self.startTimeButton.topAnchor.constraint(equalTo: self.startTimeBaseView.topAnchor),
            self.startTimeButton.bottomAnchor.constraint(equalTo: self.startTimeBaseView.bottomAnchor),
        ])
        
        // middleImageView
        NSLayoutConstraint.activate([
            self.middleImageView.widthAnchor.constraint(equalToConstant: 16),
            self.middleImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        // finishTimeBaseView
        NSLayoutConstraint.activate([
            self.finishTimeBaseView.heightAnchor.constraint(equalToConstant: 44),
            self.finishTimeBaseView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 48) / 2)
        ])
        
        // finishTimeLabel
        NSLayoutConstraint.activate([
            self.finishTimeLabel.centerYAnchor.constraint(equalTo: self.finishTimeBaseView.centerYAnchor),
            self.finishTimeLabel.centerXAnchor.constraint(equalTo: self.finishTimeBaseView.centerXAnchor)
        ])
        
        // finishTimeButton
        NSLayoutConstraint.activate([
            self.finishTimeButton.leadingAnchor.constraint(equalTo: self.finishTimeBaseView.leadingAnchor),
            self.finishTimeButton.trailingAnchor.constraint(equalTo: self.finishTimeBaseView.trailingAnchor),
            self.finishTimeButton.topAnchor.constraint(equalTo: self.finishTimeBaseView.topAnchor),
            self.finishTimeButton.bottomAnchor.constraint(equalTo: self.finishTimeBaseView.bottomAnchor),
        ])
        
        // searchButton
        NSLayoutConstraint.activate([
            self.searchButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.searchButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.searchButton.topAnchor.constraint(equalTo: self.timeStackView.bottomAnchor, constant: 60),
            self.searchButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setUpNavigationTitle() -> UIImageView {
        let navigationTitleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        navigationTitleImageView.image = UIImage(named: "NavigationTitleImage")
        navigationTitleImageView.contentMode = .scaleAspectFit
        
        return navigationTitleImageView
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground() // No bar line appears
        appearance.backgroundColor = .useRGB(red: 176, green: 0, blue: 32) // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.titleView = self.setUpNavigationTitle()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension RenewalDispatchSearchViewController {
    
}

// MARK: - Extension for selector methods
extension RenewalDispatchSearchViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedSearchButton(_ sender: UIButton) {
        let vc = RenewalDispatchSearchListViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension for
extension RenewalDispatchSearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classificationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchClassificationCollectionViewCell", for: indexPath) as! SearchClassificationCollectionViewCell
        let title = self.classificationList[indexPath.row]
        
        cell.setCell(title: title)
        
        if self.selectedIndex == indexPath.row {
            cell.checkImageView.image = UIImage(named: "SelectSearchWay")
            cell.titleLabel.textColor = .useRGB(red: 97, green: 97, blue: 97)
            
        } else {
            cell.checkImageView.image = UIImage(named: "Check_No")
            cell.titleLabel.textColor = .useRGB(red: 189, green: 189, blue: 189)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        self.collectionView.reloadData()
    }
}
