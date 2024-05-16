//
//  ExpenseListItemView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import SwiftUI

struct ExpenseListItemView: View {
    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: "dollarsign.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("Nombre del gasto")
                    
                    Spacer()
                    
                    Text("25%")
                    
                    Text("100.00€")
                }
                .padding()
            )
    }
}

struct ExpenseListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseListItemView()
    }
}
