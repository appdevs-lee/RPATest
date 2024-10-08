//
//  DriverView.swift
//  RPATest
//
//  Created by 이주성 on 10/5/24.
//

import UIKit

class DriverView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DriverTableViewCell.self, forCellReuseIdentifier: "DriverTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var noDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noDataImageView, self.noDataLabel])
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("NoDataImage")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘은 운행이 없습니다.\n편안한 휴일 되세요!"
        label.textColor = .useRGB(red: 168, green: 168, blue: 168)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dispatchModel = NewDispatchModel()
    var itemList: [DailyDispatchDetailItem] = []
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.initalizeView()
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DriverView {
    func initalizeView() {
        self.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        
    }
    
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
            self.noDataStackView,
        ], to: self)
    }
    
    func setLayouts() {
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
        
        // noDataStackView
        NSLayoutConstraint.activate([
            self.noDataStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.noDataStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.noDataStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        // noDataImageView
        NSLayoutConstraint.activate([
            self.noDataImageView.widthAnchor.constraint(equalToConstant: 80),
            self.noDataImageView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
}

// MARK: - Extension for methods added
extension DriverView {
    func reloadData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyDispatchRequest { item in
            self.itemList = item.regularly + item.order
            
            if self.itemList.isEmpty {
                self.noDataStackView.isHidden = false
                
            } else {
                self.noDataStackView.isHidden = true
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
        
    }
    
    func loadDailyDispatchRequest(success: ((DailyDispatchItem) -> ())?) {
        self.dispatchModel.loadDailyDispatchRequest(date: SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd")) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.turnCoverView(.off)
            print("loadDailyDispatchRequest API Error: \(message)")
            
        }

    }
    
}

// MARK: - Extension for selector added
extension DriverView {
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DriverView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverTableViewCell", for: indexPath) as! DriverTableViewCell
        let item = self.itemList[indexPath.row]
        
        cell.setCell(item: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.itemList[indexPath.row]
        
        NotificationCenter.default.post(name: Notification.Name("RunningStart"), object: nil, userInfo: ["item": item])
    }
    
}
