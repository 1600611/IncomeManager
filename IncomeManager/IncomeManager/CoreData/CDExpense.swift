//
//  CDExpense.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation
import CoreData

extension CDExpense {
    static func fetch(on date: Date, categoryType: CategoryType) -> [CDExpense] {
        let fetchRequest: NSFetchRequest<CDExpense> = CDExpense.fetchRequest()
        
        let calendar = Calendar.current
        let monthAndYearComponents = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: monthAndYearComponents)!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@ AND categoryType == %@", startOfMonth as NSDate, endOfMonth as NSDate, categoryType.rawValue)
        
        do {
            let context = PersistenceController.shared.container.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching expenses: \(error.localizedDescription)")
            return []
        }
    }
    
    static func fetch(on date: Date, expenseType: ExpenseType) -> [CDExpense] {
        let fetchRequest: NSFetchRequest<CDExpense> = CDExpense.fetchRequest()
        
        let calendar = Calendar.current
        let monthAndYearComponents = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: monthAndYearComponents)!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@ AND type == %@", startOfMonth as NSDate, endOfMonth as NSDate, expenseType.rawValue)
        
        do {
            let context = PersistenceController.shared.container.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching expenses: \(error.localizedDescription)")
            return []
        }
    }
    
    static func save(amount: Decimal, comment: String, date: Date, categoryType: CategoryType, type: ExpenseType) {
        let context = PersistenceController.shared.container.viewContext
        let newExpense = CDExpense(context: context)
        newExpense.id = UUID()
        newExpense.amount = NSDecimalNumber(decimal: amount)
        newExpense.comment = comment
        newExpense.date = date
        newExpense.categoryType = categoryType.rawValue
        newExpense.type = type.rawValue
        
        do {
            try context.save()
        } catch {
            print("Error saving expense: \(error.localizedDescription)")
        }
    }
    
    static func delete(id: UUID) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<CDExpense> = CDExpense.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let expenses = try context.fetch(fetchRequest)
            if let expenseToDelete = expenses.first {
                context.delete(expenseToDelete)
                
                do {
                    try context.save()
                } catch {
                    print("Error saving context after deleting expense: \(error.localizedDescription)")
                }
            } else {
                print("No expense found with the provided id.")
            }
        } catch {
            print("Error fetching expense: \(error.localizedDescription)")
        }
    }
}
