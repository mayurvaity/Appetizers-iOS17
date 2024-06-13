//
//  AppetizerListView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct AppetizerListView: View {
    
    @StateObject var viewModel = AppetizerListViewModel()
    @State private var isShowingDetail = false 
    //to keep value of selected cell
    @State private var selectedAppetizer: Appetizer?
    
    var body: some View {
        //using zstack to overlap loading screen onto navigation view (while loading)
        ZStack {
            NavigationView {
                List(viewModel.appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                        .onTapGesture {
                            selectedAppetizer = appetizer
                            isShowingDetail = true
                        }
                }
                .navigationTitle("🍟 Appetizers")
                .listStyle(.plain)
                .disabled(isShowingDetail)  // to disable list view when clicked on a cell
            }
            .onAppear {
                //as swiftui cannot call a function, it needs to be executed here
                //this is equivalent to viewdidappear
                viewModel.getAppetizers()
            }
            .blur(radius: isShowingDetail ? 20 : 0)  //to make this navigation view when clicked on a cell
            
            
            //detail view
            if isShowingDetail {
                AppetizerDetailView(appetizer: selectedAppetizer ?? MockData.sampleAppetizer, 
                                    isShowingDetail: $isShowingDetail)
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
