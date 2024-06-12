//
//  LoadingView.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 12/06/24.
//

import SwiftUI

//View created in UIKit
//this will be used in view of the screen ("main" view) as a component
struct ActivityIndicator: UIViewRepresentable {
    //this code is for showing spinning wheel - for loading screen
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.brandPrimary1
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
    
}

//This is the "main" view, for loading screen
struct LoadingView: View {
    var body: some View {
        ZStack {
            //for background color of loading screen
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            //using above created Uikit based view, to show loading animation on top of above mentioned bg color 
            ActivityIndicator()
            
        }
    }
}
