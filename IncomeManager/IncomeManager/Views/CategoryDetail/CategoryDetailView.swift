//
//  CategoryDetailView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import SwiftUI

struct CategoryDetailView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel: CategoryDetailViewModel
    var category: CategoryInformation
    var date: Date
    
    init(category: CategoryInformation, date: Date) {
        self.category = category
        self.date = date
        _viewModel = StateObject(wrappedValue: CategoryDetailViewModel(destinedValue: category.getDestinatedValue()))
    }
    
    var body: some View {
        VStack() {
            HeaderView(title: category.getCategoryType().title, totalValue: viewModel.totalValue, color: nil)
            
            Text(DateFormatterHelper.shared.monthAndYearFormat(date: self.date))
                .foregroundColor(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                .padding(.top, 10)
            
            GeometryReader { geometry in
                ZStack {
                    Rectangle()
                        .fill(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                        .frame(width: geometry.size.width - 10, height: 300)
                        .padding(.top, 5)
                        .cornerRadius(25)
                        .overlay(
                            CircleGraphicView(destined: category.getDestinatedValue(), totalMonthExpended: viewModel.monthExpense, expensesInformation: viewModel.expensesInformation)
                                .frame(width: 250, height: 250)
                                .padding(.horizontal, 10)
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: AddExpenseView(date: self.date, categoryType: category.getCategoryType())) {
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 40))
                                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                            }
                            .padding()
                        }
                    }
                }
                .padding(.leading, 10)
                .frame(width: geometry.size.width - 10, height: 300)
            }
            
            ScrollView {
                ForEach(viewModel.expensesInformation.indices, id: \.self) { index in
                    let type = viewModel.expensesInformation[index].getType()
                    let totalExpended = viewModel.expensesInformation[index].getTotalExpended()
                    
                    NavigationLink(destination: ExpenseDetailView(type: type, date: self.date, totalExpended: totalExpended)) {
                        ExpenseListItemView(expenseInformation: viewModel.expensesInformation[index])
                    }
                }
            }
            .padding(.horizontal, 5)
            .padding(.top, -20)
            
            Spacer()
        }
        .background(themeManager.selectedIndex == 0 ? CustomColor.lightBackground : CustomColor.darkBackground)
        .onAppear() {
            viewModel.onAppear(date, category.getCategoryType())
        }
        .ignoresSafeArea(.all)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let categoryInformation = CategoryInformation(categoryType: .NEEDS, percentage: 50, destinatedValue: Decimal(2000), spentValue: Decimal(200), totalValue: Decimal(300))
        CategoryDetailView(category: categoryInformation, date: Date())
    }
}
