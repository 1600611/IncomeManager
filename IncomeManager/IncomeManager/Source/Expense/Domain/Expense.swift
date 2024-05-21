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
    
    var iconName: String {
            switch self {
            case .FOOD:
                return "fork.knife"
            case .ENTERTAINMENT:
                return "film"
            case .RESTAURANT:
                return "cup.and.saucer"
            case .HEALTH:
                return "heart"
            case .TECHNOLOGY:
                return "desktopcomputer"
            case .PRESENTS:
                return "gift"
            case .SPORT:
                return "sportscourt"
            case .CLOTHES:
                return "tshirt"
            }
        }
    
    var colorName: String {
        switch self {
        case .FOOD:
            return "red"
        case .ENTERTAINMENT:
            return "blue"
        case .RESTAURANT:
            return "green"
        case .HEALTH:
            return "orange"
        case .TECHNOLOGY:
            return "yellow"
        case .PRESENTS:
            return "purple"
        case .SPORT:
            return "pink"
        case .CLOTHES:
            return "gray"
        }
    }
}


class Expense {
    private final var description: String
    private final var amount: Decimal
    private final var type: ExpenseType
    private final var categoryType: CategoryType
    private final var date: Date
    
    init(description: String, amount: Decimal, type: ExpenseType, categoryType: CategoryType, date: Date) {
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
    
    func getType() -> ExpenseType {
        return self.type
    }
    
    func getCategoryType() -> CategoryType {
        return self.categoryType
    }
    
    func getDate() -> Date {
        return self.date
    }
    
}
