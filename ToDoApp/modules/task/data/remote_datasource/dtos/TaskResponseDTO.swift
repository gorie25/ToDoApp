//
//  TaskResponseDTO.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation

struct TaskResponseDTO: Decodable {
    let id: String?
    let title: String
    let details: String?
    let status: TaskStatus
    let dueDate: Date?
    let createdAt: Date
    let updatedAt: Date?
    let startedAt: Date?
    let completedAt: Date?
}
