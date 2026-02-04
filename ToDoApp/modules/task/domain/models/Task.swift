//
//  Task.swift
//  ToDos
//
//  Created by TienTruong on 31/01/2025.
//

import Foundation
import SwiftData

@Model
final class Task {
    @Attribute(.unique)
    var id: String
    var title: String
    var details: String?
    var status: TaskStatus = .created
    var dueDate: Date?
    var createdAt: Date
    var updatedAt: Date?
    var startedAt: Date?
    var completedAt: Date?
    
    init(
        id: String = UUID().uuidString,
        title: String,
        details: String? = nil,
        status: TaskStatus = .created,
        dueDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.details = details
        self.status = status
        self.dueDate = dueDate
        self.createdAt = Date()
    }
}
