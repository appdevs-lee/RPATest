//
//  DispatchDrivingPathViewController.swift
//  RPATest
//
//  Created by Awesomepia on 2/14/24.
//

import UIKit
import MapKit

final class DispatchDrivingPathViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        if #available(iOS 16.0, *) {
            mapView.preferredConfiguration = MKStandardMapConfiguration()
        } else {
            mapView.mapType = .standard
        }
        mapView.setUserTrackingMode(.follow, animated: true)
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    let mapModel = MapModel()
    let stations: [StationMarker] = [
        StationMarker(title: "경기 수원시 장안구 율전동 435", coordinate: CLLocationCoordinate2D(latitude: 37.2953298, longitude: 126.9702277), subtitle: "성균관대 h1"),
        StationMarker(title: "경기 수원시 권선구 구운동 547", coordinate: CLLocationCoordinate2D(latitude: 37.2794689, longitude: 126.9760851), subtitle: "성균관대 h1"),
        StationMarker(title: "경기 수원시 권선구 서둔동 23-21", coordinate: CLLocationCoordinate2D(latitude: 37.265278, longitude: 126.9938482), subtitle: "성균관대 h1"),
        StationMarker(title: "김남완 초밥집", coordinate: CLLocationCoordinate2D(latitude: 37.49843, longitude: 127.0350), subtitle: "목요일 정기 회의 식사 장소"),
        
        /*
         경기 수원시 장안구 율전동 435 : 위도(Latitude) : 37.2953298 / 경도(Longitude) : 126.9702277
         경기 수원시 권선구 구운동 547 : 위도(Latitude) : 37.2794689 / 경도(Longitude) : 126.9760851
         경기 수원시 권선구 서둔동 23-21 : 위도(Latitude) : 37.265278 / 경도(Longitude) : 126.9938482
         
         */
    ]
    
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
        self.drawLineOnMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- DispatchDrivingPathViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchDrivingPathViewController: EssentialViewMethods {
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
        self.view.addSubview(self.mapView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
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
        
        self.navigationItem.title = "운행 경로"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension DispatchDrivingPathViewController {
    func drawLineOnMap() {
        var points: [CLLocationCoordinate2D] = []
        let locations = self.mapModel.read()
        
        for location in locations {
            print("latitude: \(location.latitude)\nlongitude: \(location.longitude)")
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
            
            points.append(point)
        }
        
        let lineDraw = MKPolyline(coordinates: points, count:points.count)
        self.mapView.addOverlay(lineDraw)
        
        for station in self.stations {
            self.mapView.addAnnotation(station)
            
        }
        
    }
}

// MARK: - Extension for selector methods
extension DispatchDrivingPathViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        self.mapModel.deleteAll()
    }
}

// MARK: - Extension for MKMapViewDelegate
extension DispatchDrivingPathViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        
        return renderer
    }
}
