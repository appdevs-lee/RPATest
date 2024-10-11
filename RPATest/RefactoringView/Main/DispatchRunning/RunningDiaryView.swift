//
//  RunningDiaryView.swift
//  RPATest
//
//  Created by Awesomepia on 10/11/24.
//

import UIKit

class RunningDiaryView: UIView {
    
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
        textField.keyboardType = .decimalPad
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
        textField.keyboardType = .decimalPad
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
        textField.keyboardType = .numberPad
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

    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RunningDiaryView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
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
        ], to: self)
    }
    
    func setLayouts() {
        // departureFigureBaseView
        NSLayoutConstraint.activate([
            self.departureFigureBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.departureFigureBaseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
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
            self.arrivalFigureBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
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
            self.passengerNumberBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.passengerNumberBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.passengerNumberBaseView.topAnchor.constraint(equalTo: self.departureFigureBaseView.bottomAnchor, constant: 10),
            self.passengerNumberBaseView.topAnchor.constraint(equalTo: self.arrivalFigureBaseView.bottomAnchor, constant: 10)
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
            self.additionalInfoBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.additionalInfoBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.additionalInfoBaseView.topAnchor.constraint(equalTo: self.passengerNumberBaseView.bottomAnchor, constant: 10),
            self.additionalInfoBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
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
    }
}

// MARK: - Extension for methods added
extension RunningDiaryView {
    
}

// MARK: - Extension for selector added
extension RunningDiaryView {
    
}

// MARK: - Extension for UITextFieldDelegate
extension RunningDiaryView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.departureFigureTextField.text != "" && self.arrivalFigureTextField.text != "" && self.passengerNumberTextField.text != "" {
            
        } else {
            
        }
    }
}

// MARK: - Extension for UITextViewDelegate
extension RunningDiaryView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        return true
    }
}
