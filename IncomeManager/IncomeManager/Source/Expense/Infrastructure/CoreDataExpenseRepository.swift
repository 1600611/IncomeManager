//
//  CoreDataExpenseRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation

class CoreDataExpenseRepository: ExpenseRepository {
    let expenseMapper = ExpenseMapper()
    
    func fetchExpenses(date: Date, categoryType: CategoryType) -> [Expense] {
        return CDExpense.fetchExpenses(on: date, categoryType: categoryType).map({ expenseMapper.map(expenseCD: $0) })
    }
    
    func fetchExpenses(date: Date, expenseType: ExpenseType) -> [Expense] {
        return CDExpense.fetchExpenses(on: date, expenseType: expenseType).map({ expenseMapper.map(expenseCD: $0) })
    }
}
