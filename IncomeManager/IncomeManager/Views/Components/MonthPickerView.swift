//
//  MonthPickerView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct MonthYearPickerView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        
        HStack {
            Button(action: {
                self.selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: self.selectedDate) ?? Date()
            }) {
                Image(systemName: "chevron.left")
            }
            
            Spacer()
            
            Text(DateFormatterHelper.shared.format(date: selectedDate))
            
            Spacer()
            
            Button(action: {
                self.selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: self.selectedDate) ?? Date()
            }) {
                Image(systemName: "chevron.right")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonthYearPickerView()
    }
}
