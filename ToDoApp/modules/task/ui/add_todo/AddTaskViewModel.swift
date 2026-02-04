//
//  AddTaskViewModel.swift
//  ToDos
//
//  Created by TienTruong on 04/02/2026.
//

import Foundation
import Observation

@Observable
final class AddTaskViewModel {
    var title = ""
    var details = ""
    var selectedGroup: TaskGroup?
    var status: TaskStatus = .created
    var dueDate = Date()
    var taskGroups: [TaskGroup] = []
    
 
    var isValid: Bool {
        !title.isEmpty && selectedGroup != nil
    }
    

    func save() {
        guard let group = selectedGroup else { return }
        
        let task = Task(title: title, details: details, status: status, dueDate: dueDate)
        
        if status == .doing {
            task.startedAt = Date()
        }
        
        group.tasks.append(task)
    }
}
