//
//  CategoryDetailViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import Foundation


struct ExpenseInformation {
    private let icon: String
    private let totalExpended: Decimal
    private let type: String
    private let percentage: Int
    
    init(icon: String, totalExpended: Decimal, type: String, percentage: Int) {
        self.icon = icon
        self.totalExpended = totalExpended
        self.type = type
        self.percentage = percentage
    }
    
    func getIcon() -> String {
        return self.icon
    }
    
    func getTotalExpended() -> Decimal {
        return self.totalExpended
    }
    
    func getType() -> String {
        return self.type
    }
    
    func getPercentage() -> Int {
        return self.percentage
    }
}


@MainActor class CategoryDetailViewModel: ObservableObject {
    @Published var expensesInformation: [ExpenseInformation] = []
    @Published var monthExpense: Decimal = 0
    private var expenseRepository: ExpenseRepository
    private(set) var expenses: [Expense] = []
 
    init(expenseRepository: ExpenseRepository = CoreDataExpenseRepository()) {
        self.expenseRepository = expenseRepository
    }
    
    func onAppear(_ date: Date, _ categoryType: CategoryType)  {
        self.expenses = self.expenseRepository.fetchExpenses(date: date, categoryType: categoryType.rawValue)
        self.mapExpenses()
    }
        
    func mapExpenses() {
        // TODO: crear un diccionari on cada clau es el tipus de gasto i calcular el total per cada gasto per despres també tenir el tant per cent gastat
        
        self.monthExpense = self.expenses.reduce(0, { $0 + $1.getAmount() })
    }
    
}
