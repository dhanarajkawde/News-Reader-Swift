//
//  NewsDataController.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import Foundation

/// NewsDataController
class NewsDataController: NSObject {
    
    var allNews: [Article]?
    
    /// Fetcch News
    /// - Parameters:
    ///   - searchStr: searchStr
    ///   - page: page
    ///   - completion: completion description
    func fetchNews(searchStr: String, page:Int, completion: @escaping ([Article]?, String?) -> Void) {
        APIService.makeUrlEncodedRequest(parameter: ["q":searchStr, "apiKey":APIService.apiKey, "pageSize":"10", "page":String(page), "sortBy":"relevancy"], method: .GET) { (data, response, error) in
            do
            {
                if let jsonData = data
                {
                    let d = try JSONDecoder().decode(News.self, from: jsonData)
                    if page == 1 { // if first page
                        self.allNews = d.articles
                    }
                    else {
                        self.allNews?.append(contentsOf: d.articles ?? [])
                    }
                    completion(self.allNews, d.status == "ok" ? "" : d.message)
                }
            }
            catch
            {
                print(error)
                completion(nil, nil)
            }
        } failure: { (data, response, error) in
            completion(nil, nil)
        }
        
    }
}
