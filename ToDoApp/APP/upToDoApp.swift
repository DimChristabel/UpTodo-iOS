

import SwiftUI

// MARK: - UpTodoApp

/// Entry point of the UpTodo application.
///
/// Responsible for launching the app and
/// loading the root navigation container.
@main
struct UpTodoApp: App {

    // MARK: Body

    var body: some Scene {

        WindowGroup {

            AppRootView()
        }
    }
}
