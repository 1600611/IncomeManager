//
//  MainViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

struct CategoryInformation: Identifiable, Equatable {
    let id = UUID()
    let categoryType: CategoryType
    private(set) var percentage: Int
    private(set) var destinatedValue: Decimal
    let spentValue: Decimal
    private(set) var totalValue: Decimal
    
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
    
    mutating func setPercentage(_ percentage: Int) {
        self.percentage = percentage
    }
    
    mutating func setTotalValue(_ totalValue: Decimal) {
        self.totalValue = totalValue
    }
    
    mutating func setDestinatedValue(_ destinatedValue: Decimal) {
        self.destinatedValue = destinatedValue
    }
}


import Foundation

@MainActor class MainViewModel: ObservableObject {
    @Published var categoriesInformation: [CategoryInformation] = []
    @Published var monthBenefit: Decimal = 0
    @Published var date: Date
    private(set) var categories: [Category] = []
    private(set) var income: Decimal = 1000
    
    private let repository: CategoryRepository
    
    init(date: Date, repository: CategoryRepository = CoreDataCategoryRepository()) {
        self.date = date
        self.repository = repository
        getCategories()
    }
    
    func getCategories() {
        self.categories = repository.fetchCategories(date: date)
        actionIncomeSetted(income)
    }
    
    func actionIncomeSetted(_ newIncome: Decimal?) {
        for category in categories {
            let destinatedValue = newIncome! * Decimal(category.getPercentage()) / 100
            let spentValue = category.getSpentValue()
            let totalValue = destinatedValue - spentValue
            let categoryInfo = CategoryInformation(categoryType: category.getCategoryType(),
                                                   percentage: category.getPercentage(),
                                                   destinatedValue: destinatedValue,
                                                   spentValue: spentValue,
                                                   totalValue: totalValue)
            categoriesInformation.append(categoryInfo)
            monthBenefit += totalValue
        }
    }
    
    func actionIncomeDistributionsSetted(_ incomeDistributions: [Int]) {
        for i in incomeDistributions.indices {
            categoriesInformation[i].setPercentage(incomeDistributions[i])
            let destinatedValue = income * Decimal(incomeDistributions[i]) / 100
            categoriesInformation[i].setDestinatedValue(destinatedValue)
            categoriesInformation[i].setTotalValue(destinatedValue - categories[i].getSpentValue())
        }
        
        repository.save(categoriesInformation: categoriesInformation, date: date)
    }
    
}
