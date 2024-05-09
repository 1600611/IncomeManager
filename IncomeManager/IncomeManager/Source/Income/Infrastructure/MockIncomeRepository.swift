//
//  MockIncomeRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 9/5/24.
//

import Foundation

class MockIncomeRepository: IncomeRepository {
    
    func fetchIncome(date: Date) -> Income {
        // Not implementedç
        return Income(amount: nil)
    }
    
    func save(income: Decimal, date: Date) {
        CDIncome.deleteAll()
    }
}
