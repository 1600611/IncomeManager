//
//  ExpenseDetailView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import SwiftUI

struct ExpenseDetailView: View {
    @StateObject var viewModel = ExpenseDetailViewModel()
    var type: ExpenseType
    var date: Date
    var totalExpended: Decimal
    
    var body: some View {
        VStack() {
            HeaderView(title: type.title, totalValue: totalExpended)
      
            ScrollView {
                ForEach(viewModel.expenses.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Text(DateFormatterHelper.shared.format(date: viewModel.expenses[index].getDate()))
                                .foregroundColor(0 == 0 ? Color.black : Color.white)
                            Spacer()
                        }
                        
                        ExpenseDetailListItemView(expense: viewModel.expenses[index])
                            .listRowBackground(0 == 0 ? CustomColor.lightListBackground : CustomColor.darkListBackground)
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 2)
                }
            }
            
            Spacer()
        }
        .onAppear() {
            viewModel.onAppear(date, type)
        }
    }
}

struct ExpenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let expense = Expense(description: "de locos", amount: Decimal(100), type: "Entertainment", categoryType: "Entertainment", date: Date())
        ExpenseDetailView(type: expense.getType(), date: expense.getDate(), totalExpended: expense.getAmount())
    }
}
