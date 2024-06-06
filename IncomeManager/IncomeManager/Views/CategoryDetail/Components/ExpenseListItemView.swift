//
//  ExpenseListItemView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import SwiftUI

struct ExpenseListItemView: View {
    var expenseInformation: ExpenseInformation
    
    var body: some View {
        Rectangle()
            .fill(Color(named: expenseInformation.getColor()) ?? Color.gray.opacity(0.1))
            .cornerRadius(10)
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: expenseInformation.getIcon())
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                    
                    Text(expenseInformation.getTitle())
                        .padding(.leading, 10)     
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text(DecimalFormatter.shared.format(expenseInformation.getPercentage()) + "%")
                        .foregroundColor(.black)
                    
                    Text(DecimalFormatter.shared.format(expenseInformation.getTotalExpended()) + "€")
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 10)
            )
    }
}

struct ExpenseListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let expenseInformation = ExpenseInformation(type: .CLOTHES, totalExpended: Decimal(100), percentage: 25)
        ExpenseListItemView(expenseInformation: expenseInformation)
    }
}
