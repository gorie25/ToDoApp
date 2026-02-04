//
//  TaskStatus.swift
//  ToDos
//
//  Created by TienTruong on 31/01/2025.
//

enum TaskStatus: String, Codable, CaseIterable {
    case created     // ToDo
    case doing       // In Progress
    case done        // Done
    
    var title: String {
        switch self {
        case .created: return "To Do"
        case .doing: return "In Progress"
        case .done: return "Done"
        }
    }
    
    var systemImage: String {
        switch self {
        case .created: return "circle"
        case .doing: return "clock"
        case .done: return "checkmark.circle.fill"
        }
    }
}
