//
//  AppetizerListCell.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct AppetizerListCell: View {
    
    let appetizer: Appetizer 
    
    var body: some View {
        HStack {
            Image("asian-flank-steak")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            //spacing - to add some space between name and price
            VStack(alignment: .leading, spacing: 5) {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                //specifier - to specify decimal type while converting to string 
                Text("$\(appetizer.price, specifier: "%.2f")")
                    .foregroundStyle(Color(.secondaryLabel))
                    .fontWeight(.semibold)
            }
            .padding(.leading)
            
        }
    }
}

#Preview {
    AppetizerListCell(appetizer: MockData.sampleAppetizer)
}
