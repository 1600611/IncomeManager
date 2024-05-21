//
//  HeaderView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct MainHeaderView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var userInput: String = ""
    @State private var isEditing: Bool = false
    var income: Decimal
    var incomeChangedAction: ((Decimal) -> Void)
    var optionsButtonAction: (() -> Void)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            HStack {
                Button(action: {
                    optionsButtonAction()
                }) {
                    VStack {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.white)
                        
                        Spacer()
                    }
                    
                }.padding([.leading, .top], 5)
                
                Spacer()
                
                VStack(spacing: 5) {
                    HStack(spacing: 5) {
                        
                        // Euro icon
                        Image(systemName: "eurosign.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        // Income
                        Text("Income")
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding(.leading, -10)
                    
                    HStack {
                        if isEditing {
                            TextField("Monthly salary", text: $userInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .frame(width: 150, height: 40)
                        } else {
                            Text(DecimalFormatter.shared.format(income) + "€")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        
                        Button(action: {
                            isEditing.toggle()
                            if !isEditing {
                                if let newValue = Decimal(string: userInput) {
                                    incomeChangedAction(newValue)
                                    userInput = ""
                                }
                            }
                        }) {
                            Image(systemName: isEditing ? "checkmark.circle" : "pencil.circle")
                        }
                    }
                }
                .padding(.leading, -12.5)
                
                Spacer()
            }
        }
    }
}


struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(income: 0, incomeChangedAction: { _ in }, optionsButtonAction: { })
    }
}
