//
//  AppDelegate.swift
//  RPATest
//
//  Created by 이주성 on 2023/05/04.
//

import UIKit
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        // FCM 등록 토큰 확인
        Messaging.messaging().token { (token, error) in
            if let error = error {
                print("Error FCM 등록토큰 가져오기: \(error.localizedDescription)")
            } else if let token = token {
                print("FCM 등록토큰: \(token)")
                UserInfo.shared.fcmToken = token
                
            }
        }
        
        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("")
        print("===============================")
        print("[AppDelegate >> willPresent]")
        print("설명 :: 앱 포그라운드 상태 푸시 알림 확인")
        print("userInfo :: \(notification.request.content.userInfo)") // 푸시 정보 가져옴
        print("title :: \(notification.request.content.title)") // 푸시 정보 가져옴
        print("body :: \(notification.request.content.body)") // 푸시 정보 가져옴
        print("===============================")
        print("")
        
        // [SEARCH FAST] : [AppDelegate 포그라운드 푸시 메시지 송신]
        DispatchQueue.main.async {
            print("")
            print("===============================")
            print("[AppDelegate >> willPresent]")
            print("설명 :: 노티피케이션 알림 송신")
            print("===============================")
            print("")
        }
        
        completionHandler([.list, .banner, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("[AppDelegate >> didReceive]")
        print("앱 백그라운드 상태 푸시 알림 확인")
        
        completionHandler()
    }
}

// MARK: - Extension for MessagingDelegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else { return }
        print("FCM 등록토큰 갱신: \(token)")
        UserInfo.shared.fcmToken = token
    }
}
