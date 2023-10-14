//
//  ProfileViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/03.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.positionLabel, self.teamLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 24, weight: .Medium)
        label.text = UserInfo.shared.name
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.text = "position"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.text = "team"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var profileView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var profileLabel: UIView = {
        let firstWordinName = UserInfo.shared.name == "" ? "" : String((UserInfo.shared.name?.first)!)
        let label = UILabel()
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.text = firstWordinName
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var separateLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    let imageString: [String] = ["MyInfo","ToDo","DriveRecord","PhoneBook","DriveWay","Alert","DriveGoal"]
    let menuString: [String] = ["내 정보", "할 일", "운행기록", "주소록", "노선숙지", "알림", "목표운행량"]
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
            print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ProfileViewController: EssentialViewMethods {
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
        self.view.addSubview(self.profileInfoStackView)
        self.view.addSubview(self.separateLineView)
        self.view.addSubview(self.profileView)
        self.view.addSubview(self.collectionView)
        
        self.profileView.addSubview(self.profileLabel)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // profileInfoStackView
        NSLayoutConstraint.activate([
            self.profileInfoStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            self.profileInfoStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24)
        ])
        
        // profileView
        NSLayoutConstraint.activate([
            self.profileView.widthAnchor.constraint(equalToConstant: 50),
            self.profileView.heightAnchor.constraint(equalToConstant: 50),
            self.profileView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            self.profileView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16)
        ])
        
        // profileLabel
        NSLayoutConstraint.activate([
            self.profileLabel.centerYAnchor.constraint(equalTo: self.profileView.centerYAnchor),
            self.profileLabel.centerXAnchor.constraint(equalTo: self.profileView.centerXAnchor)
            
        ])
        
        // separateLineView
        NSLayoutConstraint.activate([
            self.separateLineView.heightAnchor.constraint(equalToConstant: 2),
            self.separateLineView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            self.separateLineView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            self.separateLineView.topAnchor.constraint(equalTo: self.profileInfoStackView.bottomAnchor, constant: 24)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.separateLineView.bottomAnchor, constant: 24),
            self.collectionView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
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
extension ProfileViewController {
    func loadDispatchGroupListRequest(success: (([DispatchSearchItemGroupList]) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadDispatchGroupListRequest { groupList in
            success?(groupList)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }
        
    }
    
}

// MARK: - Extension for selector methods
extension ProfileViewController {
    
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.setCell(imageString: self.imageString[indexPath.row], menuString: self.menuString[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
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
