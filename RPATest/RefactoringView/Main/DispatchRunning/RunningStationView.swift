//
//  RunningStationView.swift
//  RPATest
//
//  Created by Awesomepia on 10/15/24.
//

import UIKit

class DispatchStation {
    var station: String = ""
    var number: Int = 0
}

class RunningStationView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RunningStationTableViewCell.self, forCellReuseIdentifier: "RunningStationTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var stationList: [DispatchStation] = []
    var tableViewHeightAnchorLayoutConstraint: NSLayoutConstraint!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RunningStationView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
        ], to: self)
    }
    
    func setLayouts() {
        // tableView
        self.tableViewHeightAnchorLayoutConstraint = self.tableView.heightAnchor.constraint(equalToConstant: 110)
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.tableViewHeightAnchorLayoutConstraint,
        ])
    }
}

// MARK: - Extension for methods added
extension RunningStationView {
    func reloadData(item: DailyDispatchDetailItem) {
        let routeList = item.detailedRoute!.split(separator: "-")
        for station in routeList {
            let dispatchStation = DispatchStation()
            dispatchStation.station = String(station)
            
            self.stationList.append(dispatchStation)
            
        }
        print(self.stationList)
        self.tableViewHeightAnchorLayoutConstraint.constant = CGFloat(self.stationList.count * 100)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
    
    func calculatePeopleCount() {
        var sum: Int = 0
        for station in self.stationList {
            sum += station.number
            
        }
        
        print("합계: \(sum)")
        
    }
    
}

// MARK: - Extension for selector added
extension RunningStationView {
    
}

// MARK: - Extension for selector added
extension RunningStationView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RunningStationTableViewCell", for: indexPath) as! RunningStationTableViewCell
        let station = self.stationList[indexPath.row]
        
        cell.setCell(station: station)
        
        return cell
    }
}
