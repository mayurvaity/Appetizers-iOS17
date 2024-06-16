//
//  EmptyState.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 15/06/24.
//

import SwiftUI

struct EmptyState: View {
    
    let imageName: String
    let message: String
    
    var body: some View {
        ZStack {
            //setting background color for empty state view
            Color(.systemBackground)
                .ignoresSafeArea(.all)
            
            //offset - this modifier is used to adjust this view on screen along x or y axes
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                
                Text(message)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding()
            }
            .offset(y: -50)
        }
    }
}

#Preview {
    EmptyState(imageName: "empty-order", message: "This is our test message.\nI'm making it a little long for testing.")
}
