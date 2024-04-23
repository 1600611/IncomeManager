//
//  DistributionRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

protocol DistributionRepository {
    func fetchDistributions(date: Date) -> [Distribution]
}
