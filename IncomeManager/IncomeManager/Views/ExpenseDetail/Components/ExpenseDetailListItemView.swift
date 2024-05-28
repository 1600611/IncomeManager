//
//  ExpenseDetailListItemView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import SwiftUI

struct ExpenseDetailListItemView: View {
    var expense: Expense
    
    var body: some View {
        VStack(spacing: -10) {
            HStack(alignment: .center) {
                    Image(systemName: expense.getType().iconName)
                        .resizable()
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text(expense.getCategoryType().title)
                        .font(.headline)
                }
                .padding(.leading, 10)
                
                Spacer()
                
                Text(DecimalFormatter.shared.format(expense.getAmount()) + "€")
            }
            .padding()
            
            HStack {
                Text(expense.getDescription())
                    .font(.caption)
                
                Spacer()
            }
            .padding(.leading, 15)
        }
        .background(
            Rectangle()
                .fill(Color(named: expense.getType().colorName) ?? Color.gray.opacity(0.1))
                .cornerRadius(10)
                .frame(height: 70)
        )
    }
}

struct ExpenseDetailListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = Expense(description: "de locos", amount: Decimal(100), type: "Food", categoryType: "Entertainment", date: Date())
        ExpenseDetailListItemView(expense: expense)
    }
}
