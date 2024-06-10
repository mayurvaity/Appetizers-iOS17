//
//  ContentView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct AppetizerTabView: View {
    var body: some View {
        //to add differnt tabs in tab-bar
        //accentColor - to set color of tab icons and text 
        TabView {
            //1st tab from left - need to specify a view name here (for this tab)
            //tabItem - to specify tab icon and text below this icon
            AppetizerListView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Account")
                }
            
            OrderView()
                .tabItem {
                    Image(systemName: "bag")
                    Text("Order")
                }
        }
        .accentColor(Color("brandPrimary"))
        
    }
}

#Preview {
    AppetizerTabView()
}
