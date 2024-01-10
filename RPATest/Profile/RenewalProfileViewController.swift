//
//  RenewalProfileViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/23/23.
//

import UIKit

final class RenewalProfileViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.shared.name
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UserInfo.shared.role ?? "") / Team"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        view.layer.cornerRadius = 30
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var profileLabel: UIView = {
        let firstWordinName = UserInfo.shared.name == "" ? "" : String((UserInfo.shared.name?.first)!)
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 30, weight: .Medium)
        label.text = firstWordinName
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var salaryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedSalaryButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var salaryView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var salaryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SalaryImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.text = "급여 확인하기"
        label.textColor = .useRGB(red: 255, green: 106, blue: 106)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var pathKnowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var pathKnowLabel: UILabel = {
        let label = UILabel()
        label.text = "노선숙지 정도"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .useRGB(red: 176, green: 0, blue: 32)
        progressView.trackTintColor = .lightGray
        progressView.layer.cornerRadius = 4
        progressView.layer.masksToBounds = true
        progressView.progress = 0.3
        
        progressView.progressViewStyle = .bar
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    lazy var toDoListView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var toDoLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Card")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var cardNameLabel: UILabel = {
       let label = UILabel()
        label.text = UserInfo.shared.name
        label.textColor = .black
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var cardPhoneNumberLabel: UILabel = {
       let label = UILabel()
        label.text = UserInfo.shared.phoneNumber
        label.textColor = .black
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var cardShareButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedCardShareButton(_:)), for: .touchUpInside)
        button.setTitle("공유", for: .normal)
        button.setTitleColor(.useRGB(red: 176, green: 0, blue: 32), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var noDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noDataImageView, self.noDataLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoToDoImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 주요 일정 및 업무가 없습니다."
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let profileList: [Profile] = [.myInfo, .toDo, .driveWay]
    let dispatchModel = DispatchModel()
    let profileModel = ProfileModel()
    
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
        print("----------------------------------- RenewalProfileViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalProfileViewController: EssentialViewMethods {
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
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.scrollView
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.backgroundView
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.nameLabel,
            self.positionLabel,
            self.profileView,
            self.collectionView,
            self.salaryView,
            self.salaryButton,
            self.pathKnowView,
            self.toDoListView,
            self.cardView,
            self.cardShareButton
        ], to: self.backgroundView)
        
        // profileView
        SupportingMethods.shared.addSubviews([
            self.profileLabel
        ], to: self.profileView)
        
        // salaryView
        SupportingMethods.shared.addSubviews([
            self.salaryImageView,
            self.salaryLabel,
            self.salaryButton
        ], to: self.salaryView)
        
        // pathKnowView
        SupportingMethods.shared.addSubviews([
            self.pathKnowLabel,
            self.progressView
        ], to: self.pathKnowView)
        
        // toDoListView
        SupportingMethods.shared.addSubviews([
//            self.toDoLabel,
//            self.noDataStackView
        ], to: self.toDoListView)
        
        SupportingMethods.shared.addSubviews([
            self.cardImageView,
            self.cardNameLabel,
            self.cardPhoneNumberLabel
        ], to: self.cardView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.backgroundView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 16),
            self.nameLabel.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 24)
        ])
        
        // positionLabel
        NSLayoutConstraint.activate([
            self.positionLabel.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 16),
            self.positionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4)
        ])
        
        // profileView
        NSLayoutConstraint.activate([
            self.profileView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -16),
            self.profileView.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 16),
            self.profileView.widthAnchor.constraint(equalToConstant: 60),
            self.profileView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // profileLabel
        NSLayoutConstraint.activate([
            self.profileLabel.centerYAnchor.constraint(equalTo: self.profileView.centerYAnchor),
            self.profileLabel.centerXAnchor.constraint(equalTo: self.profileView.centerXAnchor)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.profileView.bottomAnchor, constant: 28),
            self.collectionView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // salaryView
        NSLayoutConstraint.activate([
            self.salaryView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -16),
            self.salaryView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 10),
            self.salaryView.heightAnchor.constraint(equalTo: self.pathKnowView.heightAnchor)
        ])
        
        // salaryButton
        NSLayoutConstraint.activate([
            self.salaryButton.leadingAnchor.constraint(equalTo: self.salaryView.leadingAnchor),
            self.salaryButton.trailingAnchor.constraint(equalTo: self.salaryView.trailingAnchor),
            self.salaryButton.topAnchor.constraint(equalTo: self.salaryView.topAnchor),
            self.salaryButton.bottomAnchor.constraint(equalTo: self.salaryView.bottomAnchor)
        ])
        
        // salaryLabel
        NSLayoutConstraint.activate([
            self.salaryLabel.centerYAnchor.constraint(equalTo: self.salaryView.centerYAnchor),
            self.salaryLabel.trailingAnchor.constraint(equalTo: self.salaryView.trailingAnchor, constant: -10)
        ])
        
        // salaryImageView
        NSLayoutConstraint.activate([
            self.salaryImageView.leadingAnchor.constraint(equalTo: self.salaryView.leadingAnchor, constant: 10),
            self.salaryImageView.trailingAnchor.constraint(equalTo: self.salaryLabel.leadingAnchor),
            self.salaryImageView.centerYAnchor.constraint(equalTo: self.salaryLabel.centerYAnchor),
            self.salaryImageView.widthAnchor.constraint(equalToConstant: 16),
            self.salaryImageView.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        // pathKnowView
        NSLayoutConstraint.activate([
            self.pathKnowView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 16),
            self.pathKnowView.trailingAnchor.constraint(equalTo: self.salaryButton.leadingAnchor, constant: -8),
            self.pathKnowView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 10),
        ])
        
        // pathKnowLabel
        NSLayoutConstraint.activate([
            self.pathKnowLabel.leadingAnchor.constraint(equalTo: self.pathKnowView.leadingAnchor, constant: 12),
            self.pathKnowLabel.topAnchor.constraint(equalTo: self.pathKnowView.topAnchor, constant: 12),
        ])
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.pathKnowView.leadingAnchor, constant: 12),
            self.progressView.trailingAnchor.constraint(equalTo: self.pathKnowView.trailingAnchor, constant: -12),
            self.progressView.topAnchor.constraint(equalTo: self.pathKnowLabel.bottomAnchor, constant: 8),
            self.progressView.bottomAnchor.constraint(equalTo: self.pathKnowView.bottomAnchor, constant: -12),
            self.progressView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        // toDoListView
        NSLayoutConstraint.activate([
//            self.toDoListView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 16),
//            self.toDoListView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -16),
//            self.toDoListView.topAnchor.constraint(equalTo: self.pathKnowView.bottomAnchor, constant: 20),
//            self.toDoListView.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -10),
//            self.toDoListView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // cardView
        NSLayoutConstraint.activate([
            self.cardView.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 16),
            self.cardView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: -16),
            self.cardView.topAnchor.constraint(equalTo: self.pathKnowView.bottomAnchor, constant: 20),
            self.cardView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        // cardImageView
        NSLayoutConstraint.activate([
            self.cardImageView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor),
            self.cardImageView.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor),
            self.cardImageView.topAnchor.constraint(equalTo: self.cardView.topAnchor),
            self.cardImageView.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor)
        ])
        
        // cardNameLabel
        NSLayoutConstraint.activate([
            self.cardNameLabel.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -16),
            self.cardNameLabel.topAnchor.constraint(equalTo: self.cardView.topAnchor, constant: 32)
        ])
        
        // cardPhoneNumberLabel
        NSLayoutConstraint.activate([
            self.cardPhoneNumberLabel.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: -16),
            self.cardPhoneNumberLabel.topAnchor.constraint(equalTo: self.cardNameLabel.bottomAnchor, constant: 8)
        ])
        
        // cardShareButton
        NSLayoutConstraint.activate([
            self.cardShareButton.centerXAnchor.constraint(equalTo: self.cardView.centerXAnchor),
            self.cardShareButton.topAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: 10),
            self.cardShareButton.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: -10),
            self.cardShareButton.heightAnchor.constraint(equalToConstant: 36),
            self.cardShareButton.widthAnchor.constraint(equalToConstant: 73),
        ])
        
        // toDoLabel
        NSLayoutConstraint.activate([
//            self.toDoLabel.leadingAnchor.constraint(equalTo: self.toDoListView.leadingAnchor, constant: 12),
//            self.toDoLabel.topAnchor.constraint(equalTo: self.toDoListView.topAnchor, constant: 12)
        ])
        
        // noDataStackView
        NSLayoutConstraint.activate([
//            self.noDataStackView.centerXAnchor.constraint(equalTo: self.toDoListView.centerXAnchor),
//            self.noDataStackView.centerYAnchor.constraint(equalTo: self.toDoListView.centerYAnchor)
        ])
        
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setUpNavigationTitle() -> UIImageView {
        let navigationTitleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 32))
        navigationTitleImageView.image = UIImage(named: "NavigationTitleImage")
        navigationTitleImageView.contentMode = .scaleAspectFit
        
        return navigationTitleImageView
    }
    
    private func setUpNavigationItem() {
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
    }
}

// MARK: - Extension for methods added
extension RenewalProfileViewController {
    func loadDispatchGroupListRequest(success: (([DispatchSearchItemGroupList]) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDispatchGroupListRequest { groupList in
            success?(groupList)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
        
    }
    
    func loadSalaryStatementRequest(success: ((String) -> ())?, failure: ((String) -> ())?) {
        let beforeDate = SupportingMethods.shared.calculateDate(byValue: -1, component: .month, date: Date())
        self.profileModel.loadSalaryStatementRequest(date: beforeDate) { html in
            success?(html)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension RenewalProfileViewController {
    @objc func tappedSalaryButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadSalaryStatementRequest { html in
            let vc = ProfileSalaryStatementViewController(html: html)
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("didSelectItemAt loadSalaryStatementRequest API Error: \(errorMessage)")
            
        }
    }
    
    @objc func tappedCardShareButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        guard let image = self.cardView.transfromToImage() else {
            SupportingMethods.shared.turnCoverView(.off)
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        vc.excludedActivityTypes = [.saveToCameraRoll]
        self.present(vc, animated: true) {
            SupportingMethods.shared.turnCoverView(.off)
        }
    }
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension RenewalProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let profile = self.profileList[indexPath.row]
        
        cell.setCell(profile: profile)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = self.profileList[indexPath.row]
        
        switch profile {
        case .driveWay:
            // Search
            SupportingMethods.shared.turnCoverView(.on)
            self.loadDispatchGroupListRequest { groupList in
                let vc = DispatchSearchViewController(groupList: groupList)
                
                self.navigationController?.pushViewController(vc, animated: true)
                SupportingMethods.shared.turnCoverView(.off)
                
            } failure: { errorMessage in
                SupportingMethods.shared.turnCoverView(.off)
                print("rightBarButtonItem loadDispatchGroupListRequest API Error: \(errorMessage)")
                
            }
            
        case .myInfo:
            break

            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}
