//
//  ProfileMyInfoViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2/1/24.
//

import UIKit

enum SelectMyInfoTab: Int {
    case card
    case drivingAnalysis
    case jobEvaluation
    case salary
    
}

final class ProfileMyInfoViewController: UIViewController {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var partTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "소속"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var partLabel: UILabel = {
        let label = UILabel()
        label.text = "소속입니다."
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = UserInfo.shared.name ?? ""
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var birthdayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "2024.02.01"
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var workTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "업무 / 직책"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var workLabel: UILabel = {
        let label = UILabel()
        label.text = "기사 / 팀장"
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(ProfileMyInfoViewPagerCollectionViewCell.self, forCellWithReuseIdentifier: "ProfileMyInfoViewPagerCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    lazy var pageViewController: UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.didMove(toParent: self)
        
        let cardVC = CardViewController()
        cardVC.title = "명함"
        
        let drivingAnalysisVC = DrivingAnalysisViewController()
        drivingAnalysisVC.title = "운행 분석"
        
        let jobEvaluationVC = JobEvaluationViewController()
        jobEvaluationVC.title = "직무 평가"
        
        let fourthVC = UIViewController()
        fourthVC.title = "급여"
        
        self.subControllers = [cardVC, drivingAnalysisVC, jobEvaluationVC, fourthVC]
        return pageVC
    }()
    
    var subControllers: [UIViewController] = []
    var currentIndex: Int = 0
    
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
        self.setPageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    deinit {
        print("----------------------------------- ProfileMyInfoViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ProfileMyInfoViewController: EssentialViewMethods {
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
            self.profileImageView,
            self.partTitleLabel,
            self.partLabel,
            self.nameTitleLabel,
            self.nameLabel,
            self.birthdayTitleLabel,
            self.birthdayLabel,
            self.workTitleLabel,
            self.workLabel
        ], to: self.view)
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.contentView)
        addChild(self.pageViewController)
        self.contentView.addSubview(self.pageViewController.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // profileImageView
        NSLayoutConstraint.activate([
            self.profileImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.profileImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 100),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        // partTitleLabel
        NSLayoutConstraint.activate([
            self.partTitleLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 20),
            self.partTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.partTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // partLabel
        NSLayoutConstraint.activate([
            self.partLabel.leadingAnchor.constraint(equalTo: self.partTitleLabel.trailingAnchor, constant: 10),
            self.partLabel.centerYAnchor.constraint(equalTo: self.partTitleLabel.centerYAnchor),
            self.partLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // nameTitleLabel
        NSLayoutConstraint.activate([
            self.nameTitleLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 20),
            self.nameTitleLabel.topAnchor.constraint(equalTo: self.partTitleLabel.bottomAnchor, constant: 10),
            self.nameTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.nameTitleLabel.trailingAnchor, constant: 10),
            self.nameLabel.centerYAnchor.constraint(equalTo: self.nameTitleLabel.centerYAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // birthdayTitleLabel
        NSLayoutConstraint.activate([
            self.birthdayTitleLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 20),
            self.birthdayTitleLabel.topAnchor.constraint(equalTo: self.nameTitleLabel.bottomAnchor, constant: 10),
            self.birthdayTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // birthdayLabel
        NSLayoutConstraint.activate([
            self.birthdayLabel.leadingAnchor.constraint(equalTo: self.birthdayTitleLabel.trailingAnchor, constant: 10),
            self.birthdayLabel.centerYAnchor.constraint(equalTo: self.birthdayTitleLabel.centerYAnchor),
            self.birthdayLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // workTitleLabel
        NSLayoutConstraint.activate([
            self.workTitleLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 20),
            self.workTitleLabel.topAnchor.constraint(equalTo: self.birthdayTitleLabel.bottomAnchor, constant: 10),
            self.workTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // workLabel
        NSLayoutConstraint.activate([
            self.workLabel.leadingAnchor.constraint(equalTo: self.workTitleLabel.trailingAnchor, constant: 10),
            self.workLabel.centerYAnchor.constraint(equalTo: self.workTitleLabel.centerYAnchor),
            self.workLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 24),
            self.collectionView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // contentView
        NSLayoutConstraint.activate([
            self.contentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // pageViewController.view
        NSLayoutConstraint.activate([
            self.pageViewController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.pageViewController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.pageViewController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setPageViewController() {
        self.pageViewController.setViewControllers([self.subControllers[self.currentIndex]], direction: .forward, animated: true)
    }
    
}

// MARK: - Extension for methods added
extension ProfileMyInfoViewController {
    func select(index: SelectMyInfoTab) {
        var direction: UIPageViewController.NavigationDirection = .forward
        if index.rawValue > self.currentIndex {
            direction = .forward
            
        } else {
            direction = .reverse
            
        }
        
        self.currentIndex = index.rawValue
        self.pageViewController.setViewControllers([self.subControllers[index.rawValue]], direction: direction, animated: false)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
        
    }
}

// MARK: - Extension for selector methods
extension ProfileMyInfoViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
}


// MARK: - Extension for UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension ProfileMyInfoViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.subControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        
        return self.subControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.subControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == self.subControllers.count {
            return nil
        }
        return self.subControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let vc = self.pageViewController.viewControllers?.first else {
                self.currentIndex = 0
                return
            }
            self.currentIndex = self.subControllers.firstIndex(of: vc) ?? 0
            
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension ProfileMyInfoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ReferenceValues.Size.Device.width / CGFloat(self.subControllers.count), height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileMyInfoViewPagerCollectionViewCell", for: indexPath) as! ProfileMyInfoViewPagerCollectionViewCell
        let title = self.subControllers[indexPath.row].title!
        
        cell.newView.isHidden = true
        cell.setCell(title: title)
        
        if indexPath.row == self.currentIndex {
            cell.titleLabel.textColor = .white
            cell.backGroundView.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            
        } else {
            cell.titleLabel.textColor = .useRGB(red: 176, green: 0, blue: 32)
            cell.backGroundView.backgroundColor = .white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var direction: UIPageViewController.NavigationDirection = .forward
        if indexPath.row > self.currentIndex {
            direction = .forward
        } else {
            direction = .reverse
        }
        
        self.currentIndex = indexPath.row
        self.pageViewController.setViewControllers([self.subControllers[indexPath.row]], direction: direction, animated: true)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            
        }
        
    }
    
}
