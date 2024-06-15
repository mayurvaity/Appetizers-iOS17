//
//  OrderView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct OrderView: View {
    //obj of list of order items
    @State private var orderItems = MockData.orderItems
    
    var body: some View {
        NavigationView {
            VStack {
                //creating list using ForEach, as we need on swipe delete modifier, which is not available in direct List view
                List {
                    ForEach(orderItems) { appetizer in
                        AppetizerListCell(appetizer: appetizer)
                    }
                    .onDelete(perform: deleteItems) //to delete when swiped left 
                    
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
                    APButton(title: "$99.99 - Place Order")
                }
                .padding(.bottom, 25)
            }
            .navigationTitle("🧾 Orders")
            
        }
    }
    
    //fn to delete item at specified offset
    func deleteItems(at offsets: IndexSet) {
        orderItems.remove(atOffsets: offsets)
    }
}

#Preview {
    OrderView()
}
