//
//  Styles.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 25/4/24.
//

import Foundation
import SwiftUI

struct CustomColor {
        
    // Light mode colors
    static let lightBackground = Color.white
    static let lightIcons = Color.green
    static let lightComponentsBackground = Color.green
    static let lightOptionsText = Color.gray
    static let lightListBackground = Color(red: 229 / 255, green: 231 / 255, blue: 233 / 255)
    
    // Dark mode colors
    static let darkBackground =  Color(red: 0.15, green: 0.15, blue: 0.15)
    static let darkIcons = Color(red: 0, green: 0.5, blue: 0.25)
    static let darkComponentsBackground = Color(red: 0, green: 0.5, blue: 0.25)
    static let darkOptionsText = Color.white
    static let darkListBackground = Color(red: 166 / 255, green: 172 / 255, blue: 175 / 255)
}

extension Color {
    init?(named colorName: String) {
        switch colorName.lowercased() {
        case "red":
            self = .red
        case "blue":
            self = .blue
        case "green":
            self = .green
        case "orange":
            self = .orange
        case "yellow":
            self = .yellow
        case "purple":
            self = .purple
        case "pink":
            self = .pink
        case "gray":
            self = .gray
        default:
            return nil
        }
    }
}
