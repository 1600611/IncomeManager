//
//  DatePickerPopup.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import SwiftUI

struct DatePickerPopup: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var selectedDate: Date?
    @Binding var isPresented: Bool
    @State private var localSelectedDate: Date?
    var date: Date

    init(selectedDate: Binding<Date?>, isPresented: Binding<Bool>, date: Date) {
        self._selectedDate = selectedDate
        self._isPresented = isPresented
        self.date = date
        self._localSelectedDate = State(initialValue: selectedDate.wrappedValue ?? date)
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                    selectedDate = localSelectedDate
                }) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                }
            }
            
            DatePicker("", selection: Binding<Date>(
                get: {
                    self.localSelectedDate ?? date
                },
                set: { newValue in
                    self.localSelectedDate = newValue
                }
            ), in: date.intervalOfMonth(), displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .colorScheme(themeManager.selectedIndex == 0 ? .light : .dark)
        }
        .padding()
        .frame(width: 300, height: 375)
        .background(themeManager.selectedIndex == 0 ? Color.white : CustomColor.darkBackground)
        .cornerRadius(20)
        .shadow(radius: 10)
        .onDisappear {
            selectedDate = localSelectedDate
        }
    }
}



extension Date {
    
    // Function to obtain the date range for the current month
    func intervalOfMonth() -> ClosedRange<Date> {
        let calendar = Calendar.current
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate)!
        return startDate...endDate
    }
}

#Preview {
    DatePickerPopup(selectedDate: .constant(nil), isPresented: .constant(true), date: Date())
}

