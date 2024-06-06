//
//  MainView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel = MainViewModel()
    @State private var isMenuVisible = false
    @State private var selectedCategory: CategoryInformation? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    MainHeaderView(income: viewModel.income ?? 0, incomeChangedAction: monthlyIncomeUpdated, optionsButtonAction: { isMenuVisible.toggle() })
                        .frame(height: 120)
                    
                    MonthYearPickerView(changeDateAction: dateChanged)
                                
                    // Categories
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(viewModel.categoriesInformation) { category in
                                NavigationLink(destination: CategoryDetailView(category: category, date: viewModel.date!)) {
                                    CategoryView(category: category)
                                }
                            }
                        }
                        .padding(.horizontal, 5)
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    // Monthly total benefits
                    ZStack {
                        Rectangle()
                            .fill(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                            .frame(height: 110)
                        
                        HStack(alignment: .center) {
                            Text("Total" + ":")
                                .foregroundColor(.white)
                                .font(.title)
                            Text(DecimalFormatter.shared.format(viewModel.monthBenefit) + "€")
                                .foregroundColor(viewModel.monthBenefit < 0 ? .red :.white)
                                .font(.title)
                        }
                    }
                    
                }
                .disabled(isMenuVisible)
                .overlay(
                    Color.black.opacity(isMenuVisible ? 0.5 : 0)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            if isMenuVisible { isMenuVisible.toggle() }
                        }
                )
                
                if isMenuVisible {
                    GeometryReader { geometry in
                        SideMenuView(categories: viewModel.categoriesInformation, saveIncomeDistributionsAction: incomeDistributionPercentagesUpdated, homeButtonAction: { isMenuVisible.toggle() })
                            .frame(maxWidth: geometry.size.width * 0.70, maxHeight: .infinity)
                            .transition(.move(edge: .leading))
                    }
                }
            }
            .background(themeManager.selectedIndex == 0 ? CustomColor.lightBackground : CustomColor.darkBackground)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func monthlyIncomeUpdated(_ newIncome: String) {
        viewModel.actionIncomeSetted(newIncome)
    }
    
    func incomeDistributionPercentagesUpdated(_ updatedIncomeDistributionPercentages: [Int]) {
        isMenuVisible = false
        viewModel.actionIncomeDistributionsSetted(updatedIncomeDistributionPercentages)
    }
    
    func dateChanged(_ date: Date) {
        viewModel.actionDateChanged(date)
    }
}

#Preview {
    MainView(viewModel: MainViewModel())
}
