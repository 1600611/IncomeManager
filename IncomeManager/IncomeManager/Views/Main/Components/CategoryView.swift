//
//  CategoryView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var category: CategoryInformation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
            
            VStack(spacing: 5) {
                HStack {
                    Spacer()
                    Text(self.category.getCategoryType().title)
                        .font(.headline)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text(String(self.category.getPercentage()) + "%")
                        .font(.subheadline)
                    Spacer()
                }
            }.padding(.bottom, 30)
            
            
            HStack {
                Text("Destined:")
                Spacer()
                Text(DecimalFormatter.shared.format(self.category.getDestinatedValue()) + "€")
                    .font(.system(size: 12.5))
            }
            HStack {
                Text("Spent:")
                Spacer()
                Text("-" + DecimalFormatter.shared.format(self.category.getSpentValue()) + "€")
                    .font(.system(size: 12.5))
            }
            
            HStack {
                Spacer()
                Text("Total" + ":")
                Text(DecimalFormatter.shared.format(self.category.getTotalValue()) + "€")
                Spacer()
            }.padding(.top, 25)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width / 2 - 5, height: UIScreen.main.bounds.width / 1.85)
        .background(0 == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
        .border(Color.black, width: 1.25)
        .cornerRadius(5)
        .foregroundColor(.white)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let categoryInformation = CategoryInformation(categoryType: .NEEDS, percentage: 50, destinatedValue: Decimal(2000), spentValue: Decimal(200), totalValue: Decimal(300))
        CategoryView(category: categoryInformation)
    }
}
