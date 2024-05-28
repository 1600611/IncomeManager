//
//  AddExpenseView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 28/5/24.
//

import SwiftUI

struct AddExpenseView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel = AddExpenseViewModel()
    @State private var cost: String = ""
    @State private var comment: String = ""
    @State private var selectedExpense: ExpenseType?
    @State var selectedDate: Date?
    @State private var isShowingDatePicker = false
    var date: Date
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView(title: "Add expense", totalValue: nil)
                
                HStack {
                    Text("Cost:")
                        .font(.headline)
                        .foregroundColor(themeManager.selectedIndex == 0 ? Color.black : Color.white)
    
                    TextField("Introduce the cost", text: $cost)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading, 10)
                }
                .padding()
                
                Rectangle()
                    .fill(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("Type:")
                        .font(.headline)
                        .foregroundColor(themeManager.selectedIndex == 0 ? Color.black : Color.white)
    
                    Spacer()
                }
                .padding()
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 10) {
                    ForEach(viewModel.defaultExpenses.indices, id: \.self) { index in
                        Button(action: {
                            if self.selectedExpense == self.viewModel.defaultExpenses[index] {
                                self.selectedExpense = nil
                            } else {
                                // De lo contrario, selecciona la imagen
                                self.selectedExpense = self.viewModel.defaultExpenses[index]
                            }
                        }) {
                            VStack {
                                ZStack {
                                    Circle()
                                        .fill(Color(named: self.viewModel.defaultExpenses[index].colorName) ?? Color.gray.opacity(0.1))
                                        .frame(width: 55, height: 55)
                                    
                                    Image(systemName: self.viewModel.defaultExpenses[index].iconName)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                }
                                
                                Text(self.viewModel.defaultExpenses[index].title)
                                    .font(.caption)
                                    .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                            }
                            .padding()
                            .background(self.viewModel.defaultExpenses[index] == self.selectedExpense ? Color(named: self.viewModel.defaultExpenses[index].colorName) ?? Color.gray.opacity(0.1) : Color.clear)
                            .cornerRadius(10)
                        }
                    }
                }
                
                Rectangle()
                    .fill(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                
                HStack {
                    Text("Date:")
                        .font(.headline)
                        .foregroundColor(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                    
                    Text(DateFormatterHelper.shared.format(date: self.selectedDate ?? nil))
                        .padding(.leading, 10)
                        .foregroundColor(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                    
                    Spacer()
                    
                    Button(action: {
                        self.isShowingDatePicker.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .foregroundColor(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                    }
                }
                .padding()
                
                Rectangle()
                    .fill(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                    .frame(height: 1)
                    .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Comment:")
                            .font(.headline)
                            .foregroundColor(themeManager.selectedIndex == 0 ? Color.black : Color.white)
                        Spacer()
                    }
                                    
                    HStack {
                        TextField("Introduce a comment", text: $comment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Spacer()
                    }
                }
                .padding()
                
                Spacer()
            }
            .background(themeManager.selectedIndex == 0 ? CustomColor.lightBackground : CustomColor.darkBackground)
            .blur(radius: isShowingDatePicker ? 2 : 0)
            
            if isShowingDatePicker {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isShowingDatePicker = false
                    }
                
                DatePickerPopup(selectedDate: self.$selectedDate, isPresented: self.$isShowingDatePicker, date: date)
            }
        }
    }
}


#Preview {
    AddExpenseView(date: Date())
}
