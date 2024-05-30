//
//  CoreDataDistributionRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation
import CoreData

class CoreDataCategoryRepository: CategoryRepository {
    
    private var mapper = CategoryMapper()
    
    func fetchCategories(date: Date) -> [Category] {
        let categoriesCD = CDCategory.fetch(date)
        
        if categoriesCD.isEmpty {
            return defaultCategories(date: date)
        }
        
        return categoriesCD.map { categoryCD in
            mapper.map(categoryCD: categoryCD)
        }
    }
    
    func save(categories: [Category], date: Date) {
        CDCategory.saveOrUpdate(categories: categories, date: date)
    }
    
    func updateSpentValue(categoryType: CategoryType, spentValue: Decimal, date: Date) {
        CDCategory.updateSpentValue(categoryType: categoryType.rawValue, spentValue: spentValue, date: date)
    }
    
    func defaultCategories(date: Date) -> [Category] {
        let needsCategory = Category(categoryType: "NEEDS", percentage: 50, spentValue: 0)
        let entertainmentCategory = Category(categoryType: "ENTERTAINMENT", percentage: 30, spentValue: 0)
        let investmentsCategory = Category(categoryType: "INVESTMENTS", percentage: 10, spentValue: 0)
        let savingsCategory = Category(categoryType: "SAVINGS", percentage: 10, spentValue: 0)
        let categories = [needsCategory, entertainmentCategory, investmentsCategory, savingsCategory]
        
        save(categories: categories, date: date)
        return categories
    }
}
