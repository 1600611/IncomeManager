//
//  CategoryDetailView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 9/5/24.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var title: LocalizedStringResource
    var totalValue: Decimal
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                    .frame(height: 100)
                
                HStack() {
                    VStack {
                        CustomBackButton()
                            .padding(.bottom, 60)
                            .padding(.leading, 5)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.title2)
                        
                        Text("Total" + ": " + DecimalFormatter.shared.format(totalValue) + "€")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "NEEDS", totalValue: 300)
    }
}
