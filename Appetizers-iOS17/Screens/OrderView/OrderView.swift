//
//  OrderView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct OrderView: View {
    
    //creating environment obj to use below
    //it is an obj that stores list of orders
    @EnvironmentObject var order: Order
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    //creating list using ForEach, as we need on swipe delete modifier, which is not available in direct List view
                    List {
                        ForEach(order.items) { appetizer in
                            AppetizerListCell(appetizer: appetizer)
                        }
                        .onDelete(perform: order.deleteItems) //to delete when swiped left
                        
                        //alternate way of writing deletion code
                        //                    .onDelete { indexSet in
                        //                        //onDelete is used for swipe to delete a cell in order list
                        //                        //to delete order item obj at specified index
                        //                        //indexSet is the index which needs to be deleted
                        //                        orderItems.remove(atOffsets: indexSet)
                        //                    }
                    }
                    .listStyle(PlainListStyle()) //for list created using ForEach loop this needs to be specified
                    
                    Button {
                        print("Order placed")
                    } label: {
                        APButton(title: "$\(order.totalPrice, specifier: "%.2f") - Place Order")
                    }
                    .padding(.bottom, 25)
                }
                
                // this vw will appear when above list is empty 
                if order.items.isEmpty {
                    EmptyState(imageName: "empty-order", message: "You have no items in your order.\nPlease add an appetizer!")
                }
            }
            .navigationTitle("🧾 Orders")
            
        }
    }
    
    
}

#Preview {
    OrderView()
}
