//
//  CategoryDetailView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel = CategoryDetailViewModel()
    var category: CategoryInformation
    var date: Date
    
    var body: some View {
        VStack() {
            HeaderView(title: category.getCategoryType().rawValue, totalValue: category.getTotalValue())
            
            Text(DateFormatterHelper.shared.format(date: self.date))
                .foregroundColor(0 == 0 ? Color.black : Color.white)
                .padding(.top, 10)
            
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.green)
                    .frame(width: geometry.size.width - 10, height: 300)
                    .padding(.horizontal, 5)
                    .padding(.top, 5)
                    .cornerRadius(25)
                    .overlay(
                        CircleGraphicView()
                            .frame(width: 250, height: 250)
                            .padding(.horizontal, 10)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            }
            
            List {
                ForEach(0..<3) { index in
                    ExpenseListItemView()
                }
            }
            .listStyle(PlainListStyle())
            .padding(.top, 10)
            
            Spacer()
        }
        .onAppear() {
            viewModel.onAppear(date, category.getCategoryType())
        }
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let categoryInformation = CategoryInformation(categoryType: .NEEDS, percentage: 50, destinatedValue: Decimal(2000), spentValue: Decimal(200), totalValue: Decimal(300))
        CategoryDetailView(category: categoryInformation, date: Date())
    }
}
