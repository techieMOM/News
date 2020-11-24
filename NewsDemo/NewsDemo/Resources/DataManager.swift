//
//  DataManager.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import Foundation

class DataManager {
    
    // Getrequest using URLSession data task
    // I have written reusable get request method
    class func HTTPGetRequest ( url : URL,completion:@escaping (Data)->Void) {
        URLSession.shared.dataTask(with: url) {  (data, response, error) in
            guard let jsonData = data else { return }
           completion(jsonData)
        }.resume()
    }
    
    // API call to fetch news from specific source
    // I have attached API_KEY from querystring only as per API
    class func fetchNewsFromSource(_ source : String,completion:@escaping ([Article])->Void) {
        if let newsURL = URL(string: String(format: APIs.newsUrl, source,APIs.API_KEY)) {
            HTTPGetRequest(url: newsURL) { (jsonData) in
                completion(getArticles(jsonData))
            }
        }
        else { completion([])}
    }
    // API to search news
    // I have attached API_KEY from querystring only as per API
    class func searchForNews(_ searchString : String,completion:@escaping ([Article])->Void) {
        if let newsURL = URL(string: String(format: APIs.searchURL, searchString,APIs.API_KEY)) {
            HTTPGetRequest(url: newsURL) { (jsonData) in
              completion(getArticles(jsonData))
            }
        }
        else { completion([])}
    }
    
    // Decoding Json data to Articles array
    class func getArticles (_ jsonData : Data) -> [Article] {
        do{
            let decoder = JSONDecoder()
            let news = try decoder.decode(News.self, from: jsonData)
            return news.articles
        }catch let err{
            print(err)
            return []
        }
    }
}
