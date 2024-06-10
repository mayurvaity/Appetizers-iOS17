//
//  NetworkManager.swift
//  Appetizers-iOS17
//
//  Created by Mayur Vaity on 10/06/24.
//

import Foundation

final class NetworkManager {
    //singleton
    static let shared = NetworkManager()
    
    //URL
    static let baseURL = "http://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    private let appetizerURL = baseURL + "appetizers"
    
    private init() {}
    
    //fn to call from view**
    //Result has 2 cases success [Appetizer] and failure APError
    func getAppetizers(completed: @escaping (Result<[Appetizer], APError>) -> Void) {
        //1. creating url
        guard let url = URL(string: appetizerURL) else {
            //calling above completion handler then returning
            completed(.failure(.invalidURL))
            return
        }
        
        //2. creating URL session, 
        //*. url request is created on the fly while passing the parameter
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            //2a. error
            //checking if session returned an error
            guard let _ = error else {
                completed(.failure(.unableToComplete))
                return
            }
            
            //2b. response
            //checking if response is there and also of type HTTPURLResponse
            //also checking if statuscode of response is 200, (200 means things went good)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            //2c. data
            //checking if we got data
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            //2d. decode data into swift obj format, in this case AppetizerResponse
            do {
                //creating decoder object
                let decoder = JSONDecoder()
                //decoding data using abv obj
                //data will be in appetizer response format, as it is a request (which is an array of appetizer types)
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                //successfully got the data
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        //3. start the task (resume)
        task.resume()
    }
    
}
