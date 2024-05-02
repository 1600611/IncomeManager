//
//  PersistenceController.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 2/5/24.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "IncomeManager")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Error loading container: \(error), \(error.userInfo)")
            }
        }
    }
}
