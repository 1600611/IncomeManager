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

class Category: Identifiable {
    private final var categoryType: CategoryType
    private var percentage: Int
    private final var spentValue: Decimal
    private var destinatedValue: Decimal?
    private var totalValue: Decimal?
    
    init(categoryType: String, percentage: Int, spentValue: Decimal) {
        self.percentage = percentage
        self.spentValue = spentValue
        self.categoryType = CategoryType(rawValue: categoryType)!
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
    
    func getDestinatedValue() -> Decimal {
        if let destinatedValue = self.destinatedValue {
            return destinatedValue
        }
        
        return 0
    }
    
    func getTotalValue() -> Decimal {
        if let totalValue = self.totalValue {
            return totalValue
        }
        
        return 0
    }
    
    func setPercentage(_ percentage: Int) {
        self.percentage = percentage
    }
    
    func setDestinatedValue(_ destinatedValue: Decimal) {
        self.destinatedValue = destinatedValue
    }
    
    func setTotalValue(_ totalValue: Decimal) {
        self.totalValue = totalValue
    }
}
