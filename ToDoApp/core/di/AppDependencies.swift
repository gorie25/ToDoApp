//
//  AppDependencies.swift
//  ToDos
//
//  Created by TienTruong on 04/02/2026.
//

import Foundation

final class AppDependencies {
    static let shared = AppDependencies()
    
    let networkClient: NetworkClient
    let taskRepository: TaskRepository
    let deleteTaskUseCase: DeleteTaskUseCase
    let getTaskGroupsUseCase: GetTaskGroupsUseCase
    
    private init() {
        let baseURL = AppConfiguration.shared.apiBaseURL
        
        self.networkClient = NetworkClientImpl(baseURL: baseURL)
        self.taskRepository = TaskRepositoryImpl()
        self.deleteTaskUseCase = DeleteTaskUseCaseImpl(repository: self.taskRepository)
        self.getTaskGroupsUseCase = GetTaskGroupsUseCaseImpl(repository: self.taskRepository)
    }
}
