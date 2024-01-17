//
//  OfficeViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/09/03.
//

import UIKit

enum Office: String {
    case notice = "OfficeNotice"
    case vehicle = "OfficeVehicle"
    case consulting = "OfficeConsulting"
    case csEdu = "OfficeEdu"
    case accident = "OfficeAccident"
    case fuel = "OfficeFuel"
    case estimate = "OfficeEstimate"
    case dispatchTeam = "OfficeDispatchTeam"
    case rules = "OfficeRules"
    
    var labelName: String {
        switch self {
        case .notice:
            return "공지사항"
        case .vehicle:
            return "차량관리"
        case .consulting:
            return "민원"
        case .csEdu:
            return "CS교육"
        case .accident:
            return "사고대처"
        case .fuel:
            return "주유"
        case .estimate:
            return "견적"
        case .dispatchTeam:
            return "팀원 배차"
        case .rules:
            return "취업규칙"
        }
    }
}

final class OfficeViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 50
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(OfficeCollectionViewCell.self, forCellWithReuseIdentifier: "OfficeCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    let officeList: [Office] = [.notice, .vehicle, .consulting, .csEdu, .accident, .fuel, .estimate, .dispatchTeam, .rules]
    
    let noticeModel = NoticeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Pop Slide
        if self.navigationController?.viewControllers.first === self  {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
        
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
extension OfficeViewController: EssentialViewMethods {
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
        self.view.addSubview(self.collectionView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            self.collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
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
extension OfficeViewController {
    
}

// MARK: - Extension for selector methods
extension OfficeViewController {
    
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension OfficeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.officeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfficeCollectionViewCell", for: indexPath) as! OfficeCollectionViewCell
        let office = self.officeList[indexPath.row]
        cell.setCell(office: office)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let office = self.officeList[indexPath.row]
        
        switch office {
        case .notice:
            // Notice
            let vc = NoticeViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .vehicle:
            // Vehicle
            let vc = InspectionViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .consulting:
            // Consulting
            let vc = ConsultingViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .dispatchTeam:
            // 배차표
            let vc = DispatchScheduleViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .fuel:
            // 주유
            let vc = DispatchRefuelingBottomSheetViewController()
            
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
            
        case .accident:
            let vc = AlertPopViewController(.normalOneButton(messageTitle: "승객 명단 작성 및 안전 유무 확인", messageContent: "승객의 안전을 우선으로 확인해주시고, 명단 작성을 해주세요.", buttonTitle: "관리자에게 전화하기", action: {
                
                if let url = URL(string: "tel://010-1234-1234") {
                    UIApplication.shared.open(url)
                    
                    let vc = AccidentPhotoViewController()
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }))
            
            self.present(vc, animated: true)
        default:
            break
        }
    }
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension OfficeViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
}
