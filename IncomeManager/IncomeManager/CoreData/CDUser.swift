//
//  CDUser.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 4/6/24.
//

import Foundation
import CoreData

extension CDUser {
    static func fetch() -> CDUser? {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        
        do {
            let context = PersistenceController.shared.container.viewContext
            return try context.fetch(fetchRequest).first
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func save(lightTheme: Bool) {
        let context = PersistenceController.shared.container.viewContext
        let newUser = CDUser(context: context)
        newUser.lightTheme = lightTheme
        
        do {
            try context.save()
        } catch {
            print("Error saving user: \(error.localizedDescription)")
        }
    }
}
