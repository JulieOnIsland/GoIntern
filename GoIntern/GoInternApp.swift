//
//  GoInternApp.swift
//  GoIntern
//
//  Created by Lee Juhyun on 4/15/25.
//

import SwiftData
import SwiftUI
import WidgetKit

@main
struct GoInternApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Application.self, Message.self])
    }
}
