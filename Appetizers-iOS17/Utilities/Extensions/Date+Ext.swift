//
//  Date+Ext.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 18/06/24.
//

import Foundation

//creating minimum and maximum dates, for date range in account form selection 
extension Date {
    
    var eighteenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    }
    
    var oneHundredTenYearsAgo: Date {
        Calendar.current.date(byAdding: .year, value: -110, to: Date())!
    }
}
