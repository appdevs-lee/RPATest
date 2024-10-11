//
//  RunningMapTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 10/8/24.
//

import UIKit
import MapKit

final class RunningMapTableViewCell: UITableViewCell {
    
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
    
    lazy var kakaoMapButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("KakaoMapLogo"), for: .normal)
        button.setImage(.useCustomImage("SelectedKakaoMapLogo"), for: .highlighted)
        button.addTarget(self, action: #selector(kakaoMapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let mapModel = MapModel()
    var item: DailyDispatchDetailItem?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setCellFoundation()
        self.initializeViews()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// MARK: Extension for essential methods
extension RunningMapTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
    }
    
    // Initialize views
    func initializeViews() {
        
    }
    
    // Set gestures
    func setGestures() {
        
    }
    
    // Set notificationCenters
    func setNotificationCenters() {
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.mapView,
            self.kakaoMapButton,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.mapView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width),
            self.mapView.widthAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width),
        ])
        
        // kakaoMapButton
        NSLayoutConstraint.activate([
            self.kakaoMapButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.kakaoMapButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.kakaoMapButton.heightAnchor.constraint(equalToConstant: 40),
            self.kakaoMapButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: - Extension for methods added
extension RunningMapTableViewCell {
    func setCell(item: DailyDispatchDetailItem) {
        self.item = item
        
        guard let _ = item.maplink else {
            self.kakaoMapButton.isHidden = true
            return
        }
        self.kakaoMapButton.isHidden = false
        
    }
    
}

// MARK: - Extension for selector added
extension RunningMapTableViewCell {
    @objc func kakaoMapButton(_ sender: UIButton) {
        guard let mapLink = self.item?.maplink else { return }
        guard let url = URL(string: mapLink) else { return }
        
        UIApplication.shared.open(url)
    }
}

// MARK: - Extension for MKMapViewDelegate
extension RunningMapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        
        return renderer
    }
}
