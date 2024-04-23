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
            HeaderView(color: .green, incomeChangedAction: updateMonthlyIncome)
                .frame(height: 100)
            
            MonthYearPickerView()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(viewModel.distributions.indices, id: \.self) { index in
                    let distribution = viewModel.distributions[index]
                    CategoryView(categoryType: distribution.categoryType,
                                 percentage: distribution.percentage,
                                 destinatedValue: 500,
                                 spentValue: 200,
                                 totalValue: 300,
                                 backgroundColor: Color.green)
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
    func updateMonthlyIncome(_ newIncome: Decimal?) {
        viewModel.actionIncomeChanged(newIncome)
    }
}

#Preview {
    MainView()
}
