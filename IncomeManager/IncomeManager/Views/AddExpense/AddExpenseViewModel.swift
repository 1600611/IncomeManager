//
//  AddExpenseViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import Foundation

@MainActor class AddExpenseViewModel: ObservableObject {
    @Published var defaultExpenses: [ExpenseType] = [.FOOD, .ENTERTAINMENT, .RESTAURANT, .HEALTH, .TECHNOLOGY, .PRESENTS, .SPORT, .CLOTHES]
    @Published var cost: String = ""
    @Published var comment: String = ""
    @Published var selectedExpense: ExpenseType?
    @Published var selectedDate: Date?
    @Published var saveCompleted: Bool = false
    private(set) var categoryType: CategoryType
    private var expenseRepository: ExpenseRepository
    private var categoryRepository: CategoryRepository
    
    init(categoryType: CategoryType, expenseRepository: ExpenseRepository = CoreDataExpenseRepository(), categoryRepository: CategoryRepository = CoreDataCategoryRepository()) {
        self.categoryType = categoryType
        self.expenseRepository = expenseRepository
        self.categoryRepository = categoryRepository
    }
    
    // Computed property to check if the form is valid
    var isFormValid: Bool {
        return !cost.isEmpty && selectedExpense != nil && selectedDate != nil
    }
    
    func actionAddExpense() {
        guard isFormValid else {
            return
        }
        
        if let newCost = Decimal(string: cost) {
            self.expenseRepository.save(amount: newCost, comment: comment, date: selectedDate!, categoryType: categoryType, type: selectedExpense!)
            self.categoryRepository.updateSpentValue(categoryType: categoryType, spentValue: newCost, date: selectedDate!)
            self.saveCompleted = true
        }
    }
}
