//
//  DateFormatter.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import Foundation

class DateFormatterHelper {
    static let shared = DateFormatterHelper()
    
    private init() {}
    
    func monthAndYearFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        
        // Check if the system language is Catalan before removing prepositions
        var formattedDate = formatter.string(from: date)
        if let languageIdentifier = Locale.current.language.languageCode?.identifier {
            if languageIdentifier == "ca" {
                formattedDate = formattedDate.replacingOccurrences(of: "de ", with: "")
                
                // Remove the apostrophe from the month name
                formattedDate = formattedDate.replacingOccurrences(of: "d\u{2019}", with: "")
            }
        }
        
        return formattedDate
    }
    
    func format(date: Date) -> String {
        let formatter = DateFormatter()
        
        switch Locale.current.language.languageCode?.identifier {
        case "ca": // Catalan
            formatter.dateFormat = "d MMMM 'del' yyyy"
        case "es": // Spanish
            formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        case "en": // English
            formatter.dateStyle = .long
        default:
            formatter.dateStyle = .medium
        }
        
        return formatter.string(from: date)
    }
    
}
