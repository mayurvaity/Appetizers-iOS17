//
//  AccountViewModel.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 15/06/24.
//

import SwiftUI

final class AccountViewModel: ObservableObject {
    
    //creating linking to UserDefaults with key "user" (to store in userdefaults)
    //data type is Data, as we need to encode our User obj into Data and then use it
    @AppStorage("user") private var userData: Data?
    
    //obj to store user data
    @Published var user = User()
    
    //alert obj 
    @Published var alertItem: AlertItem?
    
    //fn to save entered values in the form
    func saveChanges() {
        //checking value of the form by triggering below calculated variable
        //this will raise alerts if any issue in field data
        guard isValidForm else {
            return
        }
        
        //encoding data into type Data and storing it into userdefaults
        do {
            //encoding obj user and storing in var named data
            let data = try JSONEncoder().encode(user)
            //assigning it to @AppStorage obj named userData to store into userdefaults
            userData = data
            //creating alert for success
            alertItem = AlertContext.userSaveSuccess
        } catch {
            //creating alert for failure while saving data
            alertItem = AlertContext.invalidUserData
        }
        
    }
    
    
    //fn to retrieve user date from UserDefaults
    func retrieveUser() {
        //checking if @AppStorage obj named "userData" has any value, otherwise skipping further actions, as there is no data saved
        guard let userData else { return }
        
        do {
            //to get data from userdefaults and store it into obj named "user"
            //once captured this data into obj "user", it will automatically get published to variables used in the Form (Account page)
            user = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            //rasing error if any issue while getting data from userdefaults
            alertItem = AlertContext.invalidUserData
        }
    }
    
    
    //a calculated variable that checks if all the field values are entered
    var isValidForm: Bool {
        //checking all the fields have data, if not will raise error alert
        guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.invalidForm
            return false
        }
        
        //checking if email is valid, if not will raise error alert
        guard user.email.isValidEmail else {
            alertItem = AlertContext.invalidEmail 
            return false
        }
        
        return true
    }
    
    
    
}
