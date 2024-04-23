//
//  MainView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    init() {
        self._viewModel = StateObject(wrappedValue: MainViewModel())
    }
    
    var body: some View {
        VStack {
            HeaderView(color: .green, incomeChangedAction: monthlyIncomeUpdated, optionsButtonAction: optionsButtonTapped)
                .frame(height: 100)
            
            MonthYearPickerView()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.categoryInformation) { categoryInformation in
                    CategoryView(categoryInformation: categoryInformation, color: Color.green)
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
    func monthlyIncomeUpdated(_ newIncome: Decimal?) {
        viewModel.actionIncomeChanged(newIncome)
    }
    
    func optionsButtonTapped() {
        let menu = Menu("Opciones") {
            Button("Opción 1") {
            }
            Button("Opción 2") {
            }
        }
        .menuStyle(BorderlessButtonMenuStyle())
    }
}

#Preview {
    MainView()
}
