//
//  AppetizerListCellViewModel.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 11/06/24.
//

import SwiftUI

//tagging with @MainActor makes code in below class to route through main thread 
//@MainActor - A singleton actor whose executor is equivalent to the main dispatch queue.
@MainActor final class AppetizerListViewModel: ObservableObject {
    //var to store list data
    @Published var appetizers: [Appetizer] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false 
    //to show detail view 
    @Published var isShowingDetail = false
    //to keep value of selected cell
    @Published var selectedAppetizer: Appetizer?
    
    //fn for old way of API call
//    func getAppetizers() {
//        //began loading
//        isLoading = true
//        
//        //calling getAppetizers from nwmanager
//        //adding self above, so no need to add self to all variables used within a closure
//        NetworkManager.shared.getAppetizers { [self] result in
//            //need to run below code in async as it is responsible for setting views
//            DispatchQueue.main.async {
//                //loading completed - setting to false
//                isLoading = false
//                
//                switch result {
//                case .success(let appetizers):
//                    self.appetizers = appetizers
//                case .failure(let error):
//                    switch error {
//                    case .invalidResponse:
//                        alertItem = AlertContext.invalidResponse
//                        
//                    case .invalidURL:
//                        alertItem = AlertContext.invalidURL
//                        
//                    case .invalidData:
//                        alertItem = AlertContext.invalidData
//                        
//                    case .unableToComplete:
//                        alertItem = AlertContext.unableToComplete
//                    }
//                }
//            }
//        }
//    }
    
    
    //fn for - new way (i.e., async away) of API call 
    func getAppetizers() {
        //began loading
        isLoading = true
        
        //calling method from NetworkManager to get appetizers data from API, and assigning this data to list (published) used in the view
        //also setting is loading to false, no matter what response we get loading should stop after the API call
        Task {
            do {
                appetizers = try await NetworkManager.shared.getAppetizers()
                isLoading = false
            } catch {
                //checking if error is of our custom type
                if let apError = error as? APError {
                    //if error is of type APError
                    switch apError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    //if error is not of type APError, then triggering general alert
                    alertItem = AlertContext.invalidResponse
                }
                isLoading = false
            }
        }
    }
    
    
}
