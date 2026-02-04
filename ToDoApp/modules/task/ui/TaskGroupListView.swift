//
//  TaskGroupListView.swift
//  ToDos
//
//  Created by TienTruong on 31/01/2025.
//

import SwiftUI
import SwiftData

struct TaskGroupListView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var taskGroup: TaskGroup
    @State private var showAddTask = false
    
    // Dependency
    private let deleteTaskUseCase: DeleteTaskUseCase
    
    init(taskGroup: TaskGroup, deleteTaskUseCase: DeleteTaskUseCase) {
        self.taskGroup = taskGroup
        self.deleteTaskUseCase = deleteTaskUseCase
    }
    
    var body: some View {
        List {
            ForEach(TaskStatus.allCases, id: \.self) { status in
                let filtered = taskGroup.tasks.filter { $0.status == status }
                
                if !filtered.isEmpty {
                    Section(status.title) {
                        ForEach(filtered) { task in
                            TaskRowView(task: task)
                        }
                        .onDelete { indexSet in
                            deleteTask(at: indexSet, in: filtered)
                        }
                    }
                }
            }
        }
        .navigationTitle(taskGroup.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    showAddTask = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
        }
        .sheet(isPresented: $showAddTask) {
            NavigationStack {
                AddTaskView(taskGroups: [taskGroup])
            }
        }
    }
    
    private func deleteTask(at offsets: IndexSet, in tasks: [Task]) {
        for offset in offsets {
            let taskToDelete = tasks[offset]
            
            // Delete remote
            Task {
                do {
                    try await deleteTaskUseCase.execute(id: taskToDelete.id)
                } catch {
                    print("Error deleting task: \(error)")
                    // Handle error (e.g. show alert)
                }
            }
            
            // Delete local
            if let index = taskGroup.tasks.firstIndex(where: { $0.id == taskToDelete.id }) {
                taskGroup.tasks.remove(at: index)
            }
            modelContext.delete(taskToDelete)
        }
    }
}

struct TaskRowView: View {
    @Bindable var task: Task
    
    var body: some View {
        HStack(spacing: 12) {
            // Status indicator circle
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
            
            VStack(alignment: .leading, spacing: 4) {
                // Task title
                Text(task.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                // Task details
                if let details = task.details, !details.isEmpty {
                    Text(details)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
                
                // Time display
                if let dueDate = task.dueDate {
                    Text(timeString(from: dueDate))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            // Status chip
            statusChip
        }
        .padding(.vertical, 8)
    }
    
    private var statusChip: some View {
        Button(action: toggleStatus) {
            Text(task.status.title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(statusColor)
                .cornerRadius(12)
        }
    }
    
    private var statusColor: Color {
        switch task.status {
        case .created: return Color.blue
        case .doing: return Color.purple
        case .done: return Color.green
        }
    }
    
    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    private func toggleStatus() {
        switch task.status {
        case .created:
            task.status = .doing
            task.startedAt = Date()
        case .doing:
            task.status = .done
            task.completedAt = Date()
        case .done:
            task.status = .created
            task.completedAt = nil
        }
        task.updatedAt = Date()
    }
}
