//
//  MockCaregoryRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

class MockCategoriesRepository: CategoryRepository {
    func fetchCategories(date: Date) -> [Category] {
        let distribution1 = Category(categoryType: CategoryType.NEEDS, percentage: 50, spentValue: 200)
        let distribution2 = Category(categoryType: CategoryType.ENTERTAINMENT, percentage: 30, spentValue: 200)
        let distribution3 = Category(categoryType: CategoryType.INVESTMENTS, percentage: 10, spentValue: 100)
        let distribution4 = Category(categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)
       /* let distribution5 = Category(categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)
        let distribution6 = Category(categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)
        let distribution7 = Category(categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)*/

        return [distribution1, distribution2, distribution3, distribution4]
    }
    
    func save(categoriesInformation: [CategoryInformation], date: Date) {
        CDCategory.deleteAll()
        //CDCategory.saveOrUpdate(categoryInformations: categoriesInformation, date: date)
    }
}
