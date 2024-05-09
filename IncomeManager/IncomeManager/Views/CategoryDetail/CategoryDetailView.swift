//
//  CategoryDetailView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 9/5/24.
//

import SwiftUI

struct CategoryDetailView: View {
    var category: CategoryInformation
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(0 == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                    .frame(height: 100)
                
                VStack(alignment: .center, spacing: -10) {
                    CustomBackButton()
                    .padding()
                    
                    Text(category.getCategoryType().title)
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding()
                    
                    Text("Total" + ": " + DecimalFormatter.shared.format(category.getTotalValue()) + "€")
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding()
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
    }
}



struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let categoryInformation = CategoryInformation(categoryType: .NEEDS, percentage: 50, destinatedValue: Decimal(2000), spentValue: Decimal(200), totalValue: Decimal(300))
        CategoryDetailView(category: categoryInformation)
    }
}
