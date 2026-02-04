//
//  TaskLocalDatasource.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation
import SwiftData

protocol TaskLocalDataSource {
    func getTasks() async throws -> [Task]
    func getTaskGroups() async throws -> [TaskGroup]
    func createTask(_ task: Task) async throws -> Task
    func deleteTask(id: String) async throws
}

final class TaskLocalDataSourceImpl: TaskLocalDataSource {
    private let modelContainer: ModelContainer
    
    init(modelContainer: ModelContainer = CoreDataService.shared.modelContainer) {
        self.modelContainer = modelContainer
    }
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getTasks() async throws -> [Task] {
        let descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try context.fetch(descriptor)
    }
    
    @MainActor
    func getTaskGroups() async throws -> [TaskGroup] {
        let descriptor = FetchDescriptor<TaskGroup>()
        return try context.fetch(descriptor)
    }
    
    @MainActor
    func createTask(_ task: Task) async throws -> Task {
        context.insert(task)
        try context.save()
        return task
    }
    
    @MainActor
    func deleteTask(id: String) async throws {
        let descriptor = FetchDescriptor<Task>(predicate: #Predicate { $0.id == id })
        if let task = try context.fetch(descriptor).first {
             context.delete(task)
             try context.save()
        }
    }
}
