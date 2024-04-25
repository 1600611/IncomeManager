//
//  IncomeDistributionView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 25/4/24.
//

import SwiftUI

struct IncomeDistributionView: View {
    @State private var totalPercentage: Double = 0
    var categories: [CategoryInformation]
    
    var body: some View {
        VStack {
            Text("Assign Percentage to Categories")
                .font(.title)
                .padding()
            
            List {
                ForEach(categories.indices, id: \.self) { index in
                    HStack {
                        Text(categories[index].getCategoryType().title)
                        Spacer()
                        Stepper(
                            value: Binding<Int>(
                                get: { categories[index].getPercentage() },
                                set: { newValue in
                                    categories[index].setPercentage(newValue)
                                }
                            ),
                            in: 0...100
                        ) {
                            Text("\(categories[index].getPercentage())%")
                        }
                    }
                }
            }
            
            Text("Total Percentage: \(totalPercentage, specifier: "%.2f")%")
                .padding()
            
            Button("Save") {
                // Aquí puedes agregar la lógica para guardar los porcentajes
            }
            .padding()
            .disabled(totalPercentage != 100)
        }
        .onAppear {
            updateTotalPercentage()
        }
        .onChange(of: categories) { _ in
            updateTotalPercentage()
        }
    }
    
    private func updateTotalPercentage() {
        totalPercentage = categories.reduce(0) { $0 + $1.getPercentage() }
    }
}

#Preview {
    IncomeDistributionView(categories: [])
}
