//
//  AppetizerDetailView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 13/06/24.
//

import SwiftUI

struct AppetizerDetailView: View {
    
    //creating environment obj to use below
    //it is an obj that stores list of orders
    @EnvironmentObject var order: Order 
    
    //obj to store selected appetizer
    let appetizer: Appetizer
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack {
            AppetizerRemoteImage(urlString: appetizer.imageURL)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 225)
            
            VStack {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(appetizer.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                
                HStack(spacing: 40) {
                    NutritionInfo(title: "Calories", value: appetizer.calories)
                    NutritionInfo(title: "Carbs", value: appetizer.carbs)
                    NutritionInfo(title: "Protien", value: appetizer.protein)

                }
            }
            
            Spacer()
            
            Button {
                print("Tapped")
                //adding selected appetizer to order list, "order" obj in this case 
                order.add(appetizer)
                //to dismiss detail view once item is added to the cart 
                isShowingDetail = false
            } label: {
                APButton(title: "$\(appetizer.price, specifier: "%.2f") - Add to Order")
            }
            .padding(.bottom, 30)
            
        }
        .frame(width: 300, height: 525)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 40)
        .overlay(Button {
            print("dismiss")
            isShowingDetail = false
        } label: {
            XDismissButton() 
        }, alignment: .topTrailing)
        
        //above overlay is for creating close button at the top right hand corner
    }
}

#Preview {
    AppetizerDetailView(appetizer: MockData.sampleAppetizer,
                        isShowingDetail: .constant(true))
}

struct NutritionInfo: View {
    
    let title: String
    let value: Int
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
            
            Text("\(value)")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
