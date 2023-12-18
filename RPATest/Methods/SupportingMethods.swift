//
//  SupportingMethods.swift
//  RPATest
//
//  Created by 이주성 on 2023/07/29.
//

import Foundation
import UIKit
import Photos
import PhotosUI

enum CoverViewState {
    case on
    case off
}

enum PickerType {
    case image
    case video
}

class SupportingMethods {
    private var notiAnimator: UIViewPropertyAnimator?
    private var notiViewBottomAnchor: NSLayoutConstraint!
    private var notiTitleLabelTrailingAnchor: NSLayoutConstraint!
    private var notiButtonAction: (() -> ())?
    
    private lazy var notiBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var notiView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.useSketchShadow(color: .black, alpha: 0.15, x: 0, y: 4, blur: 8, spread: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var notiImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "notiIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var notiTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Noti Title"
        label.textColor = .useRGB(red: 66, green: 66, blue: 66)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var notiButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.useRGB(red: 131, green: 164, blue: 245), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.addTarget(self, action: #selector(notiButton(_:)), for: .touchUpInside)
        button.setTitle("Button Title", for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var coverView: UIView = {
        // Cover View
        let coverView = UIView()
        coverView.backgroundColor = UIColor.useRGB(red: 0, green: 0, blue: 0, alpha: 0.1)
        coverView.isHidden = true
        coverView.translatesAutoresizingMaskIntoConstraints = false
        
        // Activity Indicator View
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        coverView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            // Activity Indicator
            activityIndicator.centerYAnchor.constraint(equalTo: coverView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: coverView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
        
        return coverView
    }()
    
    static let shared = SupportingMethods()
    
    private init() {
        self.initializeAlertNoti()
        self.initializeCoverView()
    }
}

// MARK: - Extension for methods added
extension SupportingMethods {
    // MARK: Initial views
    // alert noti view
    func initializeAlertNoti() {
        let window: UIWindow! = ReferenceValues.keyWindow
        
        self.addSubviews([
            self.notiBaseView
        ], to: window)
        
        self.addSubviews([
            self.notiView
        ], to: self.notiBaseView)
        
        self.addSubviews([
            self.notiImageView,
            self.notiTitleLabel,
            self.notiButton
        ], to: self.notiView)
        
        // notiBaseView
        NSLayoutConstraint.activate([
            self.notiBaseView.topAnchor.constraint(equalTo: window.topAnchor),
            self.notiBaseView.heightAnchor.constraint(equalToConstant: 150),
            self.notiBaseView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            self.notiBaseView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
        ])
        
        // notiView
        self.notiViewBottomAnchor = self.notiView.bottomAnchor.constraint(equalTo: self.notiBaseView.topAnchor)
        NSLayoutConstraint.activate([
            self.notiViewBottomAnchor,
            self.notiView.heightAnchor.constraint(greaterThanOrEqualToConstant: 56),
            self.notiView.leadingAnchor.constraint(equalTo: self.notiBaseView.leadingAnchor, constant: 16),
            self.notiView.trailingAnchor.constraint(equalTo: self.notiBaseView.trailingAnchor, constant: -16)
        ])
        
        // notiImageView
        NSLayoutConstraint.activate([
            self.notiImageView.centerYAnchor.constraint(equalTo: self.notiView.centerYAnchor),
            self.notiImageView.heightAnchor.constraint(equalToConstant: 24),
            self.notiImageView.leadingAnchor.constraint(equalTo: self.notiView.leadingAnchor, constant: 16),
            self.notiImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        // notiTitleLabel
        self.notiTitleLabelTrailingAnchor = self.notiTitleLabel.trailingAnchor.constraint(equalTo: self.notiView.trailingAnchor, constant: -16)
        NSLayoutConstraint.activate([
            self.notiTitleLabel.topAnchor.constraint(equalTo: self.notiView.topAnchor, constant: 18.5),
            self.notiTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 19),
            self.notiTitleLabel.bottomAnchor.constraint(equalTo: self.notiView.bottomAnchor, constant: -18.5),
            self.notiTitleLabel.leadingAnchor.constraint(equalTo: self.notiImageView.trailingAnchor, constant: 8),
            self.notiTitleLabelTrailingAnchor
        ])
        
        // notiButton
        NSLayoutConstraint.activate([
            self.notiButton.centerYAnchor.constraint(equalTo: self.notiView.centerYAnchor),
            self.notiButton.trailingAnchor.constraint(equalTo: self.notiView.trailingAnchor, constant: -16),
        ])
    }
    
    // cover view
    func initializeCoverView() {
        let window: UIWindow! = ReferenceValues.keyWindow
        
        self.addSubviews([
            self.coverView
        ], to: window)
        
        // coverView
        NSLayoutConstraint.activate([
            self.coverView.topAnchor.constraint(equalTo: window.topAnchor),
            self.coverView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            self.coverView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            self.coverView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
        ])
    }
    
    // MARK: Show alert noti
    func showAlertNoti(title: String, button: (title: String, notiButtonAction:(() -> ())?)? = nil) {
        ReferenceValues.keyWindow.bringSubviewToFront(self.notiBaseView)
        
        // Set noti label and button
        self.notiTitleLabel.text = title
        self.notiButton.setTitle(button?.title, for: .normal)
        if let notiButtonAction = button?.notiButtonAction {
            self.notiButtonAction = notiButtonAction
            self.notiButton.isHidden = false
            
            NSLayoutConstraint.deactivate([
                self.notiTitleLabelTrailingAnchor
            ])
            self.notiTitleLabelTrailingAnchor = self.notiTitleLabel.trailingAnchor.constraint(equalTo: self.notiButton.leadingAnchor, constant: -4)
            NSLayoutConstraint.activate([
                self.notiTitleLabelTrailingAnchor
            ])
            
        } else {
            self.notiButtonAction = nil
            self.notiButton.isHidden = true
            
            NSLayoutConstraint.deactivate([
                self.notiTitleLabelTrailingAnchor
            ])
            self.notiTitleLabelTrailingAnchor = self.notiTitleLabel.trailingAnchor.constraint(equalTo: self.notiView.trailingAnchor, constant: -16)
            NSLayoutConstraint.activate([
                self.notiTitleLabelTrailingAnchor
            ])
        }
        self.notiBaseView.layoutIfNeeded()
        
        // Animating
        self.notiAnimator?.stopAnimation(false)
        self.notiAnimator?.finishAnimation(at: .end)
        
        if self.notiAnimator == nil || self.notiAnimator?.state == .inactive {
            self.notiBaseView.isHidden = false
            
            self.notiAnimator = UIViewPropertyAnimator(duration: 0.25, dampingRatio: 0.6, animations: {
                self.notiViewBottomAnchor.constant = ReferenceValues.Size.SafeAreaInsets.top + 8 + self.notiView.frame.height
                self.notiBaseView.layoutIfNeeded()
            })
            
            self.notiAnimator?.addCompletion({ position in
                switch position {
                case .end:
                    //print("position end")
                    self.hideNotiAlert()
                    
                default:
                    break
                }
            })
            
            self.notiAnimator?.startAnimation()
        }
    }
    
    private func hideNotiAlert() {
        //print("close")
        self.notiAnimator = UIViewPropertyAnimator(duration: 0.15, curve: .easeIn, animations: {
            self.notiViewBottomAnchor.constant = 0
            self.notiBaseView.layoutIfNeeded()
        })
        self.notiAnimator?.addCompletion({ position in
            switch position {
            case .end:
                //print("second position end")
                self.notiBaseView.isHidden = true
                
            default:
                break
            }
        })
        self.notiAnimator?.startAnimation(afterDelay: 3.0)
    }
    
    @objc private func notiButton(_ sender: UIButton) {
        if let action = self.notiButtonAction {
            action()
            
            self.notiButtonAction = nil
        }
    }
    
    // MARK: Add Subviews
    func addSubviews(_ views: [UIView], to: UIView) {
        for view in views {
            to.addSubview(view)
        }
    }
    
    // MARK: Cover view
    func turnCoverView(_ state: CoverViewState) {
        ReferenceValues.keyWindow.bringSubviewToFront(self.coverView)
        
        switch state {
        case .on:
            self.coverView.isHidden = false
            
        case .off:
            self.coverView.isHidden = true
        }
    }
    
    // MARK: Get Top ViewController
    func getTopVC(_ windowRootVC: UIViewController?) -> UIViewController? {
        var topVC = windowRootVC
        while true {
            if let top = topVC?.presentedViewController {
                topVC = top
                
            } else if let base = topVC as? UINavigationController, let top = base.visibleViewController {
                topVC = top
                
            } else if let base = topVC as? UITabBarController, let top = base.selectedViewController {
                topVC = top
                
            } else {
                break
            }
        }
        
        return topVC
    }
    
    // MARK: Determine app state
    enum AppState {
        case terminate
        case logout
        case networkError
        case serverError
        case expired
    }
    
    func determineAppState(_ state: AppState) {
        switch state {
        case .terminate:
            exit(0)
            
        case .logout:
            UserDefaults.standard.removeObject(forKey: "refreshToken")
            UserDefaults.standard.removeObject(forKey: "name")
            
            guard let _ = ReferenceValues.firstVC?.presentedViewController as? TabBarController else {
                ReferenceValues.firstVC?.dismiss(animated: true)
                
                return
            }
            
            ReferenceValues.firstVC?.dismiss(animated: true)
            ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
            
        case .networkError:
            ReferenceValues.firstVC?.backGroundView.isHidden = false
            guard let _ = ReferenceValues.firstVC?.presentedViewController as? TabBarController else {
                ReferenceValues.firstVC?.dismiss(animated: true)
                
                ReferenceValues.firstVC?.setUpProgressView()
                
                return
            }
            
            ReferenceValues.firstVC?.dismiss(animated: false)
            ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
            ReferenceValues.firstVC?.setUpProgressView()
            
        case .serverError:
            ReferenceValues.firstVC?.backGroundView.isHidden = false
            guard let _ = ReferenceValues.firstVC?.presentedViewController as? TabBarController else {
                ReferenceValues.firstVC?.dismiss(animated: true)
                
                ReferenceValues.firstVC?.setUpProgressView()
                
                return
            }
            
            ReferenceValues.firstVC?.dismiss(animated: false)
            ReferenceValues.firstVC?.navigationController?.popToRootViewController(animated: false)
            ReferenceValues.firstVC?.setUpProgressView()
        case .expired:
            // expired state
            
            break
        }
    }
    
    func checkExpiration(errorMessage: String, completion: (() -> ())?) {
        completion?()
        
        let vc = AlertPopViewController(.normalTwoButton(messageTitle: "서비스 접속이 원활하지 않습니다", messageContent: "잠시 후 다시 시도해 주세요.", leftButtonTitle: "앱 종료", leftAction: {
            exit(0)
            
        }, rightButtonTitle: "재접속", rightAction: {
            self.determineAppState(.serverError)
        }))
        
        if let topVC = SupportingMethods.shared.getTopVC(ReferenceValues.keyWindow.rootViewController) {
            if let presentingVC = topVC.presentingViewController, let _ = topVC as? AlertPopViewController {
                presentingVC.dismiss(animated: false) {
                    presentingVC.present(vc, animated: true)
                }
                
            } else {
                topVC.present(vc, animated: true)
            }
        }
        
        self.turnCoverView(.off)
    }
    
    // String -> Date
    func convertString(intoDate dateString: String, _ dateFormat: String = "yyyy-MM-dd") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")!
        formatter.dateFormat = dateFormat
        
        return formatter.date(from: dateString)!
    }
    
    // Date -> String
    func convertDate(intoString date: Date, _ dateFormat: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")!
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: date)
    }
    
    func calculateDate(byValue value: Int, component: Calendar.Component, date: Date? = nil) -> Date {
        let selectedDate = date != nil ? date : Date()
        
        return Calendar.current.date(byAdding: component, value: value, to: selectedDate!)!
    }
    
    // MARK: About time
    func makeDateFormatter(_ format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") //Locale.current
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")!
        dateFormatter.dateFormat = format
        
        return dateFormatter
    }
    
    func calculatePassedTime(_ targetDate: Date?) -> String? {
        guard let targetDate = targetDate else {
            return nil
        }
        
        let now: Int = Int(Date().timeIntervalSince1970)
        let target = Int(targetDate.timeIntervalSince1970)
        let seconds = now - target // time interval between now and target time
        
        if seconds < 3600 { // 1시간 미만
            let minutes = seconds / 60
            if minutes <= 0 {
                return "방금전"
                
            } else {
                return "\(minutes)분 전"
            }
            
        } else if seconds >= 3600 && seconds < 3600 * 24 { // 1시간 이상 1일(24시간) 미만
            let hours = seconds / 3600
            return "\(hours)시간 전"
            
        } else if seconds >= 3600 * 24 && seconds < 3600 * 24 * 7 { // 1일 이상 1주일(7일) 미만
            let days = seconds / (3600 * 24)
            return "\(days)일 전"
            
        } else { // 1주일(7일) 이상
            let dateFormatter = self.makeDateFormatter("yy.MM.dd")
            return dateFormatter.string(from: targetDate)
        }
    }
    
    // MARK: Manage contents (photo / movie)
    func gatherDataFromPickedContents(index: Int, pickerType: PickerType, pickedResults: [String:PHPickerResult], selectedIdentifiers: [String], contentsMetaData: [String:PHAsset], contentsData: [String:Data], success: ((_ pickedResults: [String:PHPickerResult], _ selectedIdentifiers: [String], _ contentsData: [String:Data], _ contentMetaData: [String:PHAsset]) -> ())?, failure: (() -> ())?) {
        var index = index
        let count = selectedIdentifiers.count
        var contentsData = contentsData
        
        guard index < count else {
            DispatchQueue.main.async {
                success?(pickedResults, selectedIdentifiers, contentsData, contentsMetaData)
            }
            
            return
        }
        
        if pickerType == .image {
            if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    if let self = self, let image = image as? UIImage, let imageData = image.fixedOrientaion.jpegData(compressionQuality: 0.1) {
                        DispatchQueue.main.async {
                            contentsData.updateValue(imageData, forKey: selectedIdentifiers[index])
                            
                            index += 1
                            self.gatherDataFromPickedContents(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, success: success, failure: failure)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else if let itemProvider = (pickedResults[selectedIdentifiers[index]])?.itemProvider, itemProvider.hasItemConformingToTypeIdentifier(UTType.webP.identifier) {
                itemProvider.loadDataRepresentation(forTypeIdentifier: UTType.webP.identifier) { data, error in
                    if let data = data, let _ = UIImage(data: data) {
                        DispatchQueue.main.async {
                            contentsData.updateValue(data, forKey: selectedIdentifiers[index])
                            
                            index += 1
                            self.gatherDataFromPickedContents(index: index, pickerType: pickerType, pickedResults: pickedResults, selectedIdentifiers: selectedIdentifiers, contentsMetaData: contentsMetaData, contentsData: contentsData, success: success, failure: failure)
                        }
                        
                    } else {
                        DispatchQueue.main.async {
                            failure?()
                        }
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    failure?()
                }
            }
            
        }
    }
}

extension CALayer {
    func useSketchShadow(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOpacity = alpha
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = blur / 2.0
        
        if spread == 0 {
            self.shadowPath = nil
            
        } else {
            let dx = -spread
            let rect = self.bounds.insetBy(dx: dx, dy: dx)
            self.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func useSketchShadow(color: UIColor, alpha: Float, shadowSize: CGFloat, viewSize: CGSize) {
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: viewSize.width + shadowSize,
                                                   height: viewSize.height + shadowSize))
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.shadowOpacity = alpha
        self.shadowPath = shadowPath.cgPath
    }
}

// MARK: UIFont
extension UIFont {
    enum PretendardFontType: String {
        case Black
        case Bold
        case ExtraBold
        case ExtraLight
        case Light
        case Medium
        case Regular
        case SemiBold
        case Thin
    }
    class func useFont(ofSize size: CGFloat, weight: PretendardFontType) -> UIFont {
        return UIFont(name: "PretendardVariable-\(weight.rawValue)", size: size)!
    }
}

// MARK: UIColor to be possible to get color using 0 ~ 255 integer
extension UIColor {
    class func useRGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / CGFloat(255), green: green / CGFloat(255), blue: blue / CGFloat(255), alpha: alpha)
    }
}

extension UIImage {
    var fixedOrientaion: UIImage {
        if self.imageOrientation == .up {
                return self
            }
        
            var transform: CGAffineTransform = CGAffineTransform.identity
            switch self.imageOrientation {
            case .down, .downMirrored:
                transform = transform.translatedBy(x: self.size.width, y: self.size.height)
                transform = transform.rotated(by: CGFloat(Double.pi))
                
            case .left, .leftMirrored:
                transform = transform.translatedBy(x: self.size.width, y: 0)
                transform = transform.rotated(by: CGFloat(Double.pi / 2))
                
            case .right, .rightMirrored:
                transform = transform.translatedBy(x: 0, y: self.size.height)
                transform = transform.rotated(by: CGFloat(-(Double.pi / 2)))
            default: // .up, .upMirrored
                break
            }

            switch self.imageOrientation {
            case .upMirrored, .downMirrored:
                //transform.translatedBy(x: self.size.width, y: 0)
                //transform.scaledBy(x: -1, y: 1)
                CGAffineTransformTranslate(transform, size.width, 0)
                CGAffineTransformScale(transform, -1, 1)
                
            case .leftMirrored, .rightMirrored:
                //transform.translatedBy(x: self.size.height, y: 0)
                //transform.scaledBy(x: -1, y: 1)
                CGAffineTransformTranslate(transform, size.height, 0)
                CGAffineTransformScale(transform, -1, 1)
                
            default: // .up, .down, .left, .right
                break
            }

            let ctx:CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: (self.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (self.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!

            ctx.concatenate(transform)

            switch self.imageOrientation {
            case .left, .leftMirrored, .right, .rightMirrored:
                ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
                
            default:
                ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
            }

            let cgimg:CGImage = ctx.makeImage()!
            let img:UIImage = UIImage(cgImage: cgimg)

            return img
    }
}

enum VerticalLocation {
    case bottom
    case top
    case left
    case right
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.3, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 0.5), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -0.5), color: color, opacity: opacity, radius: radius)
        case .left:
            addShadow(offset: CGSize(width: -0.5, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            addShadow(offset: CGSize(width: 0.5, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 3.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

// MARK: - View Protocol
protocol EssentialViewMethods {
    func setViewFoundation()
    func initializeObjects()
    func setDelegates()
    func setGestures()
    func setNotificationCenters()
    func setSubviews()
    func setLayouts()
    func setViewAfterTransition()
}

// MARK: - Cell & Header Protocol
protocol EssentialCellHeaderMethods {
    func setViewFoundation()
    func initializeObjects()
    func setSubviews()
    func setLayouts()
}
