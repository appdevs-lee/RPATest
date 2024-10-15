//
//  RenewalDispatchMonthlyViewController.swift
//  RPATest
//
//  Created by Awesomepia on 10/2/24.
//

import UIKit
import FSCalendar

final class RenewalDispatchMonthlyViewController: UIViewController {
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.backgroundColor = .white
        calendar.scope = .week
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        calendar.layer.cornerRadius = 15
        calendar.appearance.titleFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.weekdayFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.headerTitleFont = .useFont(ofSize: 16, weight: .Bold)
        
        calendar.select(Date())
        
        // 날짜 선택 색상 설정
        calendar.appearance.selectionColor = .useRGB(red: 176, green: 0, blue: 32)
        
        // 오늘 날짜 설정
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.todayColor = .clear
        calendar.appearance.todaySelectionColor = .none
        
        // 헤더의 날짜 포맷 설정
        calendar.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendar.appearance.headerTitleColor = .useRGB(red: 66, green: 66, blue: 66)
        
        // 요일 색상 설정
        calendar.appearance.weekdayTextColor = .black
        
        // 주말 색깔 설정
        calendar.appearance.titleWeekendColor = .black
        
        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar.appearance.headerTitleAlignment = .center
        
        // 헤더 높이 설정
        calendar.headerHeight = 60

        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var changeScopeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var changeScopeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(changeScopeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var changeScopeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("calendar.down")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(DispatchDocumentKindCollectionViewCell.self, forCellWithReuseIdentifier: "DispatchDocumentKindCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var calendarHeightAnchorLayoutConstraint: NSLayoutConstraint!
    var eventsArray: [String] = []
    var categoryList: [String] = ["지정된 배차"]
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
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- RenewalDispatchMonthlyViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalDispatchMonthlyViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        let scopeUpGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(changeCalendarScope(_:)))
        scopeUpGesture.direction = .up
        self.calendar.addGestureRecognizer(scopeUpGesture)
        
        let scopeDownGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(changeCalendarScope(_:)))
        scopeDownGesture.direction = .down
        self.calendar.addGestureRecognizer(scopeDownGesture)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.calendar,
            self.separateView,
            self.changeScopeView,
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.changeScopeImageView,
            self.changeScopeButton,
        ], to: self.changeScopeView)
        
        SupportingMethods.shared.addSubviews([
            self.collectionView,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // calendar
        self.calendarHeightAnchorLayoutConstraint = self.calendar.heightAnchor.constraint(equalToConstant: 400)
        NSLayoutConstraint.activate([
            self.calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.calendar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            self.calendarHeightAnchorLayoutConstraint,
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.topAnchor.constraint(equalTo: self.calendar.bottomAnchor),
            self.separateView.leadingAnchor.constraint(equalTo: self.calendar.leadingAnchor, constant: 16),
            self.separateView.trailingAnchor.constraint(equalTo: self.calendar.trailingAnchor, constant: -16),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // changeScopeView
        NSLayoutConstraint.activate([
            self.changeScopeView.leadingAnchor.constraint(equalTo: self.calendar.leadingAnchor),
            self.changeScopeView.trailingAnchor.constraint(equalTo: self.calendar.trailingAnchor),
            self.changeScopeView.topAnchor.constraint(equalTo: self.separateView.bottomAnchor),
        ])
        
        // changeScopeImageView
        NSLayoutConstraint.activate([
            self.changeScopeImageView.topAnchor.constraint(equalTo: self.changeScopeView.topAnchor, constant: 10),
            self.changeScopeImageView.bottomAnchor.constraint(equalTo: self.changeScopeView.bottomAnchor, constant: -10),
            self.changeScopeImageView.centerXAnchor.constraint(equalTo: self.changeScopeView.centerXAnchor),
            self.changeScopeImageView.heightAnchor.constraint(equalToConstant: 16),
            self.changeScopeImageView.widthAnchor.constraint(equalToConstant: 16),
        ])
        
        // changeScopeButton
        NSLayoutConstraint.activate([
            self.changeScopeButton.leadingAnchor.constraint(equalTo: self.changeScopeView.leadingAnchor),
            self.changeScopeButton.trailingAnchor.constraint(equalTo: self.changeScopeView.trailingAnchor),
            self.changeScopeButton.topAnchor.constraint(equalTo: self.changeScopeView.topAnchor),
            self.changeScopeButton.bottomAnchor.constraint(equalTo: self.changeScopeView.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.changeScopeView.bottomAnchor, constant: 10),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10),
            self.collectionView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        
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
        
        self.navigationItem.title = "배차 달력"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension RenewalDispatchMonthlyViewController {
    
}

// MARK: - Extension for selector methods
extension RenewalDispatchMonthlyViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func changeCalendarScope(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            self.calendar.setScope(.week, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.down")
            
        } else if gesture.direction == .down {
            self.calendar.setScope(.month, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.up")
            
        }
        
    }
    
    @objc func changeScopeButton(_ sender: UIButton) {
        if self.calendar.scope == .week {
            self.calendar.setScope(.month, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.up")
            
        } else {
            self.calendar.setScope(.week, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.down")
            
        }
        
    }
    
}

// MARK: - Extension for FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance
extension RenewalDispatchMonthlyViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UIScrollViewDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        UIView.transition(with: self.calendar, duration: 1.5) {
            self.calendarHeightAnchorLayoutConstraint.constant = bounds.height
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        var subTitle: String?
        let index = Int(SupportingMethods.shared.convertDate(intoString: date, "dd"))! - 1
        
        if self.eventsArray.contains(SupportingMethods.shared.convertDate(intoString: date)) {
            
        }
        
        return subTitle
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension RenewalDispatchMonthlyViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DispatchDocumentKindCollectionViewCell", for: indexPath) as! DispatchDocumentKindCollectionViewCell
        let category = self.categoryList[indexPath.row]
        
        cell.setCell(category: category)
        
        cell.categoryLabel.textColor = self.selectedIndex == indexPath.row ? .useRGB(red: 35, green: 35, blue: 35) : .useRGB(red: 151, green: 151, blue: 151)
        cell.bottomView.isHidden = self.selectedIndex == indexPath.row ? false : true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        self.collectionView.reloadData()
        
    }
    
}
