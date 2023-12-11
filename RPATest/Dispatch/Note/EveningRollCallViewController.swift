//
//  EveningRollCallViewController.swift
//  RPATest
//
//  Created by Awesomepia on 12/7/23.
//

import UIKit

final class EveningRollCallViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.date)"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var carNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "차량 번호"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: 입고장소
    lazy var garageLabel: UILabel = {
        let label = UILabel()
        label.text = "입고 장소"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var garageTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: "차고지를 선택해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var garageButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedGarageButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var drivingDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "계기판 KM"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var drivingDistanceTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "계기판에 적힌 총 주행거리를 입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var fuelLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 주유량: "
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var fuelSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.addTarget(self, action: #selector(fuelValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    lazy var ureaLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 요소수량"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var ureaTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "요소수량을 입력해주세요.", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var gaugeLabel: UILabel = {
        let label = UILabel()
        label.text = "수트게이지: "
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var gaugeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 5
        slider.addTarget(self, action: #selector(gaugeValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    lazy var additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "특이사항(운행과 관련하여 발생한 특이사항을 기입해주세요.)"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var additionalInfoTextView: UIView = {
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
    
    lazy var completeButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 22, weight: .Bold)
        button.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(tappedCompleteButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init(date: String) {
        self.date = date
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dispatchModel = DispatchModel()
    var date: String
    var completeButtonBottomConstraint: NSLayoutConstraint!
    var keyboardHeight: CGFloat = 0
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- EveningRollCallViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension EveningRollCallViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.dateLabel,
            self.carNumberLabel,
            self.garageLabel,
            self.garageTextField,
            self.garageButton,
            self.drivingDistanceLabel,
            self.drivingDistanceTextField,
            self.fuelLabel,
            self.fuelSlider,
            self.ureaLabel,
            self.ureaTextField,
            self.gaugeLabel,
            self.gaugeSlider,
            self.additionalInfoLabel,
            self.additionalInfoTextView,
            self.completeButton
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 10),
            self.dateLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // carNumberLabel
        NSLayoutConstraint.activate([
            self.carNumberLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.carNumberLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10),
            self.carNumberLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // garageLabel
        NSLayoutConstraint.activate([
            self.garageLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.garageLabel.topAnchor.constraint(equalTo: self.carNumberLabel.bottomAnchor, constant: 10),
            self.garageLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // garageTextField
        NSLayoutConstraint.activate([
            self.garageTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.garageTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.garageTextField.topAnchor.constraint(equalTo: self.garageLabel.bottomAnchor, constant: 8),
            self.garageTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // garageButton
        NSLayoutConstraint.activate([
            self.garageButton.leadingAnchor.constraint(equalTo: self.garageTextField.leadingAnchor),
            self.garageButton.trailingAnchor.constraint(equalTo: self.garageTextField.trailingAnchor),
            self.garageButton.topAnchor.constraint(equalTo: self.garageTextField.topAnchor),
            self.garageButton.bottomAnchor.constraint(equalTo: self.garageTextField.bottomAnchor),
        ])
        
        // drivingDistanceLabel
        NSLayoutConstraint.activate([
            self.drivingDistanceLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.drivingDistanceLabel.topAnchor.constraint(equalTo: self.garageTextField.bottomAnchor, constant: 10),
            self.drivingDistanceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // drivingDistanceTextField
        NSLayoutConstraint.activate([
            self.drivingDistanceTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.drivingDistanceTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.drivingDistanceTextField.topAnchor.constraint(equalTo: self.drivingDistanceLabel.bottomAnchor, constant: 8),
            self.drivingDistanceTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // fuelLabel
        NSLayoutConstraint.activate([
            self.fuelLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.fuelLabel.topAnchor.constraint(equalTo: self.drivingDistanceTextField.bottomAnchor, constant: 10),
            self.fuelLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // fuelSlider
        NSLayoutConstraint.activate([
            self.fuelSlider.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.fuelSlider.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.fuelSlider.topAnchor.constraint(equalTo: self.fuelLabel.bottomAnchor, constant: 8),
            self.fuelSlider.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        // ureaLabel
        NSLayoutConstraint.activate([
            self.ureaLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.ureaLabel.topAnchor.constraint(equalTo: self.fuelSlider.bottomAnchor, constant: 10),
            self.ureaLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // ureaTextField
        NSLayoutConstraint.activate([
            self.ureaTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.ureaTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.ureaTextField.topAnchor.constraint(equalTo: self.ureaLabel.bottomAnchor, constant: 8),
            self.ureaTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // gaugeLabel
        NSLayoutConstraint.activate([
            self.gaugeLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.gaugeLabel.topAnchor.constraint(equalTo: self.ureaTextField.bottomAnchor, constant: 10),
            self.gaugeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // gaugeSlider
        NSLayoutConstraint.activate([
            self.gaugeSlider.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.gaugeSlider.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.gaugeSlider.topAnchor.constraint(equalTo: self.gaugeLabel.bottomAnchor, constant: 8),
            self.gaugeSlider.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        // additionalInfoLabel
        NSLayoutConstraint.activate([
            self.additionalInfoLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.additionalInfoLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        // additionalInfoTextView
        NSLayoutConstraint.activate([
            self.additionalInfoTextView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.additionalInfoTextView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.additionalInfoTextView.topAnchor.constraint(equalTo: self.additionalInfoLabel.bottomAnchor, constant: 8),
            self.additionalInfoTextView.bottomAnchor.constraint(equalTo: self.completeButton.topAnchor, constant: -20),
            self.additionalInfoTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        // completeButton
        self.completeButtonBottomConstraint = self.completeButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor)
        NSLayoutConstraint.activate([
            self.completeButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.completeButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.completeButtonBottomConstraint,
            self.completeButton.heightAnchor.constraint(equalToConstant: 44)
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
        
        self.navigationItem.title = "저녁점호"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension EveningRollCallViewController {
    func loadGarageRequest(page: Int, search: String, success: ((GarageItem) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadGarageRequest(page: page, search: search) { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension EveningRollCallViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func tappedGarageButton(_ sender: UIButton) {
        
    }
    
    @objc func fuelValueChanged(_ sender: UISlider) {
        self.fuelLabel.text = "현재 주유량: " + String(format: "%.2f", sender.value)
        
    }
    
    @objc func gaugeValueChanged(_ sender: UISlider) {
        self.gaugeLabel.text = "수트 게이지: \(Int(sender.value))"
        
    }
    
    @objc func tappedCompleteButton(_ sender: UIButton) {
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            self.keyboardHeight = -keyboardSize.height
            
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            self.completeButtonBottomConstraint.constant = 0
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
}

// MARK: - Extension for UITextFieldDelegate
extension EveningRollCallViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.garageTextField.text != "" && self.drivingDistanceTextField.text != "" {
            self.completeButton.isEnabled = true
            self.completeButton.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
            
        } else {
            self.completeButton.isEnabled = false
            self.completeButton.backgroundColor = .useRGB(red: 189, green: 189, blue: 189)
            
        }
    }
    
}

// MARK: - Extension for UITextViewDelegate
extension EveningRollCallViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        NSLayoutConstraint.deactivate([
            self.completeButtonBottomConstraint
        ])
        
        self.completeButtonBottomConstraint.constant = self.keyboardHeight
        
        NSLayoutConstraint.activate([
            self.completeButtonBottomConstraint
        ])
        
        return true
    }
    
}
