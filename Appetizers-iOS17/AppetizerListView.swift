//
//  AppetizerListView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct AppetizerListView: View {
    
    @StateObject var viewModel = AppetizerListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.appetizers) { appetizer in
                AppetizerListCell(appetizer: appetizer)
            }
            .navigationTitle("🍟 Appetizers")
            .listStyle(.plain)
        }
        .onAppear {
            //as swiftui cannot call a function, it needs to be executed here
            //this is equivalent to viewdidappear
            viewModel.getAppetizers()
        }
    }
    
    
}

#Preview {
    AppetizerListView()
}
