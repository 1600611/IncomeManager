//
//  IncomeRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 7/5/24.
//

import Foundation

protocol IncomeRepository {
    func fetchIncome(date: Date) -> Income
    func save(income: Decimal, date: Date)
}
