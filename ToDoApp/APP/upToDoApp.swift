
import SwiftUI
import FirebaseCore

// MARK: - UpTodoApp

@main
struct UpTodoApp: App {

    init() {

        FirebaseApp.configure()
    }

    var body: some Scene {

        WindowGroup {

            AppRootView()
        }
    }
}
