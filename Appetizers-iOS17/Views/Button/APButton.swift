//
//  APButton.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 13/06/24.
//

import SwiftUI

struct APButton: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 250, height: 50)
            .foregroundStyle(.white)
            .background(Color.brandPrimary1)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    APButton(title: "Test button")
}
