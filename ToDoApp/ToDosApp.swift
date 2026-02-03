//
//  ToDoApp.swift
//  ToDo
//
//  Created by TienTruong on 31/01/2025.
//

import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: ReminderList.self)
    }
}
