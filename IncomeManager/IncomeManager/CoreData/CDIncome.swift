//
//  CDIncome.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 7/5/24.
//

import Foundation
import CoreData

extension CDIncome {
    
    static func fetch(_ date: Date) -> CDIncome? {
        
        // Create a fetch request to check if the income with the given month and year already exist
        let calendar = Calendar.current
        let monthAndYearComponents = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: monthAndYearComponents)!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let fetchRequest: NSFetchRequest<CDIncome> = CDIncome.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startOfMonth as NSDate, endOfMonth as NSDate)
        
        do {
            let context = PersistenceController.shared.container.viewContext
            let incomes = try context.fetch(fetchRequest)
            return incomes.first
        } catch {
            print("Error fetching income: \(error.localizedDescription)")
            return nil
        }
    }
    
    static func saveOrUpdate(income: Decimal, date: Date) {
        let context = PersistenceController.shared.container.viewContext

        // First, try to fetch the income for the provided date
        if let existingIncome = fetch(date) {
            // If an income already exists for this date, update the amount
            existingIncome.amount = NSDecimalNumber(decimal: income)
        } else {
            // If there is no income for this date, create a new one and save it
            let newIncome = CDIncome(context: context)
            newIncome.amount = NSDecimalNumber(decimal: income)
            newIncome.date = date
        }

        // Save the changes to the context
        do {
            try context.save()
        } catch {
            print("Error saving income: \(error.localizedDescription)")
        }
    }

}
