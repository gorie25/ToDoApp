//
//  TaskRepositoryImpl.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation

struct TaskRepositoryImpl: TaskRepository {
    private let localDataSource: TaskLocalDataSource
    // private let remoteDataSource: TaskRemoteDataSource
    
    init(localDataSource: TaskLocalDataSource = TaskLocalDataSourceImpl()) {
        self.localDataSource = localDataSource
    }
    
    func getTasks() async throws -> [Task] {
        return try await localDataSource.getTasks()
        //Mock Get API
        //return try await remoteDataSource.getTasks()
    }
    
    func createTask(title: String, details: String?, status: TaskStatus, dueDate: Date?) async throws -> Task {
        let task = Task(
            title: title,
            details: details,
            status: status,
            dueDate: dueDate
        )
        return try await localDataSource.createTask(task)
        //Mock Get API
//        let request = TaskRequestDTO(
//            title: title,
//            details: details,
//            status: status,
//            dueDate: dueDate
//        )
//        return try await remoteDataSource.createTask(request)
    }

    func deleteTask(id: String) async throws {
        try await localDataSource.deleteTask(id: id)
        //Mock Get API
        //try await remoteDataSource.deleteTask(id: id)
    }
}
