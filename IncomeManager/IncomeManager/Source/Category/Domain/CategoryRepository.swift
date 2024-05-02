//
//  DistributionRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation

protocol CategoryRepository {
    func fetchCategories(date: Date) -> [Category]
    func save(categoriesInformation: [CategoryInformation], date: Date) 
}
