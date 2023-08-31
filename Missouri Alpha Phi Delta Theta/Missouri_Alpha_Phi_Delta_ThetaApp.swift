//
//  Missouri_Alpha_Phi_Delta_ThetaApp.swift
//  Missouri Alpha Phi Delta Theta
//
//  Created by Luke Schaefer on 8/2/22.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseMessaging
import UserNotifications


class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

      FirebaseApp.configure()

      Messaging.messaging().delegate = self
      UNUserNotificationCenter.current().delegate = self

      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
          guard success else {
              return
          }
          print("Success in APNs registry")

      }

      application.registerForRemoteNotifications()

      return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FirebaseApp.configure()
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("Token: \(token)")
        }
    }
}


@main
struct Missouri_Alpha_Phi_Delta_ThetaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
 
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    if sessionService.userDetails?.activeStatus == "active" {
                        HomeView()
                            .environmentObject(sessionService)
                            .environmentObject(FirebaseDBServiceImpl())
                    } else {
                        InActiveView()
                            .environmentObject(sessionService)
                    }
                    
                case .loggedOut:
                    LoginView()
                }

            }
        }
    }
}
