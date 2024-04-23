//
//  MainViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

struct CategoryInformation {
    private var categoryType: CategoryType
    private var percentage: Int
    private var destinatedValue: Decimal
    private var spentValue: Decimal
    private var totalValue: Decimal
    
    init(categoryType: CategoryType, percentage: Int, destinatedValue: Decimal, spentValue: Decimal, totalValue: Decimal) {
        self.categoryType = categoryType
        self.percentage = percentage
        self.destinatedValue = destinatedValue
        self.spentValue = spentValue
        self.totalValue = totalValue
    }
    
    // Getters
    func getCategoryType() -> CategoryType {
        return categoryType
    }
    
    func getPercentage() -> Int {
        return percentage
    }
    
    func getDestinatedValue() -> Decimal {
        return destinatedValue
    }
    
    func getSpentValue() -> Decimal {
        return spentValue
    }
    
    func getTotalValue() -> Decimal {
        return totalValue
    }
}


import Foundation

@MainActor class MainViewModel: ObservableObject {
    @Published var categoryInformation: [CategoryInformation] = []
    var distributions: [Distribution] = []
    
    private let repository: DistributionRepository
    
    init(repository: DistributionRepository = MockDistributionRepository()) {
        self.repository = repository
        getDistributions(date: Date())
    }
    
    func getDistributions(date: Date) {
        self.distributions = repository.fetchDistributions(date: date)
    }
    
    func actionIncomeChanged(_ newIncome: Decimal?) {
        for distribution in distributions {
            let destinatedValue = newIncome! * Decimal(distribution.getPercentage())
            let spentValue = distribution.getSpentValue()
            let totalValue = destinatedValue - spentValue
            let categoryInfo = CategoryInformation(categoryType: distribution.getCategoryType(),
                                                   percentage: distribution.getPercentage(),
                                                   destinatedValue: destinatedValue,
                                                   spentValue: spentValue,
                                                   totalValue: totalValue)
            categoryInformation.append(categoryInfo)
        }
    }
    
}
