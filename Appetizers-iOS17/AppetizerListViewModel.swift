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
    
    func getAppetizers() {
        //calling getAppetizers from nwmanager
        NetworkManager.shared.getAppetizers { result in
            //need to run below code in async as it is responsible for setting views
            DispatchQueue.main.async {
                switch result {
                case .success(let appetizers):
                    self.appetizers = appetizers
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
