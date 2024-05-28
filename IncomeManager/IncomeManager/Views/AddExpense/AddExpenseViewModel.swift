//
//  AddExpenseViewModel.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import Foundation



@MainActor class AddExpenseViewModel: ObservableObject {
    @Published var defaultExpenses: [ExpenseType] = [.FOOD, .ENTERTAINMENT, .RESTAURANT, .HEALTH, .TECHNOLOGY, .PRESENTS, .SPORT, .CLOTHES]
}
