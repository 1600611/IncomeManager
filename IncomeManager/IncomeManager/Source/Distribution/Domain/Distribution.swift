//
//  Distribution.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

enum CategoryType: String {
    case NEEDS
    case ENTERTAINMENT
    case INVESTMENTS
    case SAVINGS
    case EMERGENCIES
    case DEBTS
    
    var title: LocalizedStringResource {
        switch self {
        case .NEEDS:
            "Needs"
        case .ENTERTAINMENT:
            "Entertainment"
        case .INVESTMENTS:
            "Investments"
        case .SAVINGS:
            "Savings"
        case .EMERGENCIES:
            "Emergencies"
        case .DEBTS:
            "Debts"
        }
    }
}

class Distribution {
    private var date: Date
    private var categoryType: CategoryType
    private var percentage: Int
    private var spentValue: Decimal
    
    init(date: Date, categoryType: CategoryType, percentage: Int, spentValue: Decimal) {
        self.date = date
        self.categoryType = categoryType
        self.percentage = percentage
        self.spentValue = spentValue
    }
    
    func getDate() -> Date {
        return self.date
    }
    
    func getCategoryType() -> CategoryType {
        return self.categoryType
    }
    
    func getPercentage() -> Int {
        return self.percentage
    }
    
    func getSpentValue() -> Decimal {
        return self.spentValue
    }
    
    func setDate(_ date: Date) {
        self.date = date
    }
    
    func setCategoryType(_ categoryType: CategoryType) {
        self.categoryType = categoryType
    }
    
    func setPercentage(_ percentage: Int) {
        self.percentage = percentage
    }
    
    func setSpentValue(_ spentValue: Decimal) {
        self.spentValue = spentValue
    }
}
