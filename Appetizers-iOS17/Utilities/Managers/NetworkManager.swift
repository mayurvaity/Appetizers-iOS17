//
//  NetworkManager.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import UIKit

final class NetworkManager {
    //singleton
    static let shared = NetworkManager()
    //creating cache to store Images
    //cache takes a key and an object
    private let cache = NSCache<NSString, UIImage>()
    
    //URL
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let appetizerURL = baseURL + "appetizers"
    
    private init() {}
    
    
    //old way of getting data from API
    //fn to call from view**
    //Result has 2 cases success [Appetizer] and failure APError
    //    func getAppetizers(completed: @escaping (Result<[Appetizer], APError>) -> Void) {
    //        //1. creating url
    //        guard let url = URL(string: appetizerURL) else {
    //            //calling above completion handler then returning
    //            completed(.failure(.invalidURL))
    //            return
    //        }
    //
    //        //2. creating URL session,
    //        //*. url request is created on the fly while passing the parameter
    //        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
    //            //2a. error
    //            //checking if session returned an error
    //            if let error1 = error {
    //                print("\(error1)")
    //                completed(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            //2b. response
    //            //checking if response is there and also of type HTTPURLResponse
    //            //also checking if statuscode of response is 200, (200 means things went good)
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completed(.failure(.invalidResponse))
    //                return
    //            }
    //
    //            //2c. data
    //            //checking if we got data
    //            guard let data = data else {
    //                completed(.failure(.invalidData))
    //                return
    //            }
    //
    //            //2d. decode data into swift obj format, in this case AppetizerResponse
    //            do {
    //                //creating decoder object
    //                let decoder = JSONDecoder()
    //                //decoding data using abv obj
    //                //data will be in appetizer response format, as it is a request (which is an array of appetizer types)
    //                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
    //                //successfully got the data
    //                completed(.success(decodedResponse.request))
    //            } catch {
    //                completed(.failure(.invalidData))
    //            }
    //
    //        }
    //
    //        //3. start the task (resume)
    //        task.resume()
    //    }
    
    
    //new way of getting data from API
    //fn to call from view**
    func getAppetizers() async throws -> [Appetizer] {
        //1. creating url
        guard let url = URL(string: appetizerURL) else {
            throw APError.invalidURL
        }
        
        //getting data and response from url
        let (data, response) = try await URLSession.shared.data(from: url)
        
        
        //2b. response
        //checking if response is there and also of type HTTPURLResponse
        //also checking if statuscode of response is 200, (200 means things went good)
        //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        //            }
        //
        
        //2d. decode data into swift obj format, in this case AppetizerResponse
        do {
            //creating decoder object
            let decoder = JSONDecoder()
            //decoding data using abv obj
            //data will be in appetizer response format, as it is a request (which is an array of appetizer types)
            let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
            //returning array got from API call 
            return decodedResponse.request
        } catch {
            throw APError.invalidData
        }
        
    }
    
    
    //network call fn to download image at the url
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        //creating a cache key, for specified url
        let cacheKey = NSString(string: urlString)
        
        //then checking if there is an object at this cachekey (in our cache), if there is, will return image and call completion handler and return
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        //checking if urlstring is a true URL, if not return
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        //creating URL session using url above
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, respone, error in
            //checking if data is good, if data is good checking if there is an image in the data, if there is no data/ image return
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            //putting this image in cache, so that we dont have to download again
            self.cache.setObject(image, forKey: cacheKey)
            
            //if all above goes fine, sending image to completion handler
            completed(image)
        }
        
        //start the task (resume)
        task.resume()
    }
    
}
