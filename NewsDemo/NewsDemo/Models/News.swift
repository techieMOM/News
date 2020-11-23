//
//  News.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import Foundation
class News : Decodable {
    var articles = [Article]()
    private enum CodingKeys : String,CodingKey {
        case articles
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent([Article].self, forKey: .articles) ?? []

    }
}
class Article : Decodable {
    var author  : String?
    var title  : String?
    var description  : String?
    var url  : String?
    var urlToImage  : String?
    var publishedAt  : String?
    var content  : String?
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        publishedAt = self.getDateString(publishedAt ?? "")
        content = try values.decodeIfPresent(String.self, forKey: .content) ?? ""
    }
    func  getDateString(_ dateTime : String) -> String {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy.MM.dd"

        if let date = dateFormatter1.date(from: dateTime) {
            return dateFormatter2.string(from: date)
        } else {
            return dateTime.isEmpty ? dateTime : (dateTime.components(separatedBy: "T").first)?.replacingOccurrences(of: "-", with: ".") ?? dateTime
        }
    }
}
