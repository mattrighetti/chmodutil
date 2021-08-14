//
//  chmodutilApp.swift
//  Shared
//
//  Created by Mattia Righetti on 14/08/21.
//

import SwiftUI

@main
struct chmodutilApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            RwxToIntView_macOS()
            #else
            RwxToIntView_iOS()
            #endif
        }
    }
}
