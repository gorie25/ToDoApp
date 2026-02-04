//
//  TaskGroup.swift
//  ToDos
//
//  Created by TienTruong on 31/01/2025.
//

import Foundation
import SwiftData

@Model
final class TaskGroup {
    var name: String
    var iconName: String
    
    @Relationship(deleteRule: .cascade)
    var tasks: [Task] = []
    
    init(
        name: String = "",
        iconName: String = "list.bullet"
    ) {
        self.name = name
        self.iconName = iconName
    }
}
