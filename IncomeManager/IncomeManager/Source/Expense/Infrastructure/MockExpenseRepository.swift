//
//  MockExpenseRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 21/5/24.
//

import Foundation

class MockExpenseRepository: ExpenseRepository {
    func fetchExpenses(date: Date, categoryType: CategoryType) -> [Expense] {
        let expense1 = Expense(id: UUID(), description: "Food", amount: Decimal(100), type: ExpenseType.FOOD.rawValue, categoryType: categoryType.rawValue, date: date)
        let expense2 = Expense(id: UUID(), description: "Clothes", amount: Decimal(200), type: ExpenseType.CLOTHES.rawValue, categoryType: categoryType.rawValue, date: date)
        let expense3 = Expense(id: UUID(), description: "Health", amount: Decimal(300), type: ExpenseType.HEALTH.rawValue, categoryType: categoryType.rawValue, date: date)
        let expense4 = Expense(id: UUID(), description: "Technology", amount: Decimal(400), type: ExpenseType.TECHNOLOGY.rawValue, categoryType: categoryType.rawValue, date: date)
        let expense5 = Expense(id: UUID(), description: "Sport", amount: Decimal(500), type: ExpenseType.SPORT.rawValue, categoryType: categoryType.rawValue, date: date)
        let expense6 = Expense(id: UUID(), description: "Entertainment", amount: Decimal(600), type: ExpenseType.ENTERTAINMENT.rawValue, categoryType: categoryType.rawValue, date: date)
        let expense7 = Expense(id: UUID(), description: "Presents", amount: Decimal(700), type: ExpenseType.PRESENTS.rawValue, categoryType: categoryType.rawValue, date: date)
        let expense8 = Expense(id: UUID(), description: "Restaurant", amount: Decimal(800), type: ExpenseType.RESTAURANT.rawValue, categoryType: categoryType.rawValue, date: date)
        
        return [expense1, expense2, expense3, expense4, expense5, expense6, expense7, expense8]
    }
    
    func fetchExpenses(date: Date, expenseType: ExpenseType, categoryType: CategoryType) -> [Expense] {
        let expense1 = Expense(id: UUID(), description: "de locos", amount: Decimal(86), type: expenseType.rawValue, categoryType: CategoryType.ENTERTAINMENT.rawValue, date: date)
        let expense2 = Expense(id: UUID(), description: "kebab", amount: Decimal(75.8), type: expenseType.rawValue, categoryType: CategoryType.ENTERTAINMENT.rawValue, date: date)
        let expense3 = Expense(id: UUID(), description: "ca la maria", amount: Decimal(100), type: expenseType.rawValue, categoryType: CategoryType.ENTERTAINMENT.rawValue, date: date)
        let expense4 = Expense(id: UUID(), description: "ateneu", amount: Decimal(50), type: expenseType.rawValue, categoryType: CategoryType.ENTERTAINMENT.rawValue, date: date)
        let expense5 = Expense(id: UUID(), description: "Juventut", amount: Decimal(150), type: expenseType.rawValue, categoryType: CategoryType.ENTERTAINMENT.rawValue, date: date)

        return [expense1, expense2, expense3, expense4, expense5]
    }
    
    func save(amount: Decimal, comment: String, date: Date, categoryType: CategoryType, type: ExpenseType) {
        // Do nothing
    }
    
    func update(id: UUID, amount: Decimal, comment: String, date: Date, categoryType: CategoryType, type: ExpenseType) {
        // Do nothing
    }
    
    func delete(id: UUID) {
        // Do nothing
    }
}
