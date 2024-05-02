//
//  CoreDataDistributionRepository.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 23/4/24.
//

import Foundation
import CoreData

class CoreDataCategoriesRepository: CategoryRepository {
    
    func fetchCategories(date: Date) -> [Category] {
        // TODO: Implement CoreData logic
        return []
    }
    
    func save(categoriesInformation: [CategoryInformation], date: Date) {
        CDCategory.saveOrUpdate(categoryInformations: categoriesInformation, date: date)
    }
}
