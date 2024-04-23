//
//  HeaderView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct HeaderView: View {
    var color: Color
    @State private var userInput: String = ""
    var incomeChangedAction: ((Decimal?) -> Void)

    var body: some View {
        ZStack {
            Rectangle()
                .fill(color)
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            HStack {
                VStack {
                    Image(systemName: "line.horizontal.3")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .center, spacing: -5) {
                    HStack(spacing: -10) {
                        Image(systemName: "eurosign.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        Text("Income")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding()
                    }
                    
                    HStack {
                        TextField("Monthly salary", text: $userInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .frame(width: 200, height: 40)
                        
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
                }
                
                Spacer()
            }.padding(5)
        }
    }
}



struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(color: .green, incomeChangedAction: { _ in })
    }
}
