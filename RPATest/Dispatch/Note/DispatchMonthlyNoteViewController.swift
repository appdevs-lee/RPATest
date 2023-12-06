//
//  DispatchMonthlyNoteViewController.swift
//  RPATest
//
//  Created by 이주성 on 12/3/23.
//

import UIKit
import FSCalendar

final class DispatchMonthlyNoteViewController: UIViewController {
    
    /* FSCalendar 사용법 URL
     https://jiseok-zip.tistory.com/entry/iOSFSCalendar-%EC%82%AC%EC%9A%A9-%ED%9B%84%EA%B8%B0-%EC%82%AC%EC%9A%A9%EB%B2%95
     */
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
    
    let dispatchModel = DispatchModel()
    var eventsArray: [String] = []
    var item: DispatchMonthlyItem?
    
    init(item: DispatchMonthlyItem? = nil) {
        self.item = item
        
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
extension DispatchMonthlyNoteViewController: EssentialViewMethods {
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
        self.view.addSubview(self.calendar)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // calendar
        NSLayoutConstraint.activate([
            self.calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.calendar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.calendar.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension DispatchMonthlyNoteViewController {
    func loadMonthlyDispatchRequest(month: String, success: ((DispatchMonthlyItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadMonthlyDispatchRequest(month: month) { monthlyItem in
            success?(monthlyItem)
            
        } dispatchFailure: { reason in
            if reason == 1 {
                print("날짜가 틀림")
            }
            SupportingMethods.shared.turnCoverView(.off)
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension DispatchMonthlyNoteViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension for FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance
extension DispatchMonthlyNoteViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UIScrollViewDelegate {
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentMonth = SupportingMethods.shared.convertDate(intoString: calendar.currentPage, "yyyy-MM")

        self.eventsArray = []
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadMonthlyDispatchRequest(month: currentMonth) { item in
            self.item = item
            
            for index in 0..<item.attendance.count {
                if item.attendance[index] != 0 {
                    let date: String = index < 9 ? currentMonth + "-0\(index + 1)" : currentMonth + "-\(index + 1)"
                    self.eventsArray.append(date)
                }
            }
            
            SupportingMethods.shared.turnCoverView(.off)
            
            DispatchQueue.main.async {
                self.calendar.reloadData()
            }
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("calendarCurrentPageDidChange loadMonthlyDispatchRequest API Error: \(errorMessage)")
            
        }
    }
    
    // 날짜 밑 문자열 표시
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        var subTitle: String?
        let index = Int(SupportingMethods.shared.convertDate(intoString: date, "dd"))! - 1
        
        if self.eventsArray.contains(SupportingMethods.shared.convertDate(intoString: date)) {
            subTitle = "출\(self.item?.attendance[index] ?? 0)퇴\(self.item?.leaveWork[index] ?? 0)일\(self.item?.order[index] ?? 0)"
        }
        
        return subTitle
        
    }
    
    // 날짜 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectedDate = SupportingMethods.shared.convertDate(intoString: date)
        if self.eventsArray.contains(selectedDate) {
            // FIXME: 해당 부분에 해당 날짜 운행리스트(운행일보) 페이지로 넘어가는 코드 넣기
        }
    }
}
