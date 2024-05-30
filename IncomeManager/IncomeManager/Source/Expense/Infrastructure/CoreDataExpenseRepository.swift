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
        return CDExpense.fetch(on: date, categoryType: categoryType).map({ expenseMapper.map(expenseCD: $0) })
    }
    
    func fetchExpenses(date: Date, expenseType: ExpenseType) -> [Expense] {
        return CDExpense.fetch(on: date, expenseType: expenseType).map({ expenseMapper.map(expenseCD: $0) })
    }
    
    func save(amount: Decimal, comment: String, date: Date, categoryType: CategoryType, type: ExpenseType) {
        CDExpense.save(amount: amount, comment: comment, date: date, categoryType: categoryType, type: type)
    }
    
    func delete(id: UUID) {
        CDExpense.delete(id: id)
    }
}
