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
                ForEach(viewModel.categoryInformation) { categoryInformation in
                    CategoryView(categoryType: categoryInformation.getCategoryType(),
                                 percentage: categoryInformation.getPercentage(),
                                 destinatedValue: categoryInformation.getDestinatedValue(),
                                 spentValue: categoryInformation.getSpentValue(),
                                 totalValue: categoryInformation.getTotalValue(),
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
