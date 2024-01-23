//
//  DispatchDrivingDetailPathTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 1/10/24.
//

import UIKit

class Station: Codable {
    let pathName: String
    var count = 0
    
    init(pathName: String, count: Int = 0) {
        self.pathName = pathName
        self.count = count
    }
}

final class DispatchDrivingDetailPathTableViewCell: UITableViewCell {
    
    lazy var stationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "정류장"
        label.textColor = .black 
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DetailPathTableViewCell.self, forCellReuseIdentifier: "DetailPathTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var stationList: [Station] = []
    var count: Int = 0
    
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
extension DispatchDrivingDetailPathTableViewCell {
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
            self.stationTitleLabel,
            self.tableView
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // stationTitleLabel
        NSLayoutConstraint.activate([
            self.stationTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.stationTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.stationTitleLabel.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.tableView.heightAnchor.constraint(equalToConstant: 380)
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchDrivingDetailPathTableViewCell {
    func setCell(station: String) {
        if let stations = UserDefaults.standard.object(forKey: "SaveDrivingInfo") as? Data {
            let decoder: JSONDecoder = JSONDecoder()
            if let stationList = try? decoder.decode([Station].self, from: stations) {
                self.stationList = stationList
            }
            
            for station in self.stationList {
                self.count += station.count
                
            }
            
            self.tableView.reloadData()
            
            NotificationCenter.default.post(name: Notification.Name("PeopleCount"), object: nil, userInfo: ["count": self.count])
            
        } else {
            let stationList = station.split(separator: "-")
            
            for station in stationList {
                self.stationList.append(Station(pathName: String(station), count: 0))
            }
            
            self.tableView.reloadData()
            
        }
        
    }
}

// MARK: - Extension for selector added
extension DispatchDrivingDetailPathTableViewCell {
    @objc func tappedMinusButton(_ sender: UIButton) {
        if self.stationList[sender.tag].count != 0 {
            self.stationList[sender.tag].count -= 1
            self.count -= 1
            
            self.tableView.reloadData()
            
            
            NotificationCenter.default.post(name: Notification.Name("PeopleCount"), object: nil, userInfo: ["count": self.count])
            
            let encoder: JSONEncoder = JSONEncoder()
            if let drivingInfo = try? encoder.encode(self.stationList) {
                UserDefaults.standard.set(drivingInfo, forKey: "SaveDrivingInfo")
                
            }
            
//            UserDefaults.standard.set(self.stationList, forKey: "SaveDrivingInfo")
        }
    }

    @objc func tappedPlusButton(_ sender: UIButton) {
        self.stationList[sender.tag].count += 1
        self.count += 1
        
        self.tableView.reloadData()
        
        NotificationCenter.default.post(name: Notification.Name("PeopleCount"), object: nil, userInfo: ["count": self.count])
        
        let encoder: JSONEncoder = JSONEncoder()
        if let drivingInfo = try? encoder.encode(self.stationList) {
            UserDefaults.standard.set(drivingInfo, forKey: "SaveDrivingInfo")
            
        }
        
    }

}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchDrivingDetailPathTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPathTableViewCell", for: indexPath) as! DetailPathTableViewCell
        let path = self.stationList[indexPath.row]
        
        cell.setCell(station: path, index: indexPath.row)
        cell.minusButton.addTarget(self, action: #selector(tappedMinusButton(_:)), for: .touchUpInside)
        cell.plusButton.addTarget(self, action: #selector(tappedPlusButton(_:)), for: .touchUpInside)
        
        return cell
    }
}
