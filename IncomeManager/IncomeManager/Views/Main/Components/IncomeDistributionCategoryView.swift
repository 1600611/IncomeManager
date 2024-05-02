//
//  IncomeDistributionView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 25/4/24.
//

import SwiftUI

struct IncomeDistributionCategoryView: View {
    @State private var totalPercentage: Int = 0
    @State var localPercentages: [Int]
    @State private var isPresentingPicker = false
    @State private var selectedCategoryIndex = 0
    var categories: [CategoryType]
    var saveIncomeDistributionsAction: ([Int]) -> Void

    var body: some View {
        VStack {
            List {
                ForEach(categories.indices, id: \.self) { index in
                    HStack {
                        Text(categories[index].title)
                        Spacer()
                        if selectedCategoryIndex == index && isPresentingPicker {
                            Picker("", selection: Binding<Int>(
                                get: { localPercentages[selectedCategoryIndex] },
                                set: { newValue in
                                    localPercentages[selectedCategoryIndex] = newValue
                                    updateTotalPercentage()
                                }
                            )) {
                                ForEach(0...100, id: \.self) { percentage in
                                    Text("\(percentage)%").tag(percentage)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100, height: 120)
                        } else {
                            Button(action: {
                                if selectedCategoryIndex == index {
                                    isPresentingPicker.toggle()
                                } else {
                                    isPresentingPicker = true
                                    selectedCategoryIndex = index
                                }
                            }) {
                                Text("\(localPercentages[index])%")
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            
            Button("Save", action: {
                saveIncomeDistributionsAction(localPercentages)
            })
            .padding()
            .disabled(totalPercentage != 100)
        }
        .onAppear {
            updateTotalPercentage()
        }
        .background(Color.clear)
    }
    
    private func updateTotalPercentage() {
        totalPercentage = localPercentages.reduce(0, +)
    }
}

struct IncomeCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let categories = [CategoryType.NEEDS, CategoryType.ENTERTAINMENT, CategoryType.INVESTMENTS, CategoryType.SAVINGS]
        let percentages = [50, 30, 10, 10]
        IncomeDistributionCategoryView(localPercentages: percentages, categories: categories, saveIncomeDistributionsAction: { _ in })
    }
}
