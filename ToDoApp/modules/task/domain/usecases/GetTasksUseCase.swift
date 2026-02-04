//
//  GetTasksUseCase.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation

protocol GetTasksUseCase {
    func execute() async throws -> [Task]
}

struct GetTasksUseCaseImpl: GetTasksUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Task] {
        return try await repository.getTasks()
    }
}
