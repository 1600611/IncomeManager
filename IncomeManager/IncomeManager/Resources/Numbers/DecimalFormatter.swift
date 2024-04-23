//
//  DecimalFormatter.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

class DecimalFormatter {
    static let shared = DecimalFormatter()
    
    private let formatter: NumberFormatter
    
    private init() {
        formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
    }
    
    func format(_ decimal: Decimal) -> String {
        return formatter.string(for: NSDecimalNumber(decimal: decimal)) ?? ""
    }
}
