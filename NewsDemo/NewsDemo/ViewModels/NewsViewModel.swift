//
//  NewsViewModel.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

class NewsViewModel: NSObject {
    // Original Wired Data it contains
    var articles = [Article]()
    // To maintain Data during Search and normal
    var filteredArticles = [Article]()
    var articleCount : Int {
        return self.filteredArticles.count
    }
    func getArticle(_ index : Int) -> Article {
        return self.filteredArticles[index]
    }
    func cancelSearch() {
        self.filteredArticles = self.articles
    }
    func fetchNewsFromSource(_ source : String,completion:@escaping (Bool)->Void) {
        DataManager.fetchNewsFromSource(source) { (items) in
            self.filteredArticles = items
            self.articles = items
            completion(true)
        }
    }
    func searchForNews(_ searchString : String,completion:@escaping (Bool)->Void) {
        DataManager.searchForNews(searchString) { (items) in
            self.filteredArticles = items
            completion(true)
        }
    }
}
