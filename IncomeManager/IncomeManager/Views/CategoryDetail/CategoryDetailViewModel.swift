//
//  CategoryDetailViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation

struct ExpenseInformation {
    private let type: ExpenseType
    private let totalExpended: Decimal
    private let percentage: Decimal
    
    init(type: ExpenseType, totalExpended: Decimal, percentage: Decimal) {
        self.type = type
        self.totalExpended = totalExpended
        self.percentage = percentage
    }
    
    func getIcon() -> String {
        return self.type.iconName
    }
    
    func getTotalExpended() -> Decimal {
        return self.totalExpended
    }
    
    func getType() -> ExpenseType {
        return self.type
    }
    
    func getTitle() -> LocalizedStringResource {
        return self.type.title
    }
    
    func getPercentage() -> Decimal {
        return self.percentage
    }
    
    func getColor() -> String {
        return self.type.colorName
    }
}


@MainActor class CategoryDetailViewModel: ObservableObject {
    @Published var expensesInformation: [ExpenseInformation] = []
    @Published var monthExpense: Decimal = 0
    @Published var totalValue: Decimal = 0
    private var expenseRepository: ExpenseRepository
    private(set) var expenses: [Expense] = []
 
    init(totalValue: Decimal, expenseRepository: ExpenseRepository = MockExpenseRepository()) {
        self.expenseRepository = expenseRepository
        self.totalValue = totalValue
    }
    
    func onAppear(_ date: Date, _ categoryType: CategoryType)  {
        self.expenses = self.expenseRepository.fetchExpenses(date: date, categoryType: categoryType)
        self.mapExpenses()
    }
        
    func mapExpenses() {
        var expenseTotals: [ExpenseType: Decimal] = [:]
        
        for expense in expenses {
            let expenseType = expense.getType()
            let amount = expense.getAmount()
            
            // Add the current amount to the stored amount, or initialize with the current amount
            expenseTotals[expenseType, default: 0] += amount
        }
        
        self.monthExpense = self.expenses.reduce(0, { $0 + $1.getAmount() })
        self.totalValue = self.totalValue - self.monthExpense
        self.expensesInformation = expenseTotals.map { (type, total) in
            let percentageDouble = (total as NSDecimalNumber).doubleValue / (self.monthExpense as NSDecimalNumber).doubleValue * 100
            let percentageDecimal = Decimal(percentageDouble)
            return ExpenseInformation(type: type, totalExpended: total, percentage: percentageDecimal)
        }.sorted(by: { $0.getTotalExpended() > $1.getTotalExpended() })
    }
    
}
