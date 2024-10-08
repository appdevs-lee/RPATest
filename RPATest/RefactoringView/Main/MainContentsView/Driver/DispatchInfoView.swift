//
//  DispatchInfoView.swift
//  RPATest
//
//  Created by 이주성 on 10/5/24.
//

import UIKit

class DispatchInfoView: UIView {
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .useRGB(red: 111, green: 111, blue: 111)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("timeArrowImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .useRGB(red: 111, green: 111, blue: 111)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 204, green: 204, blue: 204)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var busIdLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .useRGB(red: 111, green: 111, blue: 111)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var kakaoMapButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("KakaoMapLogo"), for: .normal)
        button.setImage(.useCustomImage("SelectedKakaoMapLogo"), for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 111, green: 111, blue: 111)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var connectView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 204, green: 204, blue: 204)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var routeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 168, green: 168, blue: 168)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTitleButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("출발", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.backgroundColor = .useRGB(red: 21, green: 176, blue: 255)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTitleButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("도착", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.backgroundColor = .useRGB(red: 40, green: 104, blue: 255)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DispatchInfoView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.departureTimeLabel,
            self.arrowImageView,
            self.arrivalTimeLabel,
            self.separateView,
            self.busIdLabel,
            self.kakaoMapButton,
            self.groupLabel,
            self.connectView,
            self.routeLabel,
            self.departureTitleButton,
            self.departureLabel,
            self.arrivalTitleButton,
            self.arrivalLabel,
        ], to: self)
    }
    
    func setLayouts() {
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
        
        // arrowImageView
        NSLayoutConstraint.activate([
            self.arrowImageView.leadingAnchor.constraint(equalTo: self.departureTimeLabel.trailingAnchor, constant: 5),
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.departureTimeLabel.centerYAnchor),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 10),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 10),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrowImageView.trailingAnchor, constant: 5),
            self.arrivalTimeLabel.centerYAnchor.constraint(equalTo: self.departureTimeLabel.centerYAnchor),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.arrivalTimeLabel.trailingAnchor, constant: 10),
            self.separateView.centerYAnchor.constraint(equalTo: self.departureTimeLabel.centerYAnchor),
            self.separateView.heightAnchor.constraint(equalToConstant: 10),
            self.separateView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        // busIdLabel
        NSLayoutConstraint.activate([
            self.busIdLabel.leadingAnchor.constraint(equalTo: self.separateView.trailingAnchor, constant: 10),
            self.busIdLabel.centerYAnchor.constraint(equalTo: self.departureTimeLabel.centerYAnchor),
        ])
        
        // kakaoMapButton
        NSLayoutConstraint.activate([
            self.kakaoMapButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.kakaoMapButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
        
        // groupLabel
        NSLayoutConstraint.activate([
            self.groupLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.groupLabel.topAnchor.constraint(equalTo: self.departureTimeLabel.bottomAnchor, constant: 10),
        ])
        
        // connectView
        NSLayoutConstraint.activate([
            self.connectView.leadingAnchor.constraint(equalTo: self.groupLabel.trailingAnchor, constant: 5),
            self.connectView.centerYAnchor.constraint(equalTo: self.groupLabel.centerYAnchor),
            self.connectView.heightAnchor.constraint(equalToConstant: 1),
            self.connectView.widthAnchor.constraint(equalToConstant: 10),
        ])
        
        // routeLabel
        NSLayoutConstraint.activate([
            self.routeLabel.leadingAnchor.constraint(equalTo: self.connectView.trailingAnchor, constant: 5),
            self.routeLabel.centerYAnchor.constraint(equalTo: self.connectView.centerYAnchor),
        ])
        
        // departureTitleButton
        NSLayoutConstraint.activate([
            self.departureTitleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.departureTitleButton.topAnchor.constraint(equalTo: self.groupLabel.bottomAnchor, constant: 10),
            self.departureTitleButton.widthAnchor.constraint(equalToConstant: 36),
            self.departureTitleButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureTitleButton.trailingAnchor, constant: 10),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.departureLabel.centerYAnchor.constraint(equalTo: self.departureTitleButton.centerYAnchor),
        ])
        
        // arrivalTitleButton
        NSLayoutConstraint.activate([
            self.arrivalTitleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.arrivalTitleButton.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 10),
            self.arrivalTitleButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.arrivalTitleButton.widthAnchor.constraint(equalToConstant: 36),
            self.arrivalTitleButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleButton.trailingAnchor, constant: 10),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.arrivalLabel.centerYAnchor.constraint(equalTo: self.arrivalTitleButton.centerYAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchInfoView {
    func reloadData(item: DailyDispatchDetailItem) {
        if let _ = item.checkRegularlyConnect {
            // regularly
            self.groupLabel.isHidden = false
            self.connectView.isHidden = true
            self.routeLabel.isHidden = false
            
            self.groupLabel.text = "\(item.group!)"
            self.routeLabel.text = "\(item.route!)"
            
        } else {
            // order
            self.groupLabel.text = "일반 배차"
            self.connectView.isHidden = true
            self.routeLabel.isHidden = true
            
        }
        
        self.departureLabel.text = item.departure
        self.arrivalLabel.text = item.arrival
        
        let tempDepartureDate = SupportingMethods.shared.convertString(intoDate: item.departureDate, "yyyy-MM-dd HH:mm")
        let tempArrivalDate = SupportingMethods.shared.convertString(intoDate: item.arrivalDate, "yyyy-MM-dd HH:mm")
        
        self.departureTimeLabel.text = SupportingMethods.shared.convertDate(intoString: tempDepartureDate, "MM/dd HH:mm")
        self.arrivalTimeLabel.text = SupportingMethods.shared.convertDate(intoString: tempArrivalDate, "MM/dd HH:mm")
        
        self.departureTimeLabel.asFontColor(targetString: "\(SupportingMethods.shared.convertDate(intoString: tempDepartureDate, "HH:mm"))", font: .useFont(ofSize: 12, weight: .Bold), color: .useRGB(red: 111, green: 111, blue: 111))
        self.arrivalTimeLabel.asFontColor(targetString: "\(SupportingMethods.shared.convertDate(intoString: tempArrivalDate, "HH:mm"))", font: .useFont(ofSize: 12, weight: .Bold), color: .useRGB(red: 111, green: 111, blue: 111))
        
        self.busIdLabel.text = "\(item.busId)"
    }
    
}

// MARK: - Extension for selector added
extension DispatchInfoView {
    
}
