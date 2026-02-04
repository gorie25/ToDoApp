//
//  TaskRequestDTO.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation

struct TaskRequestDTO: Encodable {
    let title: String
    let details: String?
    let status: TaskStatus
    let dueDate: Date?
}
