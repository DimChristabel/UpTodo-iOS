//
//  upToDoApp.swift
//  upToDo
//
//  Created by Maxut Consulting on 26/05/2026.
//

//import SwiftUI
//import Firebase
//
//@main
//struct upToDoApp: App {
//    
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    @AppStorage("hasOnboarded") var hasOnboarded = false
//    @State private var showSplash = true
//    
//    var body: some Scene {
//        WindowGroup {
//            if showSplash {
//                // Show splash/intro for 2 seconds
//                Intro()
//                    .onAppear {
//                        UserDefaults.standard.set(false, forKey: "hasOnboarded")
//                        DispatchQueue.main.asyncAfter(
//                            deadline: .now() + 2.0
//                        ) {
//                            withAnimation {
//                                showSplash = false
//                            }
//                        }
//                    }
//            } else if hasOnboarded {
//                // User has seen onboarding before → go to Login
//                StartView()
//            } else {
//                // First time user → show Onboarding
//                OnboardingView()
//            }
//        }
//    }
//}
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions:
//                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}
//
//



import SwiftUI
import Firebase

@main
struct upToDoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("hasOnboarded") var hasOnboarded = false
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                // Show splash/intro for 2 seconds
                Intro()
                    .onAppear {
                        UserDefaults.standard.set(false, forKey: "hasOnboarded")
                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + 2.0
                        ) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                // TEMPORARY — go straight to HomeView for testing
                // TODO: put back auth flow when Firebase is connected
                NavigationStack {
                    MainTabView()
                }
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}







