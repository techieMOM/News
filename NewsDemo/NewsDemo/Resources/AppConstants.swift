//
//  AppConstants.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import Foundation

struct APIs {
    public static let newsUrl = "http://newsapi.org/v2/top-headlines?sources=%@&apiKey=%@"
    public static let API_KEY = "5316ce31b0214489b4706c1a8f759055"
    public static let searchURL = "http://newsapi.org/v2/everything?q=%@&sortBy=popularity&apiKey=%@"
}

struct Constants {
    public static let detailsSegue = "segueDetails"
    public static let tagCell = "tagCell"
    public static let articleCell = "articleCell"    
}
