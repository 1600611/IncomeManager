//
//  MainViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import Foundation


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
    
    // Setters
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
        self.categories = self.categoryRepository.fetchCategories(date: date)
        self.income = self.incomeRepository.fetchIncome(date: date).getAmount()
        self.loadCategories(income!)
    }
    
    func actionIncomeSetted(_ newIncome: String) {
        guard let newIncome = Decimal(string: newIncome) else { return }
        
        self.income = newIncome
        self.incomeRepository.save(income: newIncome, date: date!)
        self.loadCategories(newIncome)
    }
    
    func loadCategories(_ newIncome: Decimal) {
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
            self.categoriesInformation.append(categoryInfo)
            self.monthBenefit += totalValue
        }
    }
    
    func actionIncomeDistributionsSetted(_ incomeDistributions: [Int]) {
        for i in incomeDistributions.indices {
            self.categoriesInformation[i].setPercentage(incomeDistributions[i])
            self.categories[i].setPercentage(incomeDistributions[i])
            
            let destinatedValue = income! * Decimal(incomeDistributions[i]) / 100
            
            self.categoriesInformation[i].setDestinatedValue(destinatedValue)
            self.categories[i].setDestinatedValue(destinatedValue )
            
            self.categoriesInformation[i].setTotalValue(destinatedValue - categories[i].getSpentValue())
            self.categories[i].setTotalValue(destinatedValue - categories[i].getSpentValue())
        }
        
        self.categoryRepository.save(categories: categories, date: date!)
    }
    
}
