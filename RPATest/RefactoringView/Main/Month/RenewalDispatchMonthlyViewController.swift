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
        calendar.scope = .month
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        calendar.appearance.titleFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.weekdayFont = .useFont(ofSize: 14, weight: .Medium)
        calendar.appearance.headerTitleFont = .useFont(ofSize: 16, weight: .Bold)
        
        // 헤더의 날짜 포맷 설정
        calendar.appearance.headerDateFormat = "YYYY년 MM월"

        // 헤더의 폰트 색상 설정
        calendar.appearance.headerTitleColor = .useRGB(red: 66, green: 66, blue: 66)
        
        // 주말 색깔 설정
        calendar.appearance.titleWeekendColor = .useRGB(red: 176, green: 0, blue: 32)
        
        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar.appearance.headerTitleAlignment = .center
        
        // 헤더 높이 설정
        calendar.headerHeight = 45

        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var calendarHeightAnchorLayoutConstraint: NSLayoutConstraint!
    var eventsArray: [String] = []
    
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
            self.baseView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // calendar
        self.calendarHeightAnchorLayoutConstraint = self.calendar.heightAnchor.constraint(equalToConstant: 400)
        NSLayoutConstraint.activate([
            self.calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.calendar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.calendarHeightAnchorLayoutConstraint,
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.calendar.bottomAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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
            calendar.setScope(.week, animated: true)
            
        } else if gesture.direction == .down {
            calendar.setScope(.month, animated: true)
            
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
