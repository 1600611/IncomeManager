//
//  CategoryMapper.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 6/5/24.
//

import Foundation

class CategoryMapper {
    func map(categoryCD: CDCategory) -> Category {
        return Category(categoryType: categoryCD.categoryType ?? "", percentage: Int(categoryCD.percentage), spentValue: categoryCD.spent! as Decimal)
    }
}
