//
//  Income.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 7/5/24.
//

import Foundation

class Income {
    final private var amount: Decimal?
    
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
