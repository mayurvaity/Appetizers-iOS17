//
//  User.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 15/06/24.
//

import Foundation

struct User: Codable {
    
    var firstName = ""
    var lastName = ""
    var email = ""
    var birthDate = Date()
    var extraNapkins = false
    var frequentRefills = false
    
}
