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
                        .frame(height: 120)
                } else {
                    Rectangle()
                        .fill(themeManager.selectedIndex == 0 ? CustomColor.lightComponentsBackground : CustomColor.darkComponentsBackground)
                        .frame(height: 120)
                }
                
                HStack() {
                    VStack {
                        CustomBackButton()
                            .padding(.leading, 5)
                            .padding(.top, 5)
                    }
                    
                    Spacer()
                    
                    if let totalValue = self.totalValue {
                        VStack(spacing: 5) {
                            Text(title)
                                .foregroundColor(.white)
                                .font(.title2)
                            
                            HStack {
                                Text("Total:")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(DecimalFormatter.shared.format(totalValue) + "€")
                                    .foregroundColor(totalValue < 0 ? CustomColor.darkRed : .white)
                                    .font(.headline)
                            }
                        }
                        .padding(.top, 25)
                    } else {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(edges: .vertical)
        .navigationBarBackButtonHidden()
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Needs", totalValue: 300)
    }
}
