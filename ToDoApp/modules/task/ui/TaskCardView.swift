//
//  TaskGroupCardView.swift
//  ToDos
//
//  Created by TienTruong on 31/01/2025.
//

import SwiftUI
import SwiftData

struct TaskGroupCardView: View {
    @Bindable var taskGroup: TaskGroup
    @State private var linkIsActive = false
    
    var body: some View {
        Button {
            linkIsActive = true
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    groupIcon
                    Spacer()
                    Text("\(taskGroup.tasks.count)")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .padding(.trailing)
                }
                Text(taskGroup.name)
                    .font(.system(.body, design: .rounded, weight: .bold))
                    .foregroundColor(.secondary)
            }
            .padding(5)
            .padding(.horizontal, 5)
            .background(Color(UIColor.tertiarySystemFill))
            .cornerRadius(10)
        }
        .overlay(
            NavigationLink(isActive: $linkIsActive,
                           destination: { 
                               TaskGroupListView(
                                   taskGroup: taskGroup,
                                   deleteTaskUseCase: AppDependencies.shared.deleteTaskUseCase
                               )
                           },
                           label: { EmptyView() }
                          ).opacity(0)
        ).buttonStyle(.plain)
    }
    
    var groupIcon: some View {
        ZStack {
            Circle()
                .frame(width: 27)
            Image(systemName: taskGroup.iconName)
                .font(.footnote)
                .foregroundColor(.white)
                .bold()
        }
    }
}
