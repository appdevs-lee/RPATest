//
//  Camera.swift
//  CustomCamera
//
//  Created by Awesomepia on 1/23/24.
//

import AVFoundation
import UIKit

final class Camera: NSObject {
    var isFlashOn: Bool = false
    var flashMode: AVCaptureDevice.FlashMode = .off
    
    func switchFlash() {
        self.isFlashOn.toggle()
        
        self.flashMode = self.isFlashOn ? .on : .off
        print("flashStatus: \(self.isFlashOn)")
        
    }
    
    func capturePhoto() {
        // 사진 옵션 세팅
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = self.flashMode
        
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
        
    }
    
    func savePhoto(_ imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // 사진 저장하기
        print("[Camera]: Photo's saved")
    }
    
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    
    func configure() {
        self.requestAndCheckPermissions()
        
    }
    
    func setUpCamera() {
        self.session.beginConfiguration()
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                self.videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if self.session.canAddInput(self.videoDeviceInput) {
                    self.session.addInput(self.videoDeviceInput)
                }
                
                if self.session.canAddOutput(self.output) {
                    self.session.addOutput(self.output)
                    self.output.maxPhotoQualityPrioritization = .quality
                }
                
                self.session.sessionPreset = .photo
                self.session.commitConfiguration()
                
                DispatchQueue.global().async {
                    self.session.startRunning() // 세션 시작
                }
                
            } catch {
                print("setUpCamera Error: \(error)") // 에러 프린트
            }
        }
    }
    
    func requestAndCheckPermissions() {
        // 카메라 권한 상태 확인
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                if authStatus {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            self.setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
        }
    }
    
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.savePhoto(imageData)
        
        print("[CameraModel]: Capture routine's done")
    }
}
