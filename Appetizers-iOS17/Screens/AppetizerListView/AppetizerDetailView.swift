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
                    NutritionInfo(title: "Calories", value: String(appetizer.calories))
                    NutritionInfo(title: "Carbs", value: "\(appetizer.carbs) g")
                    NutritionInfo(title: "Protien", value: "\(appetizer.protein) g")

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
//                APButton(title: "$\(appetizer.price, specifier: "%.2f") - Add to Order")
                //another way of creating button, using Text and custom modifier below
                Text("$\(appetizer.price, specifier: "%.2f") - Add to Order")
            }
            .modifier(StandardButtonStyle())    // specifying custom button modifier
//            .standardButtonStyle()  // way3 - custom modifier
//            .buttonStyle(.bordered)
//            .tint(.brandPrimary1)
//            .controlSize(.large)
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
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
            
            Text(value)
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}
