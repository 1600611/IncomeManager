//
//  Expense.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation

enum ExpenseType: String {
    case FOOD
    case ENTERTAINMENT
    case RESTAURANT
    case HEALTH
    case TECHNOLOGY
    case PRESENTS
    case SPORT
    case CLOTHES
    
    var title: LocalizedStringResource {
        switch self {
        case .FOOD:
            return "Food"
        case .ENTERTAINMENT:
            return "Entertainment"
        case .RESTAURANT:
            return "Restaurant"
        case .HEALTH:
            return "Health"
        case .TECHNOLOGY:
            return "Technology"
        case .PRESENTS:
            return "Presents"
        case .SPORT:
            return "Sport"
        case .CLOTHES:
            return "Clothes"
        }
    }
}


class Expense {
    private final var description: String
    private final var amount: Decimal
    private final var type: CategoryType
    private final var categoryType: CategoryType
    private final var date: Date
    
    init(description: String, amount: Decimal, type: CategoryType, categoryType: CategoryType, date: Date) {
        self.description = description
        self.amount = amount
        self.type = type
        self.categoryType = categoryType
        self.date = date
    }
    
    func getDescription() -> String {
        return self.description
    }
    
    func getAmount() -> Decimal {
        return self.amount
    }
    
    func getType() -> CategoryType {
        return self.type
    }
    
    func getCategoryType() -> CategoryType {
        return self.categoryType
    }
    
    func getDate() -> Date {
        return self.date
    }
    
}
