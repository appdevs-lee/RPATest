//
//  OrganizationSearchTableViewCell.swift
//  RPATest
//
//  Created by Awesomepia on 11/16/23.
//
import UIKit

class OrganizationSearchTableViewCell: UITableViewCell {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "TeamImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var profileView: UIView = {
        let view = UIView()
//        view.isHidden = true
        view.backgroundColor = .useRGB(red: 217, green: 217, blue: 217)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.positionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "nextArrowImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
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
extension OrganizationSearchTableViewCell {
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
        self.addSubview(self.profileView)
        self.addSubview(self.profileImageView)
        self.profileView.addSubview(self.profileLabel)
        
        self.addSubview(self.profileStackView)
        self.addSubview(self.arrowImageView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // profileImageView
        NSLayoutConstraint.activate([
            self.profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 50),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // profileView
        NSLayoutConstraint.activate([
            self.profileView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.profileView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.profileView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.profileView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.profileView.widthAnchor.constraint(equalToConstant: 50),
            self.profileView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // profileLabel
        NSLayoutConstraint.activate([
            self.profileLabel.centerYAnchor.constraint(equalTo: self.profileView.centerYAnchor),
            self.profileLabel.centerXAnchor.constraint(equalTo: self.profileView.centerXAnchor)
        ])
        
        // profileStackView
        NSLayoutConstraint.activate([
            self.profileStackView.leadingAnchor.constraint(equalTo: self.profileView.trailingAnchor, constant: 20),
            self.profileStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        // arrowImageView
        NSLayoutConstraint.activate([
            self.arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

// MARK: - Extension for methods added
extension OrganizationSearchTableViewCell {
    func setCell(member: MemberDetailItem) {
        self.nameLabel.text = member.name
        self.positionLabel.text = member.role
        
        let firstWordinName = String((member.name.first)!)
        self.profileLabel.text = firstWordinName
    }
}

