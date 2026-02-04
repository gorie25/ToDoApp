//
//  DeleteTaskUseCase.swift
//  ToDos
//
//  Created by TienTruong on 04/02/2026.
//

import Foundation

protocol DeleteTaskUseCase {
    func execute(id: String) async throws
}

struct DeleteTaskUseCaseImpl: DeleteTaskUseCase {
    private let repository: TaskRepository
    
    init(repository: TaskRepository) {
        self.repository = repository
    }
    
    func execute(id: String) async throws {
        try await repository.deleteTask(id: id)
    }
}
