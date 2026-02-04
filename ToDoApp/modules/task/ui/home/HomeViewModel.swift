//
//  HomeViewModel.swift
//  ToDos
//
//  Created by TienTruong on 04/02/2026.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    var selectedDate = Date()
    var selectedFilter: TaskStatus? = nil
    var showAddTask = false
    var taskGroups: [TaskGroup] = []
    
    private let getTaskGroupsUseCase: GetTaskGroupsUseCase
    private let deleteTaskUseCase: DeleteTaskUseCase
    
    init(
        getTaskGroupsUseCase: GetTaskGroupsUseCase,
        deleteTaskUseCase: DeleteTaskUseCase
    ) {
        self.getTaskGroupsUseCase = getTaskGroupsUseCase
        self.deleteTaskUseCase = deleteTaskUseCase
    }
    
    @MainActor
    func fetchData() async {
        do {
            taskGroups = try await getTaskGroupsUseCase.execute()
        } catch {
            print("Error fetching task groups: \(error)")
        }
    }
    
    func filteredTasks(from groups: [TaskGroup]) -> [Task] {
        var allTasks: [Task] = []
        for group in groups {
            allTasks.append(contentsOf: group.tasks)
        }
        
        if let filter = selectedFilter {
            return allTasks.filter { $0.status == filter }
        }
        return allTasks
    }
    
    @MainActor
    func deleteTask(at offsets: IndexSet, from tasks: [Task], in groups: [TaskGroup]) async {
        let tasksToDelete = offsets.map { tasks[$0] }
        
        for task in tasksToDelete {
            do {
                try await deleteTaskUseCase.execute(id: task.id)
            } catch {
                print("Error deleting task: \(error)")
            }
        }
        
        // Refresh data after deletion
        await fetchData()
    }
}
