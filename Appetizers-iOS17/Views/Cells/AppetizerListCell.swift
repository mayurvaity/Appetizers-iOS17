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
            //old way of getting image from API and showing in as a view
//            AppetizerRemoteImage(urlString: appetizer.imageURL)
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 120, height: 90)
//                .clipShape(RoundedRectangle(cornerRadius: 8))
//            
            
            //new way of getting image from URL and showing here directly - async Image -
            //it handles both getting image from web as well as if image not found (on web), it replaces it with placeholder
            //dwonside: it doesnot cache images like our custom view above, so images will be downloaded again and again
            //not suitable for big list of cells
            AsyncImage(url: URL(string: appetizer.imageURL)) { image in
                //if image was found, we can assign modifiers to it here
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } placeholder: {
                //if image not found (on web), we can use placeholder specified below
                Image("food-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            
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
