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
        //using zstack to overlap loading screen onto navigation view (while loading)
        ZStack {
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
            
            //loading screen 
            if viewModel.isLoading {
                LoadingView()
            }
            
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            //everytime alertItem changes in viewModel, this part .alert get called
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
    
    
}

#Preview {
    AppetizerListView()
}
