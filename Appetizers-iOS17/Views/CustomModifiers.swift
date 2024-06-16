//
//  CustomModifiers.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 16/06/24.
//

import SwiftUI

//custom modifier created to apply style to buttons
struct StandardButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        //below mentioned modifiers would be applied to the view to which this modifier is specified 
        content
            .buttonStyle(.bordered)
            .tint(.brandPrimary1)
            .controlSize(.large)
    }
}


//for way3 - custom modifier 
extension View {
    func standardButtonStyle() -> some View {
        self.modifier(StandardButtonStyle())
    }
}
