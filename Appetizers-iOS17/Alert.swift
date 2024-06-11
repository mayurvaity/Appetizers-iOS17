//
//  Alert.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 11/06/24.
//
import SwiftUI

//data type of alert created
struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

//to store different types of alert data
struct AlertContext {
    static let invalidURL = AlertItem(title: Text("Server error"),
                                              message: Text("There was an issue connecting to the server. If this persists, please contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidResponse = AlertItem(title: Text("Server error"),
                                              message: Text("Invalid response from the server. Please try again later or contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidData = AlertItem(title: Text("Server errors"),
                                              message: Text("The data received from the server was invalid. Please contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server error"),
                                              message: Text("Unable to complete your request at this time. Please check your internet connection."),
                                              dismissButton: .default(Text("OK")))
}

//invalidURL
//case invalidResponse
//case invalidData
//case unableToComplete
