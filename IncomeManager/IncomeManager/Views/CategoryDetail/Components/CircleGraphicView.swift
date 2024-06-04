//
//  CircleGraphicView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 16/5/24.
//

import SwiftUI

struct DonutChart: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.6 // Ajusta el valor según el grosor deseado
        
        path.move(to: CGPoint(x: center.x + outerRadius * cos(CGFloat(startAngle.radians)), y: center.y + outerRadius * sin(CGFloat(startAngle.radians))))
        
        path.addArc(center: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        path.addLine(to: CGPoint(x: center.x + innerRadius * cos(CGFloat(endAngle.radians)), y: center.y + innerRadius * sin(CGFloat(endAngle.radians))))
        
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        
        path.closeSubpath()
        
        return path
    }
}

struct CircleGraphicView: View {
    var destined: Decimal
    var totalMonthExpended: Decimal
    var expensesInformation: [ExpenseInformation]
    
    var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height) / 2 * 0.6
            let circleDiameter = radius * 2
            
            ZStack {
                DonutChart(startAngle: .degrees(0), endAngle: .degrees(360))
                    .fill(Color.gray.opacity(0.3))
                
                ForEach(expensesInformation.indices, id: \.self) { index in
                    let startAngle: Double = index == 0 ? 0 : expensesInformation[0..<index].reduce(0) { $0 + ($1.getPercentage() as NSDecimalNumber).doubleValue } / 100 * 360
                    let endAngle: Double = startAngle + ((expensesInformation[index].getPercentage() as NSDecimalNumber).doubleValue / 100 * 360)
                    
                    DonutChart(startAngle: .degrees(startAngle), endAngle: .degrees(endAngle))
                        .fill(Color(named: expensesInformation[index].getColor()) ?? Color.gray)
                }
                
                Circle()
                    .fill(Color.white)
                    .frame(width: circleDiameter, height: circleDiameter)
                
                VStack {
                    Text(DecimalFormatter.shared.format(self.destined) + "€")
                        .foregroundColor(.black)
                        .font(.title3)
                    Text("\(self.totalMonthExpended > 0 ? "-" : "")" + DecimalFormatter.shared.format(self.totalMonthExpended) + "€")
                        .foregroundColor(.black)
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height))
        }
    }
}

struct CircleGraphicView_Previews: PreviewProvider {
    static var previews: some View {
        let destined: Decimal = 2000
        let totalMonthExpended: Decimal = 1000
        let expensesInformation: [ExpenseInformation] = []
        CircleGraphicView(destined: destined, totalMonthExpended: totalMonthExpended, expensesInformation: expensesInformation)
    }
}

