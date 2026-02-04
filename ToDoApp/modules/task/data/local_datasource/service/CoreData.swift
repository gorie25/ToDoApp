//
//  CoreData.swift
//  ToDos
//
//  Created by TienTruong on 03/02/2026.
//

import Foundation
import SwiftData

final class CoreDataService {
    static let shared = CoreDataService()
    
    let modelContainer: ModelContainer
    
    @MainActor
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([
            TaskGroup.self,
            Task.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
