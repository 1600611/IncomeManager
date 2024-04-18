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
            HeaderView(color: .green)
            
            MonthYearPickerView()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(0..<4) { _ in
                    CategoryView(categoryName: "Necessitats", percentage: 50, destinatedValue: 500, spentValue: 200, totalValue: 300, backgroundColor: Color.green)
                }
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}

