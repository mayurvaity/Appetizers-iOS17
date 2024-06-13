//
//  RemoteImage.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 12/06/24.
//

import SwiftUI

// this file is like a ViewModel for downloading images

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    
    //fn performing tasks to call download image fn and converting and putting image in var
    func load(fromURLString urlString: String) {
        //calling fn to download image
        NetworkManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            
            //checking if we got an image from calling download image fn, if we have not then return
            guard let uiImage = uiImage else {
                return
            }
            
            DispatchQueue.main.async {
                //converting and setting this image to published var for app wide use
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}


//creating a view to handle if nil and giving placeholder at its place
//this is a helper view
struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        //if image is available then will use it otherwise use placeholder image
        image?.resizable() ?? Image("food-placeholder").resizable()
    }
}


//this view will be used in content view, instead of basic Image view
//it will fetch image from web, if image not available will take placeholder image and show it
//this will be done when list gets loaded
struct AppetizerRemoteImage: View {
    //obj of struct, which will return a usable image
    @StateObject var imageLoader = ImageLoader()
    //url string to get url
    let urlString: String
    
    var body: some View {
        //setting image received from below method call in .onAppear
        RemoteImage(image: imageLoader.image)
            .onAppear {
                //calling load method to get image from url (from onAppear)
                imageLoader.load(fromURLString: urlString)
            }
    }
}


