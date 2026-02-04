//
//  CreateTaskUseCase.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation

protocol CreateTaskUseCase {
    func execute(title: String, details: String?, status: TaskStatus, dueDate: Date?) async throws -> Task
}

struct CreateTaskUseCaseImpl: CreateTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(title: String, details: String?, status: TaskStatus, dueDate: Date?) async throws -> Task {
        return try await repository.createTask(title: title, details: details, status: status, dueDate: dueDate)
    }
}
