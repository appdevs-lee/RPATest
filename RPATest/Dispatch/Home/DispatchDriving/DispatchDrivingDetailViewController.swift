//
//  DispatchDrivingDetailViewController.swift
//  RPATest
//
//  Created by Awesomepia on 1/9/24.
//

import UIKit
import MapKit

final class DispatchDrivingDetailViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        if #available(iOS 16.0, *) {
            mapView.preferredConfiguration = MKStandardMapConfiguration()
        } else {
            mapView.mapType = .standard
        }
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 100, longitudinalMeters: 100), animated: true)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(DispatchDrivingTitleTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingTitleTableViewCell")
        switch self.type {
        case .regularly:
            tableView.register(DispatchDrivingRegularlyTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingRegularlyTableViewCell")
            
        case .order:
            tableView.register(DispatchDrivingOrderTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingOrderTableViewCell")
            
        }
        tableView.register(DispatchDrivingDetailPathTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingDetailPathTableViewCell")
//        tableView.register(DispatchDrivingDoneTableViewCell.self, forCellReuseIdentifier: "DispatchDrivingDoneTableViewCell")
        
        return tableView
    }()
    
    init(type: DispatchKindType, regularlyItem: DispatchRegularlyItem? = nil, orderItem: DispatchOrderItem? = nil) {
        self.type = type
        
        switch type {
        case .regularly:
            self.regularlyItem = regularlyItem
            
        case .order:
            self.orderItem = orderItem
            
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mapModel = MapModel()
    let stations: [StationMarker] = [
//        StationMarker(title: "경기 수원시 장안구 율전동 435", coordinate: CLLocationCoordinate2D(latitude: 37.2953298, longitude: 126.9702277), subtitle: "성균관대 h1"),
//        StationMarker(title: "경기 수원시 권선구 구운동 547", coordinate: CLLocationCoordinate2D(latitude: 37.2794689, longitude: 126.9760851), subtitle: "성균관대 h1"),
//        StationMarker(title: "경기 수원시 권선구 서둔동 23-21", coordinate: CLLocationCoordinate2D(latitude: 37.265278, longitude: 126.9938482), subtitle: "성균관대 h1"),
//        StationMarker(title: "김남완 초밥집", coordinate: CLLocationCoordinate2D(latitude: 37.49843, longitude: 127.0350), subtitle: "목요일 정기 회의 식사 장소"),
        
        /*
         경기 수원시 장안구 율전동 435 : 위도(Latitude) : 37.2953298 / 경도(Longitude) : 126.9702277
         경기 수원시 권선구 구운동 547 : 위도(Latitude) : 37.2794689 / 경도(Longitude) : 126.9760851
         경기 수원시 권선구 서둔동 23-21 : 위도(Latitude) : 37.265278 / 경도(Longitude) : 126.9938482
         
         */
    ]
    
    var type: DispatchKindType
    var regularlyItem: DispatchRegularlyItem?
    var orderItem: DispatchOrderItem?
    var peopleCount: Int = 0
    
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
    
    deinit {
        print("----------------------------------- DispatchDrivingDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchDrivingDetailViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(drivingDone(_:)), name: Notification.Name("NoteWriteCompleted"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setPeopleCount(_:)), name: Notification.Name("PeopleCount"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: Notification.Name("DrivingDetailPathUpdate"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
            self.mapView
        ], to: self.view)
    }

    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.mapView.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.mapView.heightAnchor.constraint(equalToConstant: 300)
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
        
        self.navigationItem.title = "운행중"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        let rightBarButtonItem = UIBarButtonItem(title: "운행 종료", style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        rightBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 16, weight: .Bold),
            .foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189)
        ], for: .disabled)
        rightBarButtonItem.setTitleTextAttributes([
            .foregroundColor:UIColor.useRGB(red: 176, green: 0, blue: 32),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ], for: .normal)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}

// MARK: - Extension for methods added
extension DispatchDrivingDetailViewController {
    func drawLineOnMap() {
//        let locations = self.mapModel.read()
//        let lastIndex = locations.last?.index ?? 0
//        
//        var points: [CLLocationCoordinate2D] = []
//        
//        if lastIndex != 0 {
//            let point1: CLLocationCoordinate2D = CLLocationCoordinate2DMake(locations[lastIndex - 1].latitude, locations[lastIndex - 1].longitude)
//            let point2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(locations[lastIndex].latitude, locations[lastIndex].longitude)
//            
//            points.append(point1)
//            points.append(point2)
//            
//            let lineDraw = MKPolyline(coordinates: points, count:points.count)
//            self.mapView.addOverlay(lineDraw)
//        }
        
//        print("ㅇ★★★★★★★★★★★★★★★★★★★★★경로 그리는 중★★★★★★★★★★★★★★★★★★★★★★★★★ㅇ")
//        print("POINT 1")
//        print("date: \(locations[lastIndex - 1].date)")
//        print("index: \(locations[lastIndex - 1].index)")
//        print("latitude: \(locations[lastIndex - 1].latitude)")
//        print("longitude: \(locations[lastIndex - 1].longitude)")
//        
//        print("POINT 2")
//        print("date: \(locations[lastIndex].date)")
//        print("index: \(locations[lastIndex].index)")
//        print("latitude: \(locations[lastIndex].latitude)")
//        print("longitude: \(locations[lastIndex].longitude)")
//        
//        print("POINTS")
//        print("ㅇ★★★★★★★★★★★★★★★★★★★★★경로 그리는 중★★★★★★★★★★★★★★★★★★★★★★★★★\n")
        
        var points: [CLLocationCoordinate2D] = []
        let locations = self.mapModel.read()
        
        for location in locations {
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            
            points.append(point)
        }
        
        let lineDraw = MKPolyline(coordinates: points, count:points.count)
        self.mapView.addOverlay(lineDraw)

    }
    
}

// MARK: - Extension for selector methods
extension DispatchDrivingDetailViewController {
    @objc func tappedDoneButton(_ sender: UIButton) {
        ReferenceValues.peopleCount = 0
        UserDefaults.standard.set(nil, forKey: "SaveDrivingInfo")
        
        // 운행일보 작성 present
        let vc = DispatchNoteDetailViewController(presentType: .present, type: self.type, id: (regularly: "\(self.regularlyItem?.id ?? 0)", order: ""), date: (departure: self.regularlyItem?.departureDate ?? "", arrival: self.regularlyItem?.arrivalDate ?? ""), count: self.peopleCount)
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        ReferenceValues.peopleCount = 0
        UserDefaults.standard.set(nil, forKey: "SaveDrivingInfo")
        
        // 운행일보 작성 present
        let vc = DispatchNoteDetailViewController(presentType: .present, type: self.type, id: (regularly: "\(self.regularlyItem?.id ?? 0)", order: ""), date: (departure: self.regularlyItem?.departureDate ?? "", arrival: self.regularlyItem?.arrivalDate ?? ""), count: self.peopleCount)
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func drivingDone(_ noti: Notification) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func setPeopleCount(_ noti: Notification) {
        guard let count = noti.userInfo?["count"] as? Int else { return }
        
        self.peopleCount = count
    }
    
    @objc func update(_ noti: Notification) {
        self.drawLineOnMap()
        
        for station in self.stations {
            self.mapView.addAnnotation(station)
            
        }
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchDrivingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingTitleTableViewCell", for: indexPath) as! DispatchDrivingTitleTableViewCell
            
            cell.setCell(route: self.regularlyItem?.route ?? "")
            
            return cell
            
        } else if indexPath.section == 1 {
            switch self.type {
            case .regularly:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingRegularlyTableViewCell", for: indexPath) as! DispatchDrivingRegularlyTableViewCell
                guard let item = self.regularlyItem else { return UITableViewCell() }
                
                cell.setCell(item: item)
                
                return cell
            case .order:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingOrderTableViewCell", for: indexPath) as! DispatchDrivingOrderTableViewCell
                guard let item = self.orderItem else { return UITableViewCell() }
                
                cell.setCell(item: item)
                
                return cell
            }
            
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingDetailPathTableViewCell", for: indexPath) as! DispatchDrivingDetailPathTableViewCell
            var station: String = ""
            
            switch self.type {
            case .regularly:
                station = self.regularlyItem?.detailedRoute ?? ""
                
            case .order:
                station = ""
                
            }
            
            cell.setCell(station: station)
            
            return cell
            
        } 
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDrivingDoneTableViewCell", for: indexPath) as! DispatchDrivingDoneTableViewCell
            
            cell.setCell()
            cell.doneButton.addTarget(self, action: #selector(tappedDoneButton(_:)), for: .touchUpInside)
            
            return cell
            
        }
        
    }
}

// MARK: - Extension for MKMapViewDelegate
extension DispatchDrivingDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        
        return renderer
    }
}
