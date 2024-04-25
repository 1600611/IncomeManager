//
//  CategoryView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct CategoryView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var categoryInformation: CategoryInformation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7.5) {
            
            VStack(spacing: 5) {
                HStack {
                    Spacer()
                    Text(self.categoryInformation.getCategoryType().title)
                        .font(.headline)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Text(String(self.categoryInformation.getPercentage() * 100) + "%")
                        .font(.subheadline)
                    Spacer()
                }
            }.padding(.bottom, 7.5)
            
            
            HStack {
                Text("Destined" + ":")
                Spacer()
                Text(DecimalFormatter.shared.format(self.categoryInformation.getDestinatedValue()) + "€")
                    .font(.system(size: 12.5))
            }
            HStack {
                Text("Spent" + ":")
                Spacer()
                Text("-" + DecimalFormatter.shared.format(self.categoryInformation.getSpentValue()) + "€")
                    .font(.system(size: 12.5))
            }
            
            HStack {
                Spacer()
                Text("Total" + ":")
                Text(DecimalFormatter.shared.format(self.categoryInformation.getTotalValue()) + "€")
                Spacer()
            }.padding(.top, 12.5)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width / 2 - 20, height: UIScreen.main.bounds.width / 2 - 40)
        .background(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
        .border(Color.black, width: 1.25)
        .cornerRadius(5)
        .foregroundColor(.white)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        let categoryInformation = CategoryInformation(categoryType: .NEEDS, percentage: 0.5, destinatedValue: Decimal(2000), spentValue: Decimal(200), totalValue: Decimal(300))
        CategoryView(categoryInformation: categoryInformation)
    }
}
