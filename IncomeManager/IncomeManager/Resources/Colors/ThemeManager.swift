//
//  ThemeManager.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 25/4/24.
//

import Foundation

class ThemeManager: ObservableObject {
    @Published var selectedIndex: Int = 0 // 0: Light, 1: Dark
}
