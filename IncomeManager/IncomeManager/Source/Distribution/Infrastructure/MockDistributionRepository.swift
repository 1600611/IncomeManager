//
//  MockDistributionRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

class MockDistributionRepository: DistributionRepository {
    func fetchDistributions(date: Date) -> [Distribution] {
        let distribution1 = Distribution(date: Date(), categoryType: CategoryType.NEEDS, percentage: 50, spentValue: 200)
        let distribution2 = Distribution(date: Date(), categoryType: CategoryType.ENTERTAINMENT, percentage: 30, spentValue: 200)
        let distribution3 = Distribution(date: Date(), categoryType: CategoryType.INVESTMENTS, percentage: 10, spentValue: 100)
        let distribution4 = Distribution(date: Date(), categoryType: CategoryType.SAVINGS, percentage: 10, spentValue: 0)
        return [distribution1, distribution2, distribution3, distribution4]
    }
}
