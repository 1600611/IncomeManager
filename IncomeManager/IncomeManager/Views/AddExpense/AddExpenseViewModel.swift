//
//  AddExpenseViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import Foundation

@MainActor class AddExpenseViewModel: ObservableObject {
    @Published var defaultExpenses: [ExpenseType] = [.FOOD, .ENTERTAINMENT, .RESTAURANT, .HEALTH, .TECHNOLOGY, .PRESENTS, .SPORT, .CLOTHES]
    @Published var costStr: String = ""
    @Published var comment: String = ""
    @Published var selectedExpense: ExpenseType?
    @Published var selectedDate: Date?
    @Published var saveCompleted: Bool = false
    @Published var isModifing: Bool = false
    @Published var isModifingCost: Bool = true
    private(set) var cost: Decimal?
    private(set) var categoryType: CategoryType
    private(set) var expense: Expense?
    private var expenseRepository: ExpenseRepository
    private var categoryRepository: CategoryRepository
    
    init(categoryType: CategoryType, expense: Expense?, expenseRepository: ExpenseRepository = CoreDataExpenseRepository(), categoryRepository: CategoryRepository = CoreDataCategoryRepository()) {
        self.categoryType = categoryType
        self.expense = expense
        self.expenseRepository = expenseRepository
        self.categoryRepository = categoryRepository
    }
    
    func onAppear() {
        self.selectedDate = nil
        
        if let expense = expense {
            cost = expense.getAmount()
            self.costStr = expense.getAmount().description
            comment = expense.getDescription()
            selectedExpense = expense.getType()
            selectedDate = expense.getDate()
            self.isModifing = true
        }
    }
    
    // Computed property to check if the form is valid
    var isFormValid: Bool {
        if let cost = cost {
            return selectedExpense != nil && selectedDate != nil && cost > 0
        }
        
        return false
    }
    
    func actionAddCost(_ cost: String) {
        guard isValidCostString(cost) else {
            self.cost = nil
            return
        }
        
        if let cost = Decimal(string: cost) {
            self.cost = cost
        }
        
        // Notify the view that the object has changed
        objectWillChange.send()
    }
    
    // Method to validate the cost string
    private func isValidCostString(_ cost: String) -> Bool {
        // Check that there is only one comma or dot
        let commaCount = cost.filter { $0 == "," }.count
        let dotCount = cost.filter { $0 == "." }.count
        guard commaCount <= 1, dotCount <= 1 else { return false }
        
        // Check that the comma or dot is not at the beginning or end
        guard let firstCharacter = cost.first, let lastCharacter = cost.last else { return false }
        guard firstCharacter != ",", firstCharacter != ".", lastCharacter != ",", lastCharacter != "." else { return false }
        
        return true
    }
    
    func actionAddExpense() {
        guard isFormValid else {
            return
        }
        
        self.expenseRepository.save(amount: self.cost!, comment: comment, date: selectedDate!, categoryType: categoryType, type: selectedExpense!)
        self.categoryRepository.updateSpentValue(categoryType: categoryType, spentValue: self.cost!, date: selectedDate!)
        self.saveCompleted = true
    }
    
    func actionModifyExpense() {
        guard isFormValid else {
            return
        }
        
        if let expense = expense {
            self.expenseRepository.update(id: expense.getId(), amount: self.cost!, comment: comment, date: selectedDate!, categoryType: categoryType, type: selectedExpense!)
            let oldCost = expense.getAmount()
            let difference = self.cost! - oldCost
            self.categoryRepository.updateSpentValue(categoryType: categoryType, spentValue: difference, date: selectedDate!)
            self.saveCompleted = true
        }
    }
}
