//
//  CDExpense.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation
import CoreData

extension CDExpense {
    static func fetchExpenses(on date: Date, categoryType: CategoryType) -> [CDExpense] {
        let fetchRequest: NSFetchRequest<CDExpense> = CDExpense.fetchRequest()
        
        // Create date range for the given day
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@ AND categoryType == %@", startOfDay as NSDate, endOfDay as NSDate, categoryType.rawValue)
        
        do {
            let context = PersistenceController.shared.container.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching expenses: \(error.localizedDescription)")
            return []
        }
    }
    
    static func fetchExpenses(on date: Date, expenseType: ExpenseType) -> [CDExpense] {
        let fetchRequest: NSFetchRequest<CDExpense> = CDExpense.fetchRequest()
        
        // Create date range for the given day
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@ AND type == %@", startOfDay as NSDate, endOfDay as NSDate, expenseType.rawValue)
        
        do {
            let context = PersistenceController.shared.container.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching expenses: \(error.localizedDescription)")
            return []
        }
    }
}
