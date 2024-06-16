//
//  Order.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 16/06/24.
//

import SwiftUI

final class Order: ObservableObject {
    
    //list to store items of type Appetizer 
    @Published var items: [Appetizer] = []
    
    //variable to calculate total amount in order, by taking sum of prices of all items in the list
    var totalPrice: Double {
        //to check this later
        items.reduce(0) { $0 + $1.price }
    }
    
    //creating fn to add appetizer to orders list
    func add(_ appetizer: Appetizer) {
        items.append(appetizer)
    }
    
    //fn to delete item at specified offset
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
