//
//  CategoryView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct CategoryView: View {
    var categoryType: CategoryType
    var percentage: Double
    var destinatedValue: Decimal
    var spentValue: Decimal
    var totalValue: Decimal
    var backgroundColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            VStack(spacing: 5) {
                HStack {
                    Spacer()
                    Text(self.categoryType.title)
                        .font(.headline)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text(String(self.percentage * 100) + "%")
                    Spacer()
                }
            }.padding(.bottom, 7.5)
            
            
            HStack {
                Text("Destined" + ":")
                Text(DecimalFormatter.shared.format(self.destinatedValue) + "€")
                Spacer()
            }
            HStack {
                Text("Spent" + ":")
                Text("-" + DecimalFormatter.shared.format(self.spentValue) + "€")
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("Total" + ":")
                Text(DecimalFormatter.shared.format(self.totalValue) + "€")
                Spacer()
            }.padding(.top, 12.5)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.width / 2 - 20)
        .background(self.backgroundColor)
        .border(Color.black, width: 1.25)
        .cornerRadius(5)
        .foregroundColor(.white)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(categoryType: .NEEDS, percentage: 50, destinatedValue: Decimal(500), spentValue: Decimal(200), totalValue: Decimal(300), backgroundColor: .green)
    }
}
