//
//  AccountView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    
    //obj to store text field whihch is focused
    @FocusState private var focusedTextField: FormTextField?
    
    //enum of fields which needs to be included in focusing
    enum FormTextField {
        case firstName, lastName, email
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First Name", text: $viewModel.user.firstName)
                        .focused($focusedTextField, equals: .firstName)     //to assign focusedTextField var value of this field, when clicked upon
                        .onSubmit {     //to move focus to next text field (in this case, lastname) when pressed next button
                            focusedTextField = .lastName
                        }
                        .submitLabel(.next)     //setting label of return key on the keyboard
                        .autocorrectionDisabled(true)
                    
                    TextField("Last Name", text: $viewModel.user.lastName)
                        .focused($focusedTextField, equals: .lastName)     //to assign focusedTextField var value of this field, when clicked upon
                        .onSubmit {     //to move focus to next text field (in this case, email) when pressed next button
                            focusedTextField = .email
                        }
                        .submitLabel(.next)     //setting label of return key on the keyboard
                        .autocorrectionDisabled(true)
                    
                    TextField("Email", text: $viewModel.user.email)
                        .focused($focusedTextField, equals: .email)     //to assign focusedTextField var value of this field, when clicked upon
                        .onSubmit {     //to close the keyboard when pressed return (as this is the last field)
                            focusedTextField = nil
                        }
                        .submitLabel(.continue)     //setting label of return key on the keyboard
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .autocorrectionDisabled(true)
                    
                    //in below, default date is today's date
//                    DatePicker("Birthday",
//                               selection: $viewModel.user.birthDate,
//                               displayedComponents: .date)
//                    
                    
                    //specifying date range for minimum and max date range that user is allowed to select
                    // minimum is 18 yrs (as it is an app for bar)
                    // maximum is 110 yrs 
                    DatePicker("Birthday",
                               selection: $viewModel.user.birthDate,
                               in: Date().oneHundredTenYearsAgo...Date().eighteenYearsAgo,
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
            .toolbar { // to add dismiss button on top of the keyboard, to be able to dismiss the keyboard (if necessary)
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss") {
                        focusedTextField = nil
                    }
                }
            }
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
