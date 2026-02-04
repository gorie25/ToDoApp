//
//  TaskRemoteDataSource.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation

protocol TaskRemoteDataSource {
    func getTasks() async throws -> [Task]
    func createTask(_ textRequest: TaskRequestDTO) async throws -> Task
    func deleteTask(id: String) async throws
}

struct TaskRemoteDataSourceImpl: TaskRemoteDataSource {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getTasks() async throws -> [Task] {
        let response = try await networkClient.request(TaskService.getTasks())
        return response.map { dto in
            Task(
                title: dto.title,
                details: dto.details,
                status: dto.status,
                dueDate: dto.dueDate
            )
        }
    }
    
    func createTask(_ request: TaskRequestDTO) async throws -> Task {
        let dto = try await networkClient.request(TaskService.createTask(request))
        
        return Task(
            title: dto.title,
            details: dto.details,
            status: dto.status,
            dueDate: dto.dueDate
        )
    }

    func deleteTask(id: String) async throws {
        _ = try await networkClient.request(TaskService.deleteTask(id: id))
    }
}
