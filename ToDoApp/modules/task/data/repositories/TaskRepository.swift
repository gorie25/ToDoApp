//
//  TaskRepository.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation

protocol TaskRepository {
    func getTasks() async throws -> [Task]
    func createTask(title: String, details: String?, status: TaskStatus, dueDate: Date?) async throws -> Task
    func deleteTask(id: String) async throws
}
