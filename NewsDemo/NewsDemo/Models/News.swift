//
//  News.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import Foundation

// News Model getting other info but i'm just showing what is required.
struct News : Decodable {
    var articles = [Article]()
    private enum CodingKeys : String,CodingKey {
        case articles
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent([Article].self, forKey: .articles) ?? []

    }
}

struct Article : Decodable {
    var author  : String?
    var title  : String?
    var description  : String?
    var urlToImage  : String?
    var publishedAt  : String?
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case description
        case urlToImage
        case publishedAt
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        description = try values.decodeIfPresent(String.self, forKey: .description) ?? ""
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage) ?? ""
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt) ?? ""
        publishedAt = self.getDateString(publishedAt ?? "")
    }
    // Converting Date String In model priorly
    // Here is some cases Date String is not in proper format in that case i have trimmed the string as we required.
    func  getDateString(_ dateTime : String) -> String {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy.MM.dd"

        if let date = dateFormatter1.date(from: dateTime) {
            return dateFormatter2.string(from: date)
        } else {
            return dateTime.isEmpty ? dateTime : (dateTime.components(separatedBy: "T").first)?.replacingOccurrences(of: "-", with: ".") ?? dateTime
        }
    }
}
