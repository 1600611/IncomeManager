//
//  ExpenseDetailViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import Foundation

@MainActor class ExpenseDetailViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    @Published var totalExpended: Decimal = 0
    private(set) var date: Date?
    
    private var expenseRepository: ExpenseRepository
    private var categoryRepository: CategoryRepository
    
    init(expenseRepository: ExpenseRepository = CoreDataExpenseRepository(), categoryRepository: CategoryRepository = CoreDataCategoryRepository()) {
        self.expenseRepository = expenseRepository
        self.categoryRepository = categoryRepository
    }
    
    func onAppear(_ date: Date, _ type: ExpenseType) {
        self.date = date
        self.expenses = self.expenseRepository.fetchExpenses(date: date, expenseType: type)
        self.totalExpended = self.expenses.reduce(0, { $0 + $1.getAmount() })
    }
    
    func deleteExpense(_ expense: Expense) {
        self.expenseRepository.delete(id: expense.getId())
        self.expenses = self.expenseRepository.fetchExpenses(date: expense.getDate(), expenseType: expense.getType())
        self.totalExpended -= expense.getAmount()
        self.categoryRepository.updateSpentValue(categoryType: expense.getCategoryType(), spentValue: -expense.getAmount(), date: self.date!)
    }
    
}
