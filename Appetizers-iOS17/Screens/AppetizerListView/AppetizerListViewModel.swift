//
//  AppetizerListCellViewModel.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 11/06/24.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject {
    //var to store list data
    @Published var appetizers: [Appetizer] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false 
    //to show detail view 
    @Published var isShowingDetail = false
    //to keep value of selected cell
    @Published var selectedAppetizer: Appetizer?
    
    func getAppetizers() {
        //began loading
        isLoading = true
        
        //calling getAppetizers from nwmanager
        //adding self above, so no need to add self to all variables used within a closure
        NetworkManager.shared.getAppetizers { [self] result in
            //need to run below code in async as it is responsible for setting views
            DispatchQueue.main.async {
                //loading completed - setting to false
                isLoading = false
                
                switch result {
                case .success(let appetizers):
                    self.appetizers = appetizers
                case .failure(let error):
                    switch error {
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
    
}
