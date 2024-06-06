//
//  ExpenseRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation

protocol ExpenseRepository {
    func fetchExpenses(date: Date, categoryType: CategoryType) -> [Expense]
    func fetchExpenses(date: Date, expenseType: ExpenseType, categoryType: CategoryType) -> [Expense]
    func save(amount: Decimal, comment: String, date: Date, categoryType: CategoryType, type: ExpenseType)
    func update(id: UUID, amount: Decimal, comment: String, date: Date, categoryType: CategoryType, type: ExpenseType)
    func delete(id: UUID)
}
