//
//  MainViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

struct CategoryInformation: Identifiable, Equatable {
    let id = UUID()
    private let categoryType: CategoryType
    private(set) var percentage: Int
    private(set) var destinatedValue: Decimal
    private let spentValue: Decimal
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
    @Published var income: Decimal?
    private(set) var date: Date?
    private(set) var categories: [Category] = []
    
    private let categoryRepository: CategoryRepository
    private let incomeRepository: IncomeRepository
    
    init(categoryRepository: CategoryRepository = CoreDataCategoryRepository(), incomeRepository: IncomeRepository = CoreDataIncomeRepository()) {
        self.categoryRepository = categoryRepository
        self.incomeRepository = incomeRepository
    }
    
    func actionDateChanged(_ date: Date) {
        self.date = date
        let newCategories = categoryRepository.fetchCategories(date: date)
        self.categories = newCategories
        self.income = incomeRepository.fetchIncome(date: date).getAmount()
        actionIncomeSetted(income!)
    }
    
    func actionIncomeSetted(_ newIncome: Decimal) {
        self.income = newIncome
        self.categoriesInformation.removeAll()
        self.monthBenefit = 0
        
        for category in categories {
            let destinatedValue = newIncome * Decimal(category.getPercentage()) / 100
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
        
        incomeRepository.save(income: newIncome, date: date!)
    }
    
    func actionIncomeDistributionsSetted(_ incomeDistributions: [Int]) {
        for i in incomeDistributions.indices {
            categoriesInformation[i].setPercentage(incomeDistributions[i])
            categories[i].setPercentage(incomeDistributions[i])
            
            let destinatedValue = income! * Decimal(incomeDistributions[i]) / 100
            
            categoriesInformation[i].setDestinatedValue(destinatedValue)
            categories[i].setDestinatedValue(destinatedValue )
            
            categoriesInformation[i].setTotalValue(destinatedValue - categories[i].getSpentValue())
            categories[i].setTotalValue(destinatedValue - categories[i].getSpentValue())
        }
        
        categoryRepository.save(categories: categories, date: date!)
    }
    
}
