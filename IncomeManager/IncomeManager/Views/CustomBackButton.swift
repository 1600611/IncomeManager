//
//  CustomBackButtonView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 9/5/24.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
        }
    }
}

struct CustomBackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
    }
}
