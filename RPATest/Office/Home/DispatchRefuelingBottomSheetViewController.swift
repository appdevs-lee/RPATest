//
//  DispatchRefuelingBottomSheetViewController.swift
//  RPATest
//
//  Created by Awesomepia on 11/2/23.
//

import UIKit

final class DispatchRefuelingBottomSheetViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "주유"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "\(SupportingMethods.shared.convertDate(intoString: Date()))"
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var gasStationTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "주유장소", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var gasStationButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedGasStationButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var carNumberTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "차량번호", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var carNumberButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedCarNumberButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var driverNameTextField: UITextField = {
        let textField = UITextField()
        textField.isEnabled = false
        textField.attributedPlaceholder = NSAttributedString(string: "운전자명", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.text = UserInfo.shared.name
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var movingDistanceTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "주유 시 km", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "주유량", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var ureaSolutionTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "요소수", attributes: [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 189, green: 189, blue: 189),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ])
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .useRGB(red: 176, green: 0, blue: 32)
        button.layer.cornerRadius = 13.5
        button.addTarget(self, action: #selector(tappedDoneButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Properties
    // 바텀 시트 높이
    var bottomHeight: CGFloat = 528
    
    // bottomSheet가 view의 상단에서 떨어진 거리
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private var bottomSheetViewBottomConstraint: NSLayoutConstraint!
    
    // 바텀 시트 뷰
    private let bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        view.layer.cornerRadius = 27
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // dismiss Indicator View UI 구성 부분
    private let dismissIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let officeModel = OfficeModel()
    let dispatchModel = DispatchModel()
    
    var vehicleId: Int = 0
    var gasStationId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showBottomSheet()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        print("----------------------------------- TemplateViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchRefuelingBottomSheetViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.modalPresentationStyle = .overFullScreen
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        self.baseView.addGestureRecognizer(dimmedTap)
        
        // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        swipeGesture.direction = .down
        self.dismissIndicatorView.addGestureRecognizer(swipeGesture)
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addVehicleData(_:)), name: Notification.Name("SendVehicle"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addGasStationData(_:)), name: Notification.Name("SendGasStation"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
            self.bottomSheetView,
            self.dismissIndicatorView,
            self.titleLabel,
            self.dateLabel,
            self.gasStationTextField,
            self.gasStationButton,
            self.carNumberTextField,
            self.carNumberButton,
            self.driverNameTextField,
            self.movingDistanceTextField,
            self.amountTextField,
            self.ureaSolutionTextField,
            self.doneButton
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
        
        let topConstant = self.view.safeAreaInsets.bottom + safeArea.layoutFrame.height
        self.bottomSheetViewTopConstraint = self.bottomSheetView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            self.bottomSheetView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.bottomSheetViewTopConstraint
        ])
        
        NSLayoutConstraint.activate([
            self.dismissIndicatorView.widthAnchor.constraint(equalToConstant: 64),
            self.dismissIndicatorView.heightAnchor.constraint(equalToConstant: 4),
            self.dismissIndicatorView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor, constant: 12),
            self.dismissIndicatorView.centerXAnchor.constraint(equalTo: self.bottomSheetView.centerXAnchor)
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor, constant: 16)
        ])
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.dateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24)
        ])
        
        // gasStationTextField
        NSLayoutConstraint.activate([
            self.gasStationTextField.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.gasStationTextField.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.gasStationTextField.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 8),
            self.gasStationTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // gasStationButton
        NSLayoutConstraint.activate([
            self.gasStationButton.leadingAnchor.constraint(equalTo: self.gasStationTextField.leadingAnchor),
            self.gasStationButton.trailingAnchor.constraint(equalTo: self.gasStationTextField.trailingAnchor),
            self.gasStationButton.topAnchor.constraint(equalTo: self.gasStationTextField.topAnchor),
            self.gasStationButton.bottomAnchor.constraint(equalTo: self.gasStationTextField.bottomAnchor),
        ])
        
        // carNumberTextField
        NSLayoutConstraint.activate([
            self.carNumberTextField.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.carNumberTextField.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.carNumberTextField.topAnchor.constraint(equalTo: self.gasStationTextField.bottomAnchor, constant: 8),
            self.carNumberTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // carNumberButton
        NSLayoutConstraint.activate([
            self.carNumberButton.leadingAnchor.constraint(equalTo: self.carNumberTextField.leadingAnchor),
            self.carNumberButton.trailingAnchor.constraint(equalTo: self.carNumberTextField.trailingAnchor),
            self.carNumberButton.topAnchor.constraint(equalTo: self.carNumberTextField.topAnchor),
            self.carNumberButton.bottomAnchor.constraint(equalTo: self.carNumberTextField.bottomAnchor),
        ])
        
        // driverNameTextField
        NSLayoutConstraint.activate([
            self.driverNameTextField.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.driverNameTextField.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.driverNameTextField.topAnchor.constraint(equalTo: self.carNumberTextField.bottomAnchor, constant: 8),
            self.driverNameTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // movingDistanceTextField
        NSLayoutConstraint.activate([
            self.movingDistanceTextField.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.movingDistanceTextField.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.movingDistanceTextField.topAnchor.constraint(equalTo: self.driverNameTextField.bottomAnchor, constant: 8),
            self.movingDistanceTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // amountTextField
        NSLayoutConstraint.activate([
            self.amountTextField.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.amountTextField.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.amountTextField.topAnchor.constraint(equalTo: self.movingDistanceTextField.bottomAnchor, constant: 8),
            self.amountTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // ureaSolutionTextField
        NSLayoutConstraint.activate([
            self.ureaSolutionTextField.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.ureaSolutionTextField.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.ureaSolutionTextField.topAnchor.constraint(equalTo: self.amountTextField.bottomAnchor, constant: 8),
            self.ureaSolutionTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // doneButton
        self.bottomSheetViewBottomConstraint = self.doneButton.topAnchor.constraint(equalTo: self.ureaSolutionTextField.bottomAnchor, constant: 16)
        NSLayoutConstraint.activate([
            self.doneButton.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor, constant: 16),
            self.doneButton.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor, constant: -16),
            self.bottomSheetViewBottomConstraint,
            self.doneButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
}

// MARK: - Extension for methods added
extension DispatchRefuelingBottomSheetViewController {
    // 바텀 시트 표출 애니메이션
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        self.bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 바텀 시트 사라지는 애니메이션
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        self.bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func sendRefuelingDataRequest(date: String, vehicle: Int, driver: Int, km: Double, refuelingAmount: Double, ureaSolution: Double, gasStation: Int, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        self.officeModel.sendRefuelingDataRequest(date: date, vehicle: vehicle, driver: driver, km: km, refuelingAmount: refuelingAmount, ureaSolution: ureaSolution, gasStation: gasStation) {
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
    
    func loadVehicleListRequest(success: (([VehicleListItem]) -> ())?, failure: ((String) -> ())?) {
        self.dispatchModel.loadVehicleListRequest { item in
            success?(item)
            
        } failure: { errorMessage in
            SupportingMethods.shared.checkExpiration(errorMessage: errorMessage) {
                failure?(errorMessage)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension DispatchRefuelingBottomSheetViewController {
    // UITapGestureRecognizer 연결 함수 부분
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        self.hideBottomSheetAndGoBack()
    }
    
    @objc func tappedDoneButton() {
        if self.gasStationTextField.text != "" && self.driverNameTextField.text != "" && self.movingDistanceTextField.text != "" && self.carNumberTextField.text != "" && self.ureaSolutionTextField.text != "" && self.amountTextField.text != "" {
            
            self.movingDistanceTextField.resignFirstResponder()
            self.amountTextField.resignFirstResponder()
            self.ureaSolutionTextField.resignFirstResponder()
            
            let date = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd HH:mm")
            
            SupportingMethods.shared.turnCoverView(.on)
            self.sendRefuelingDataRequest(date: date, vehicle: self.vehicleId, driver: UserInfo.shared.id!, km: Double(self.movingDistanceTextField.text ?? "0")!, refuelingAmount: Double(self.amountTextField.text ?? "0")!, ureaSolution: Double(self.ureaSolutionTextField.text ?? "0")!, gasStation: self.gasStationId) {
                
                self.hideBottomSheetAndGoBack()
                SupportingMethods.shared.turnCoverView(.off)
                
            } failure: { errorMessage in
                print("tappedDoneButton sendRefuelingDataRequest API Error: \(errorMessage)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        } else {
            SupportingMethods.shared.showAlertNoti(title: "값을 모두 입력해주세요.")
        }
        
    }
    
    // UISwipeGestureRecognizer 연결 함수 부분
    @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .down:
                print(".down")
                self.hideBottomSheetAndGoBack()
            default:
                break
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            
            self.bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - (bottomHeight + keyboardSize.height)
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding: CGFloat = view.safeAreaInsets.bottom
            
            self.bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func tappedCarNumberButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadVehicleListRequest { item in
            let vc = InspectionVehicleListViewController(vehicleList: item)
            
            self.present(vc, animated: true) {
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        } failure: { errorMessage in
            print("tappedCarNumberButton loadVehicleListRequest API Error: \(errorMessage)")
            SupportingMethods.shared.turnCoverView(.off)
        }
    }
    
    @objc func tappedGasStationButton(_ sender: UIButton) {
        let vc = GasStationListViewController()
        
        self.present(vc, animated: true)
    }
    
    @objc func addVehicleData(_ noti: Notification) {
        guard let vehicleId = noti.userInfo?["vehicleId"] as? Int else { return }
        guard let vehicleNumber = noti.userInfo?["vehicleNumber"] as? String else { return }
        
        self.vehicleId = vehicleId
        self.carNumberTextField.text = "\(vehicleNumber)"
    }
    
    @objc func addGasStationData(_ noti: Notification) {
        guard let gasStationId = noti.userInfo?["gasStationId"] as? Int else { return }
        guard let gasStationName = noti.userInfo?["gasStationName"] as? String else { return }
        
        self.gasStationId = gasStationId
        self.gasStationTextField.text = "\(gasStationName)"
    }
}
