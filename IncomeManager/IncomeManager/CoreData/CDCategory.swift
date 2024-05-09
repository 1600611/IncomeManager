//
//  CDCategory.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 2/5/24.
//

import Foundation
import CoreData

extension CDCategory {
    
    static func deleteAll() {
        let context = PersistenceController.shared.container.viewContext
        
        do {
            // Create a batch delete request for the CDCategory entity
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDCategory.fetchRequest()
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            // Execute the batch delete request
            try context.execute(batchDeleteRequest)
        } catch {
            // Handle any errors that occur during the deletion process
            print("Error deleting categories: \(error.localizedDescription)")
        }
    }
    
    static func fetch(_ date: Date) -> [CDCategory] {
        
        // Create a fetch request to check if categories with the given month and year already exist
        let calendar = Calendar.current
        let monthAndYearComponents = calendar.dateComponents([.year, .month], from: date)
        let startOfMonth = calendar.date(from: monthAndYearComponents)!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        let fetchRequest: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", startOfMonth as NSDate, endOfMonth as NSDate)
        
        let sortDescriptor = NSSortDescriptor(key: "percentage", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let context = PersistenceController.shared.container.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
            return []
        }
    }
    
    static func saveOrUpdate(categories: [Category], date: Date) {
        let context = PersistenceController.shared.container.viewContext
        
        do {
            let existingCategories = fetch(date)

            // Create a dictionary to map category types to existing categories
            var existingCategoriesMap: [String: CDCategory] = [:]
            for category in existingCategories {
                if let categoryType = category.categoryType {
                    existingCategoriesMap[categoryType] = category
                }
            }

            // Iterate over the category informations and update or create categories accordingly
            for category in categories {
                if let existingCategory = existingCategoriesMap[category.getCategoryType().rawValue] {
                    // If the category already exists, update its percentage and spent attributes
                    existingCategory.percentage = Int16(category.getPercentage())
                    existingCategory.spent = category.getSpentValue() as NSDecimalNumber
                } else {
                    // If the category does not exist, create a new instance and set its attributes
                    let newCategory = CDCategory(context: context)
                    newCategory.categoryType = category.getCategoryType().rawValue
                    newCategory.date = date
                    newCategory.percentage = Int16(category.getPercentage())
                    newCategory.spent = category.getSpentValue() as NSDecimalNumber
                }
            }

            // Save the context to persist the changes
            try context.save()
        } catch {
            // Handle any errors that occur during the saving or updating process
            print("Error saving or updating categories: \(error.localizedDescription)")
        }
    }
}
