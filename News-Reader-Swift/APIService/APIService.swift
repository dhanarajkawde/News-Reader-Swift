//
//  APIService.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import Foundation

//HTTP Methods
enum HttpMethod : String {
    case  GET
    case  POST
    case  DELETE
    case  PUT
}

typealias Parameters = [String: String]

/// Class to make API Calls
class APIService {
    static var sharedInstance = APIService()
    private init() {}
    
    static let apiKey = "0cdf95b15cd2403c953bbfa203700a77" //"0cdf95b15cd2403c953bbfa203700a77" //be27a8ef69a74526bb8665d3f63cd8fe
    static let baseUrl = "https://newsapi.org/v2/"
    static let everything = "everything"
    
    static func makeUrlEncodedRequest(parameter: Parameters, method: HttpMethod, success:@escaping ( Data?, HTTPURLResponse?, Error? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?, NSError? )-> Void) {
        let apiUrl = URL(string: APIService.baseUrl + APIService.everything)!

        var urlComponents = URLComponents(url: apiUrl, resolvingAgainstBaseURL: false)!
        var queryItem = [URLQueryItem]()
        for param in parameter {
            queryItem.append(URLQueryItem(name: param.key, value: param.value))
        }
        urlComponents.queryItems = queryItem

        let finalUrl = urlComponents.url!
        var request = URLRequest(url: finalUrl)

        request.httpMethod = method.rawValue

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let data = data {
                success(data, response as? HTTPURLResponse, error as NSError?)
            }
            else {
                failure(data , response as? HTTPURLResponse, error as NSError?)
            }
        }
        task.resume()
    }
}
