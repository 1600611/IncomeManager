//
//  CoreDataIncomeRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 7/5/24.
//

import Foundation

class CoreDataIncomeRepository: IncomeRepository {
    
    func fetchIncome(date: Date) -> Income {
        guard let incomeCD = CDIncome.fetch(date) else {
            return Income(amount: nil)
        }
        
        let amount = incomeCD.amount as Decimal?
        return Income(amount: amount)
    }
    
    func save(income: Decimal, date: Date) {
        CDIncome.saveOrUpdate(income: income, date: date)
    }
}
