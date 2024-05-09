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
            return defaultCategories()
        }
        
        return categoriesCD.map { categoryCD in
            mapper.map(categoryCD: categoryCD)
        }
    }
    
    func save(categories: [Category], date: Date) {
        CDCategory.saveOrUpdate(categories: categories, date: date)
    }
    
    func defaultCategories() -> [Category] {
        let needsCategory = Category(categoryType: "NEEDS", percentage: 50, spentValue: 0)
        let entertainmentCategory = Category(categoryType: "ENTERTAINMENT", percentage: 30, spentValue: 0)
        let investmentsCategory = Category(categoryType: "INVESTMENTS", percentage: 10, spentValue: 0)
        let savingsCategory = Category(categoryType: "SAVINGS", percentage: 10, spentValue: 0)
        return [needsCategory, entertainmentCategory, investmentsCategory, savingsCategory]
    }
}
