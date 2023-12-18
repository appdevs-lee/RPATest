//
//  DispatchNoteDetailViewController.swift
//  RPATest
//
//  Created by 이주성 on 12/18/23.
//

import UIKit

final class DispatchNoteDetailViewController: UIViewController {
    
    lazy var carNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 22, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발 장소"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착 장소"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발 시간"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"))"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DayRightButton")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var departureTimeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedDepartureTimeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrivalTimeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착 시간"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "\(SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"))"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DayRightButton")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrivalTimeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedArrivalTimeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var departureFigureBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureFigureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발 시 계기 KM"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureFigureTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var arrivalFigureBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalFigureTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착 시 계기 KM"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalFigureTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var passengerNumberBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var passengerNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "인원 수"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passengerNumberTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "인원 수를 입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var additionalInfoBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var additionalInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "특이사항"
        label.textColor = .useRGB(red: 189, green: 189, blue: 189)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var additionalInfoTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .useRGB(red: 97, green: 97, blue: 97)
        textView.font = .useFont(ofSize: 16, weight: .Medium)
        textView.layer.borderColor = UIColor.useRGB(red: 189, green: 189, blue: 189).cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.layer.cornerRadius = 22
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(type: DispatchKindType, id: (regularly: String, order: String)) {
        self.type = type
        self.id = id
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var type: DispatchKindType
    var id: (regularly: String, order: String)
    
    let dispatchModel = DispatchModel()
    
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
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- DispatchNoteDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchNoteDetailViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 246, green: 246, blue: 246)
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
        SupportingMethods.shared.addSubviews([
            self.carNumberLabel,
            
            self.departureBaseView,
            self.departureTitleLabel,
            self.departureLabel,
            
            self.arrivalBaseView,
            self.arrivalTitleLabel,
            self.arrivalLabel,
            
            self.departureTimeBaseView,
            self.departureTimeTitleLabel,
            self.departureTimeLabel,
            self.departureTimeArrowImageView,
            self.departureTimeButton,
            
            self.arrivalTimeBaseView,
            self.arrivalTimeTitleLabel,
            self.arrivalTimeLabel,
            self.arrivalTimeArrowImageView,
            self.arrivalTimeButton,
            
            self.departureFigureBaseView,
            self.departureFigureTitleLabel,
            self.departureFigureTextField,
            
            self.arrivalFigureBaseView,
            self.arrivalFigureTitleLabel,
            self.arrivalFigureTextField,
            
            self.passengerNumberBaseView,
            self.passengerNumberTitleLabel,
            self.passengerNumberTextField,
            
            self.additionalInfoBaseView,
            self.additionalInfoTitleLabel,
            self.additionalInfoTextView,
            
            self.doneButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // carNumberLabel
        NSLayoutConstraint.activate([
            self.carNumberLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.carNumberLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            self.carNumberLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        // departureBaseView
        NSLayoutConstraint.activate([
            self.departureBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.departureBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.departureBaseView.topAnchor.constraint(equalTo: self.carNumberLabel.bottomAnchor, constant: 20)
        ])
        
        // departureTitleLabel
        NSLayoutConstraint.activate([
            self.departureTitleLabel.leadingAnchor.constraint(equalTo: self.departureBaseView.leadingAnchor, constant: 16),
            self.departureTitleLabel.topAnchor.constraint(equalTo: self.departureBaseView.topAnchor, constant: 10),
            self.departureTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureBaseView.leadingAnchor, constant: 16),
            self.departureLabel.topAnchor.constraint(equalTo: self.departureTitleLabel.bottomAnchor, constant: 8),
            self.departureLabel.bottomAnchor.constraint(equalTo: self.departureBaseView.bottomAnchor, constant: -10),
            self.departureLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // arrivalBaseView
        NSLayoutConstraint.activate([
            self.arrivalBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.arrivalBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.arrivalBaseView.topAnchor.constraint(equalTo: self.departureBaseView.bottomAnchor, constant: 10)
        ])
        
        // arrivalTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTitleLabel.leadingAnchor.constraint(equalTo: self.arrivalBaseView.leadingAnchor, constant: 16),
            self.arrivalTitleLabel.topAnchor.constraint(equalTo: self.arrivalBaseView.topAnchor, constant: 10),
            self.arrivalTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalBaseView.leadingAnchor, constant: 16),
            self.arrivalLabel.topAnchor.constraint(equalTo: self.arrivalTitleLabel.bottomAnchor, constant: 8),
            self.arrivalLabel.bottomAnchor.constraint(equalTo: self.arrivalBaseView.bottomAnchor, constant: -10),
            self.arrivalLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // departureTimeBaseView
        NSLayoutConstraint.activate([
            self.departureTimeBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.departureTimeBaseView.topAnchor.constraint(equalTo: self.arrivalBaseView.bottomAnchor, constant: 10),
            self.departureTimeBaseView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) / 2)
        ])
        
        // departureTimeTitleLabel
        NSLayoutConstraint.activate([
            self.departureTimeTitleLabel.leadingAnchor.constraint(equalTo: self.departureTimeBaseView.leadingAnchor, constant: 16),
            self.departureTimeTitleLabel.topAnchor.constraint(equalTo: self.departureTimeBaseView.topAnchor, constant: 10),
            self.departureTimeTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.departureTimeBaseView.leadingAnchor, constant: 16),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.departureTimeTitleLabel.bottomAnchor, constant: 8),
            self.departureTimeLabel.bottomAnchor.constraint(equalTo: self.departureTimeBaseView.bottomAnchor, constant: -10),
            self.departureTimeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // departureTimeArrowImageView
        NSLayoutConstraint.activate([
            self.departureTimeArrowImageView.trailingAnchor.constraint(equalTo: self.departureTimeBaseView.trailingAnchor, constant: -10),
            self.departureTimeArrowImageView.centerYAnchor.constraint(equalTo: self.departureTimeBaseView.centerYAnchor)
        ])
        
        // departureTimeButton
        NSLayoutConstraint.activate([
            self.departureTimeButton.leadingAnchor.constraint(equalTo: self.departureTimeBaseView.leadingAnchor),
            self.departureTimeButton.trailingAnchor.constraint(equalTo: self.departureTimeBaseView.trailingAnchor),
            self.departureTimeButton.topAnchor.constraint(equalTo: self.departureTimeBaseView.topAnchor),
            self.departureTimeButton.bottomAnchor.constraint(equalTo: self.departureTimeBaseView.bottomAnchor),
        ])
        
        // arrivalTimeBaseView
        NSLayoutConstraint.activate([
            self.arrivalTimeBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.arrivalTimeBaseView.leadingAnchor.constraint(equalTo: self.departureTimeBaseView.trailingAnchor, constant: 8),
            self.arrivalTimeBaseView.topAnchor.constraint(equalTo: self.arrivalBaseView.bottomAnchor, constant: 10),
            self.arrivalTimeBaseView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) / 2)
        ])
        
        // arrivalTimeTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeTitleLabel.leadingAnchor.constraint(equalTo: self.arrivalTimeBaseView.leadingAnchor, constant: 16),
            self.arrivalTimeTitleLabel.topAnchor.constraint(equalTo: self.arrivalTimeBaseView.topAnchor, constant: 10),
            self.arrivalTimeTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalTimeBaseView.leadingAnchor, constant: 16),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.arrivalTimeTitleLabel.bottomAnchor, constant: 8),
            self.arrivalTimeLabel.bottomAnchor.constraint(equalTo: self.arrivalTimeBaseView.bottomAnchor, constant: -10),
            self.arrivalTimeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // arrivalTimeArrowImageView
        NSLayoutConstraint.activate([
            self.arrivalTimeArrowImageView.trailingAnchor.constraint(equalTo: self.arrivalTimeBaseView.trailingAnchor, constant: -10),
            self.arrivalTimeArrowImageView.centerYAnchor.constraint(equalTo: self.arrivalTimeBaseView.centerYAnchor)
        ])
        
        // arrivalTimeButton
        NSLayoutConstraint.activate([
            self.arrivalTimeButton.leadingAnchor.constraint(equalTo: self.arrivalTimeBaseView.leadingAnchor),
            self.arrivalTimeButton.trailingAnchor.constraint(equalTo: self.arrivalTimeBaseView.trailingAnchor),
            self.arrivalTimeButton.topAnchor.constraint(equalTo: self.arrivalTimeBaseView.topAnchor),
            self.arrivalTimeButton.bottomAnchor.constraint(equalTo: self.arrivalTimeBaseView.bottomAnchor),
        ])
        
        // departureFigureBaseView
        NSLayoutConstraint.activate([
            self.departureFigureBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.departureFigureBaseView.topAnchor.constraint(equalTo: self.arrivalTimeBaseView.bottomAnchor, constant: 10),
            self.departureFigureBaseView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) / 2)
        ])
        
        // departureFigureTitleLabel
        NSLayoutConstraint.activate([
            self.departureFigureTitleLabel.leadingAnchor.constraint(equalTo: self.departureFigureBaseView.leadingAnchor, constant: 16),
            self.departureFigureTitleLabel.topAnchor.constraint(equalTo: self.departureFigureBaseView.topAnchor, constant: 10),
            self.departureFigureTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // departureFigureTextField
        NSLayoutConstraint.activate([
            self.departureFigureTextField.leadingAnchor.constraint(equalTo: self.departureFigureBaseView.leadingAnchor, constant: 8),
            self.departureFigureTextField.trailingAnchor.constraint(equalTo: self.departureFigureBaseView.trailingAnchor, constant: -8),
            self.departureFigureTextField.topAnchor.constraint(equalTo: self.departureFigureTitleLabel.bottomAnchor, constant: 8),
            self.departureFigureTextField.bottomAnchor.constraint(equalTo: self.departureFigureBaseView.bottomAnchor, constant: -10),
            self.departureFigureTextField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        // arrivalFigureBaseView
        NSLayoutConstraint.activate([
            self.arrivalFigureBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.arrivalFigureBaseView.topAnchor.constraint(equalTo: self.arrivalTimeBaseView.bottomAnchor, constant: 10),
            self.arrivalFigureBaseView.leadingAnchor.constraint(equalTo: self.departureFigureBaseView.trailingAnchor, constant: 8),
            self.arrivalFigureBaseView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) / 2)
        ])
        
        // arrivalFigureTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalFigureTitleLabel.leadingAnchor.constraint(equalTo: self.arrivalFigureBaseView.leadingAnchor, constant: 16),
            self.arrivalFigureTitleLabel.topAnchor.constraint(equalTo: self.arrivalFigureBaseView.topAnchor, constant: 10),
            self.arrivalFigureTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // arrivalFigureTextField
        NSLayoutConstraint.activate([
            self.arrivalFigureTextField.leadingAnchor.constraint(equalTo: self.arrivalFigureBaseView.leadingAnchor, constant: 8),
            self.arrivalFigureTextField.trailingAnchor.constraint(equalTo: self.arrivalFigureBaseView.trailingAnchor, constant: -8),
            self.arrivalFigureTextField.topAnchor.constraint(equalTo: self.arrivalFigureTitleLabel.bottomAnchor, constant: 8),
            self.arrivalFigureTextField.bottomAnchor.constraint(equalTo: self.arrivalFigureBaseView.bottomAnchor, constant: -10),
            self.arrivalFigureTextField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        // passengerNumberBaseView
        NSLayoutConstraint.activate([
            self.passengerNumberBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.passengerNumberBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.passengerNumberBaseView.topAnchor.constraint(equalTo: self.departureFigureBaseView.bottomAnchor, constant: 20)
        ])
        
        // passengerNumberTitleLabel
        NSLayoutConstraint.activate([
            self.passengerNumberTitleLabel.leadingAnchor.constraint(equalTo: self.passengerNumberBaseView.leadingAnchor, constant: 16),
            self.passengerNumberTitleLabel.topAnchor.constraint(equalTo: self.passengerNumberBaseView.topAnchor, constant: 10),
            self.passengerNumberTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // passengerNumberTextField
        NSLayoutConstraint.activate([
            self.passengerNumberTextField.leadingAnchor.constraint(equalTo: self.passengerNumberBaseView.leadingAnchor, constant: 16),
            self.passengerNumberTextField.trailingAnchor.constraint(equalTo: self.passengerNumberBaseView.trailingAnchor, constant: -16),
            self.passengerNumberTextField.topAnchor.constraint(equalTo: self.passengerNumberTitleLabel.bottomAnchor, constant: 8),
            self.passengerNumberTextField.bottomAnchor.constraint(equalTo: self.passengerNumberBaseView.bottomAnchor, constant: -10),
            self.passengerNumberTextField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        // additionalInfoBaseView
        NSLayoutConstraint.activate([
            self.additionalInfoBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.additionalInfoBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.additionalInfoBaseView.topAnchor.constraint(equalTo: self.passengerNumberBaseView.bottomAnchor, constant: 10)
        ])
        
        // additionalInfoTitleLabel
        NSLayoutConstraint.activate([
            self.additionalInfoTitleLabel.leadingAnchor.constraint(equalTo: self.additionalInfoBaseView.leadingAnchor, constant: 16),
            self.additionalInfoTitleLabel.topAnchor.constraint(equalTo: self.additionalInfoBaseView.topAnchor, constant: 10),
            self.additionalInfoTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // additionalInfoTextView
        NSLayoutConstraint.activate([
            self.additionalInfoTextView.leadingAnchor.constraint(equalTo: self.additionalInfoBaseView.leadingAnchor, constant: 16),
            self.additionalInfoTextView.trailingAnchor.constraint(equalTo: self.additionalInfoBaseView.trailingAnchor, constant: -16),
            self.additionalInfoTextView.topAnchor.constraint(equalTo: self.additionalInfoTitleLabel.bottomAnchor, constant: 8),
            self.additionalInfoTextView.bottomAnchor.constraint(equalTo: self.additionalInfoBaseView.bottomAnchor, constant: -10),
            self.additionalInfoTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // doneButton
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            self.doneButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            self.doneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func setUpNavigationItem() {
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
        
        self.navigationItem.title = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchNoteDetailRequest(regularlyId: self.id.regularly, orderId: self.id.order) { item in
            self.carNumberLabel.text = "\(item.connect.bus)번 운행일보"
            self.departureLabel.text = "\(item.connect.departure)"
            self.arrivalLabel.text = "\(item.connect.arrival)"
            
            self.departureTimeLabel.text = "\(item.connect.departureTime)"
            self.arrivalTimeLabel.text = "\(item.connect.arrivalTime)"
            
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            print("setData loadDispatchNoteDetailRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
            
        }

    }
}

// MARK: - Extension for methods added
extension DispatchNoteDetailViewController {
    func loadDispatchNoteDetailRequest(regularlyId: String = "", orderId: String = "", success: ((DispatchNoteDetailItem) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.dispatchModel.loadDispatchNoteDetailRequest(regularlyId: regularlyId, orderId: orderId) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
        }

    }
}

// MARK: - Extension for selector methods
extension DispatchNoteDetailViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedDepartureTimeButton(_ sender: UIButton) {
        
    }
    
    @objc func tappedArrivalTimeButton(_ sender: UIButton) {
        
    }
}

// MARK: - Extension for UITextFieldDelegate
extension DispatchNoteDetailViewController: UITextFieldDelegate {
    
}

// MARK: - Extension for UITextViewDelegate
extension DispatchNoteDetailViewController: UITextViewDelegate {
    
}
