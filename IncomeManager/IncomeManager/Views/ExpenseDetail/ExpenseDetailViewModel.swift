//
//  ExpenseDetailViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import Foundation

@MainActor class ExpenseDetailViewModel: ObservableObject {
    @Published var expenses: [Expense] = []
    private var expenseRepository: ExpenseRepository
    
    init(expenseRepository: ExpenseRepository = CoreDataExpenseRepository()) {
        self.expenseRepository = expenseRepository
    }
    
    func onAppear(_ date: Date, _ type: ExpenseType) {
        self.expenses = self.expenseRepository.fetchExpenses(date: date, expenseType: type)
    }
    
}
