
import SwiftUI
import FirebaseCore

// MARK: - UpTodoApp

/// Entry point of the UpTodo application.
///
/// Responsible for configuring Firebase
/// and loading the application's root view.
@main
struct UpTodoApp: App {

    // MARK: Initializer

    init() {

        FirebaseApp.configure()
    }

    // MARK: Body

    var body: some Scene {

        WindowGroup {

            AppRootView()
        }
    }
}
