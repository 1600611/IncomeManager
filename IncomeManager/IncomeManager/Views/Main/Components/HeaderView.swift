//
//  HeaderView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var userInput: String = ""
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
                            .padding(.top, 5)
                        
                        Spacer()
                    }
                    
                }
                
                Spacer()
                
                VStack(alignment: .center, spacing: -10) {
                    HStack(spacing: -10) {
                        
                        // Euro icon
                        Image(systemName: "eurosign.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        // Income
                        Text("Income")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                    }
                    
                    HStack {
                        
                        // Monthly salary field
                        TextField("Monthly salary", text: $userInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .frame(width: 200, height: 40)
                        
                        //Check button
                        Button(action: {
                            if let newValue = Decimal(string: userInput) {
                                incomeChangedAction(newValue)
                            }
                        }) {
                            HStack {
                                Image(systemName: "checkmark.circle")
                            }
                        }
                    }
                }.padding(.bottom, 12.5)
                
                Spacer()
            }.padding([.leading, .top], 5)
        }
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(incomeChangedAction: { _ in }, optionsButtonAction: { })
    }
}
