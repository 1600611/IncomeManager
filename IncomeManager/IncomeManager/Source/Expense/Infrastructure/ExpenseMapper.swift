//
//  ExpenseMapper.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import Foundation

class ExpenseMapper {
    func map(expenseCD: CDExpense) -> Expense {
        let id = expenseCD.id!
        let description = expenseCD.comment!
        let amount = expenseCD.amount!
        let type = expenseCD.type!
        let categoryType = expenseCD.categoryType!
        let date = expenseCD.date!
        
        return Expense(id: id, description: description, amount: amount as Decimal, type: type, categoryType: categoryType, date: date)
    }
}
