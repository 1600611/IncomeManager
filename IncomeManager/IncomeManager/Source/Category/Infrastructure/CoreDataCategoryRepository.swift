//
//  CoreDataDistributionRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation
import CoreData

class CoreDataCategoryRepository: CategoryRepository {
    
    final private var defaultCategories: [Category]
    private var mapper = CategoryMapper()
    
    init() {
        let needsCategory = Category(categoryType: "NEEDS", percentage: 0, spentValue: 0)
        let entertainmentCategory = Category(categoryType: "ENTERTAINMENT", percentage: 0, spentValue: 0)
        let investmentsCategory = Category(categoryType: "INVESTMENTS", percentage: 0, spentValue: 0)
        let savingsCategory = Category(categoryType: "SAVINGS", percentage: 0, spentValue: 0)
        defaultCategories = [needsCategory, entertainmentCategory, investmentsCategory, savingsCategory]
    }
    
    func fetchCategories(date: Date) -> [Category] {
        let categoriesCD = CDCategory.fetch(date)
        
        if categoriesCD.isEmpty {
            return defaultCategories
        }
        
        return categoriesCD.map { categoryCD in
            mapper.map(categoryCD: categoryCD)
        }
    }
    
    func save(categoriesInformation: [CategoryInformation], date: Date) {
        CDCategory.saveOrUpdate(categoryInformations: categoriesInformation, date: date)
    }
}
