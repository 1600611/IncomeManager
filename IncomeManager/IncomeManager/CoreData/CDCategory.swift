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
    
    static func fetch(_ predicate: NSPredicate) -> NSFetchRequest<CDCategory> {
        let request = CDCategory.fetchRequest()
        return request
    }
    
    static func saveOrUpdate(categoryInformations: [CategoryInformation], date: Date) {
        let context = PersistenceController.shared.container.viewContext
        
        do {
            // Create a fetch request to check if categories with the given date and category type already exist
            let fetchRequest: NSFetchRequest<CDCategory> = CDCategory.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "date == %@", date as NSDate)

            // Fetch existing categories based on the predicate
            let existingCategories = try context.fetch(fetchRequest)

            // Create a dictionary to map category types to existing categories
            var existingCategoriesMap: [String: CDCategory] = [:]
            for category in existingCategories {
                if let categoryType = category.categoryType {
                    existingCategoriesMap[categoryType] = category
                }
            }

            // Iterate over the category informations and update or create categories accordingly
            for categoryInformation in categoryInformations {
                if let existingCategory = existingCategoriesMap[categoryInformation.categoryType.rawValue] {
                    // If the category already exists, update its percentage and spent attributes
                    existingCategory.percentage = Int16(categoryInformation.percentage)
                    existingCategory.spent = categoryInformation.getSpentValue() as NSDecimalNumber
                } else {
                    // If the category does not exist, create a new instance and set its attributes
                    let newCategory = CDCategory(context: context)
                    newCategory.categoryType = categoryInformation.categoryType.rawValue
                    newCategory.date = date
                    newCategory.percentage = Int16(categoryInformation.percentage)
                    newCategory.spent = categoryInformation.getSpentValue() as NSDecimalNumber
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
