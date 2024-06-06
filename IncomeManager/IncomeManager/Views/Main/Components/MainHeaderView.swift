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
    var incomeChangedAction: ((String) -> Void)
    var optionsButtonAction: (() -> Void)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
            
            HStack {
                Button(action: {
                    optionsButtonAction()
                }) {

                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(.leading, 5)
                .padding(.top, 5)
                
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
                            TextField("", text: $userInput, prompt: Text("Monthly salary").foregroundColor(.gray))
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(10)
                                .keyboardType(.decimalPad)
                                .frame(width: 150, height: 40)
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .onChange(of: userInput) { newValue in
                                    if newValue.contains(",") {
                                        userInput = newValue.replacingOccurrences(of: ",", with: ".")
                                    }
                                }
                        } else {
                            Text(DecimalFormatter.shared.format(income) + "€")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        
                        Button(action: {
                            isEditing.toggle()
                            if !isEditing {
                                incomeChangedAction(self.userInput)
                                userInput = ""
                            }
                        }) {
                            Image(systemName: isEditing ? "checkmark.circle" : "pencil.circle")
                        }
                    }
                }
                .padding(.leading, -12.5)
                .padding(.top, 25)
                
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
