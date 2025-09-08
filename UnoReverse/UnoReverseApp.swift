import SwiftUI

@main
struct UnoReverseApp: App {
    @Environment(\.colorScheme) var colorScheme

    var body: some Scene {
        WindowGroup {
            ContentView(initialColorScheme: colorScheme)
        }
    }
}
