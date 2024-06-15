//
//  AccountView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name", text: $viewModel.user.firstName)
                        .autocorrectionDisabled(true)
                    TextField("Last Name", text: $viewModel.user.lastName)
                        .autocorrectionDisabled(true)
                    TextField("Email", text: $viewModel.user.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                    DatePicker("Birthday",
                               selection: $viewModel.user.birthDate,
                               displayedComponents: .date)
                    
                    Button {
                        print("Save")
                        viewModel.saveChanges()
                        
                    } label: {
                        Text("Save Changes")
                    }
                
                } header: {
                    Text("Personal Info")
                }
                
                Section {
                    Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
                    Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
                        
                } header: {
                    Text("Requests")
                }
                .tint(.brandPrimary1) //can put tint on entire section, it will b applicable to all the view with in that section

                
            }
            .navigationTitle("🤣 Account")
        }
        .onAppear {
            //on loading of this view, data will be retrieved from userdefaults and loaded into user obj, using below fn 
            viewModel.retrieveUser()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    AccountView()
}
