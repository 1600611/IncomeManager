//
//  Income.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 7/5/24.
//

import Foundation

class Income {
    private final var amount: Decimal?
    
    init(amount: Decimal?) {
        self.amount = amount
    }
    
    func getAmount() -> Decimal {
        if let amount = amount {
            return amount
        }
        
        return 0
    }
}
