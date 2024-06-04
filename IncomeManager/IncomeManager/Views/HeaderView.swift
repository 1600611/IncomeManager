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
    var totalValue: Decimal?
    var color: String?
    
    var body: some View {
        VStack {
            ZStack {
                if let color = self.color {
                    Rectangle()
                        .fill(Color(named: color) ?? Color.gray.opacity(0.1))
                        .frame(height: 100)
                } else {
                    Rectangle()
                        .fill(0 == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                        .frame(height: 100)
                }
                
                HStack() {
                    VStack {
                        CustomBackButton()
                            .padding(.bottom, 60)
                            .padding(.leading, 5)
                    }
                    
                    Spacer()
                    
                    if let totalValue = self.totalValue {
                        VStack(spacing: 5) {
                            Text(title)
                                .foregroundColor(.white)
                                .font(.title2)
                            
                            Text("Total" + ": " + DecimalFormatter.shared.format(totalValue) + "€")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    } else {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.title2)
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
        HeaderView(title: "Needs", totalValue: 300)
    }
}
