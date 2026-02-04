//
//  AddTaskView.swift
//  ToDos
//
//  Created by TienTruong on 31/01/2025.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    
    let taskGroups: [TaskGroup]
    
    @State private var title = ""
    @State private var details = ""
    @State private var selectedGroup: TaskGroup?
    @State private var status: TaskStatus = .created
    @State private var dueDate = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Text("Add Project")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Button(action: { dismiss() }) {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Task Group Selector
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Task Group", systemImage: "person.crop.circle.fill")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Menu {
                            ForEach(taskGroups) { group in
                                Button(action: { selectedGroup = group }) {
                                    HStack {
                                        Image(systemName: group.iconName)
                                        Text(group.name)
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                if let group = selectedGroup {
                                    Image(systemName: group.iconName)
                                        .foregroundColor(.blue)
                                    Text(group.name)
                                        .foregroundColor(.primary)
                                } else {
                                    Text("Select Group")
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                        }
                    }
                    
                    // Task Name
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Project Name", systemImage: "briefcase.fill")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        TextField("Enter task name", text: $title)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                    
                    // Description
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Description", systemImage: "doc.text.fill")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        TextEditor(text: $details)
                            .frame(minHeight: 100)
                            .padding(8)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                            .overlay(
                                Group {
                                    if details.isEmpty {
                                        Text("This project is designed by team client. Our team responsible to implement user interface and conduct...")
                                            .foregroundColor(.gray)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 16)
                                            .allowsHitTesting(false)
                                    }
                                },
                                alignment: .topLeading
                            )
                    }
                    
                    // Due Date
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Start Date", systemImage: "calendar")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        DatePicker("", selection: $dueDate, displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                    
                    // End Date
                    VStack(alignment: .leading, spacing: 12) {
                        Label("End Date", systemImage: "calendar")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        DatePicker("", selection: $dueDate, displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                    }
                    
                    // Badge/Group chip (Grocery branding)
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Badge", systemImage: "person.crop.circle.fill")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 12) {
                            // Team member avatar
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 40, height: 40)
                                .overlay(
                                    Text("G")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                )
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Grocery")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Shopping App")
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Text("Change Logo")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.purple)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            
            // Save Button
            Button(action: save) {
                Text("Save")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.purple, Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
            .padding()
            .disabled(title.isEmpty || selectedGroup == nil)
            .opacity((title.isEmpty || selectedGroup == nil) ? 0.5 : 1)
        }
        .navigationBarHidden(true)
    }
    
    private func save() {
        guard let group = selectedGroup else { return }
        
        let task = Task(title: title, details: details, status: status, dueDate: dueDate)
        
        if status == .doing {
            task.startedAt = Date()
        }
        
        group.tasks.append(task)
        dismiss()
    }
}
