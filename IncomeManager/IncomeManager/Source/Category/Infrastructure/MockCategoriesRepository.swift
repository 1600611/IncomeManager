//
//  MockCaregoryRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

class MockCategoriesRepository: CategoryRepository {
    func fetchCategories(date: Date) -> [Category] {
        let distribution1 = Category(date: Date(), categoryType: CategoryType.NEEDS, percentage: 50, spentValue: 200)
        let distribution2 = Category(date: Date(), categoryType: CategoryType.ENTERTAINMENT, percentage: 30, spentValue: 200)
        let distribution3 = Category(date: Date(), categoryType: CategoryType.INVESTMENTS, percentage: 10, spentValue: 100)
        let distribution4 = Category(date: Date(), categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)
        let distribution5 = Category(date: Date(), categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)
        let distribution6 = Category(date: Date(), categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)
        let distribution7 = Category(date: Date(), categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)

        return [distribution1, distribution2, distribution3, distribution4, distribution5, distribution6, distribution7]
    }
}
