import SwiftUI

@main
struct chmodutilApp: App {
    var body: some Scene {
        WindowGroup {
            PermissionsView()
                #if os(macOS)
                .frame(minWidth: 340, minHeight: 340)
                #endif
        }
        #if os(macOS)
        .defaultSize(width: 420, height: 380)
        #endif
    }
}
