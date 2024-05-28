//
//  MockCaregoryRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

class MockCategoryRepository: CategoryRepository {
    func fetchCategories(date: Date) -> [Category] {
        let needsCategory = Category(categoryType: "Needs", percentage: 0, spentValue: 0)
        let entertainmentCategory = Category(categoryType: "Entertainment", percentage: 0, spentValue: 0)
        let investmentsCategory = Category(categoryType: "Investments", percentage: 0, spentValue: 0)
        let savingsCategory = Category(categoryType: "Savings", percentage: 0, spentValue: 0)

        return [needsCategory, entertainmentCategory, investmentsCategory, savingsCategory]
    }
    
    func save(categories: [Category], date: Date) {
        CDCategory.deleteAll()
        //CDCategory.saveOrUpdate(categoryInformations: categoriesInformation, date: date)
    }
}
