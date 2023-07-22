//
//  HomeViewController.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/04.
//

import UIKit
import Alamofire
import FSCalendar

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 타이틀 설정
        
        
        // 로그아웃 설정
        
        
        // Label Setting
        setUpLabel()
        
        // TableView Setting
        setUpTableView()
    }
    
    private func setUpLabel() {
        self.titleLabel.text = "\(UserInfo.getName())기사님의 \(Date()) 배차"
    }
    
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
