import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var viewModel: AddExpenseViewModel
    @State private var isShowingDatePicker = false
    @FocusState private var focusField: Bool
    var date: Date
    var categoryType: CategoryType
    
    init(date: Date, categoryType: CategoryType, expense: Expense? = nil) {
        self.date = date
        self.categoryType = categoryType
        _viewModel = ObservedObject(wrappedValue: AddExpenseViewModel(categoryType: categoryType, expense: expense))
    }
    
    var body: some View {
        ZStack {
                VStack {
                    HeaderView(title: viewModel.isModifing ? "Modify expense" : "Add expense", totalValue: nil)
                    
                    ScrollView {
                        HStack {
                            Text("Cost:")
                                .font(.headline)
                                .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                            
                            TextField("", text: $viewModel.cost, prompt: Text("Introduce the cost").foregroundColor(.gray))
                                .keyboardType(.decimalPad)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(10)
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 1)
                                .focused($focusField)
                                .onTapGesture {
                                    self.focusField = true
                                }
                                .onChange(of: viewModel.cost) { newValue in
                                    if newValue.contains(",") {
                                        viewModel.cost = newValue.replacingOccurrences(of: ",", with: ".")
                                    }
                                }
                            
                            Button(action: {
                                self.focusField = false
                            }) {
                                Image(systemName: "checkmark.circle")
                            }
                        }
                        .padding()
                        
                        Rectangle()
                            .fill(themeManager.selectedIndex == 0 ? .black : .white)
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                        
                        HStack {
                            Text("Type:")
                                .font(.headline)
                                .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                            
                            Spacer()
                        }
                        .padding()
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: -4), count: 4), spacing: 10) {
                            ForEach(viewModel.defaultExpenses.indices, id: \.self) { index in
                                Button(action: {
                                    if self.viewModel.selectedExpense == self.viewModel.defaultExpenses[index] {
                                        self.viewModel.selectedExpense = nil
                                    } else {
                                        // De lo contrario, selecciona la imagen
                                        self.viewModel.selectedExpense = self.viewModel.defaultExpenses[index]
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
                                    .background(self.viewModel.defaultExpenses[index] == self.viewModel.selectedExpense ? Color(named: self.viewModel.defaultExpenses[index].colorName) ?? Color.gray.opacity(0.1) : Color.clear)
                                    .cornerRadius(10)
                                }
                            }
                        }
                        
                        Rectangle()
                            .fill(themeManager.selectedIndex == 0 ? .black : .white)
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                        
                        HStack {
                            Text("Date:")
                                .font(.headline)
                                .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                            
                            Text(DateFormatterHelper.shared.format(date: self.viewModel.selectedDate))
                                .padding(.leading, 10)
                                .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                            
                            Spacer()
                            
                            Button(action: {
                                self.isShowingDatePicker.toggle()
                            }) {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                            }
                        }
                        .padding()
                        
                        Rectangle()
                            .fill(themeManager.selectedIndex == 0 ? .black : .white)
                            .frame(height: 1)
                            .padding(.horizontal, 10)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Comment:")
                                    .font(.headline)
                                    .foregroundColor(themeManager.selectedIndex == 0 ? .black : .white)
                                Spacer()
                            }
                            
                            HStack {
                                TextField("", text: $viewModel.comment, prompt: Text("Introduce a comment").foregroundColor(.gray))
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 1)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                        
                    Button(action: {
                        viewModel.isModifing ? self.viewModel.actionModifyExpense() : self.viewModel.actionAddExpense()
                    }) {
                        Text(viewModel.isModifing ? "Modify" : "Add")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 200)
                            .background(viewModel.isFormValid ? Color.blue : Color.gray)
                            .cornerRadius(10)
                            .padding()
                    }
                    .disabled(!viewModel.isFormValid)
                    
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
                
                DatePickerPopup(selectedDate: self.$viewModel.selectedDate, isPresented: self.$isShowingDatePicker, date: date)
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
        .onChange(of: viewModel.saveCompleted) { saveCompleted in
            if saveCompleted {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

#Preview {
    AddExpenseView(date: Date(), categoryType: CategoryType.ENTERTAINMENT)
}
