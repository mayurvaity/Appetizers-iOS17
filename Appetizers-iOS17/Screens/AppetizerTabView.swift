//
//  ContentView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct AppetizerTabView: View {
    
    //creating environment obj to use below
    //it is an obj that stores list of orders
    @EnvironmentObject var order: Order
    
    var body: some View {
        //to add differnt tabs in tab-bar
        //accentColor - to set color of tab icons and text 
        TabView {
            //1st tab from left - need to specify a view name here (for this tab)
            //tabItem - to specify tab icon and text below this icon
            AppetizerListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
            
            //badge modifier - to add count of items in the order 
            OrderView()
                .tabItem {
                    Label("Order", systemImage: "bag")
                }
                .badge(order.items.count)
        }
        
        
    }
}

#Preview {
    AppetizerTabView()
}
