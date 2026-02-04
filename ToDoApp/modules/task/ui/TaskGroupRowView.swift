//
//  TaskGroupRowView.swift
//  ToDos
//
//  Created by TienTruong on 31/01/2025.
//

import SwiftUI
import SwiftData

struct TaskGroupRowView: View {
    @Bindable var taskGroup: TaskGroup
    
    var body: some View {
        HStack {
            groupIcon
            Text(taskGroup.name)
            Spacer()
            Text("\(taskGroup.tasks.count)")
        }
    }
    
    var groupIcon: some View {
        ZStack {
            Circle()
                .fill(.primary)
                .frame(width: 27)
            Image(systemName: taskGroup.iconName)
                .font(.footnote)
                .foregroundColor(.white)
                .bold()
        }
    }
}
