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
            let dependencies = AppDependencies.shared
            let viewModel = HomeViewModel(
                getTaskGroupsUseCase: dependencies.getTaskGroupsUseCase,
                deleteTaskUseCase: dependencies.deleteTaskUseCase
            )
            HomeView(viewModel: viewModel)
        }
        .modelContainer(CoreDataService.shared.modelContainer)
    }
}
