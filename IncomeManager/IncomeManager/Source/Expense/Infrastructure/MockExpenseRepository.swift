//
//  MockExpenseRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 21/5/24.
//

import Foundation

class MockExpenseRepository: ExpenseRepository {
    func fetchExpenses(date: Date, categoryType: String) -> [Expense] {
        let expense1 = Expense(description: "Food", amount: Decimal(100), type: .FOOD, categoryType: .NEEDS, date: Date())
        let expense2 = Expense(description: "Clothes", amount: Decimal(200), type: .CLOTHES, categoryType: .NEEDS, date: Date())
        let expense3 = Expense(description: "Health", amount: Decimal(300), type: .HEALTH, categoryType: .NEEDS, date: Date())
        let expense4 = Expense(description: "Technology", amount: Decimal(400), type: .TECHNOLOGY, categoryType: .NEEDS, date: Date())
        let expense5 = Expense(description: "Sport", amount: Decimal(500), type: .SPORT, categoryType: .NEEDS, date: Date())
        let expense6 = Expense(description: "Entertainment", amount: Decimal(600), type: .ENTERTAINMENT, categoryType: .NEEDS, date: Date())
        let expense7 = Expense(description: "Presents", amount: Decimal(700), type: .PRESENTS, categoryType: .NEEDS, date: Date())
        let expense8 = Expense(description: "Restaurant", amount: Decimal(800), type: .RESTAURANT, categoryType: .NEEDS, date: Date())
        
        return [expense1, expense2, expense3, expense4, expense5, expense6, expense7, expense8]
    }
}
