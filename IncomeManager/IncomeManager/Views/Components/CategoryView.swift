//
//  CategoryView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 18/4/24.
//

import SwiftUI

struct CategoryView: View {
    var categoryType: CategoryType
    var percentage: Int
    var destinatedValue: Int
    var spentValue: Int
    var totalValue: Int
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
                    Text(String(self.percentage) + "%")
                    Spacer()
                }
            }.padding(.bottom, 7.5)
            
            
            HStack {
                Text("Destined" + ":")
                Text(String(self.destinatedValue) + "€")
                Spacer()
            }
            HStack {
                Text("Spent" + ":")
                Text("-" + String(self.spentValue) + "€")

                Spacer()
            }
            
            HStack {
                Spacer()
                Text("Total" + ":")
                Text(String(self.totalValue) + "€")
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
        CategoryView(categoryType: CategoryType.NEEDS, percentage: 50, destinatedValue: 500, spentValue: 200, totalValue: 300, backgroundColor: Color.green)
    }
}

