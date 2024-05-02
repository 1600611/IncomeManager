//
//  MainView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel: MainViewModel
    @State private var isMenuVisible = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: MainViewModel())
    }
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(incomeChangedAction: monthlyIncomeUpdated, optionsButtonAction: { isMenuVisible.toggle() })
                    .frame(height: 100)
                
                MonthYearPickerView()
                
                // Categories
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(viewModel.categoriesInformation) { categoryInformation in
                            CategoryView(categoryInformation: categoryInformation)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                // Monthly total benefits
                ZStack {
                    Rectangle()
                        .fill(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                        .frame(height: 75)
                    
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Text("Total" + ":")
                            .foregroundColor(.white)
                            .font(.title2)
                        Text(DecimalFormatter.shared.format(viewModel.monthBenefit) + "€")
                            .foregroundColor(.white)
                            .font(.title2)
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
                    SideMenuView(categoriesInformation: viewModel.categoriesInformation, saveIncomeDistributionsAction: incomeDistributionPercentagesUpdated, homeButtonAction: { isMenuVisible.toggle() })
                        .frame(maxWidth: geometry.size.width * 0.70, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
        .background(themeManager.selectedIndex == 0 ? CustomColor.lightBackground : CustomColor.darkBackground)
    }
    
    func monthlyIncomeUpdated(_ newIncome: Decimal?) {
        viewModel.actionIncomeSetted(newIncome)
    }
    
    func incomeDistributionPercentagesUpdated(_ updatedIncomeDistributionPercentages: [Int]) {
        isMenuVisible = false
        viewModel.actionIncomeDistributionsSetted(updatedIncomeDistributionPercentages)
    }
}

#Preview {
    MainView()
}
