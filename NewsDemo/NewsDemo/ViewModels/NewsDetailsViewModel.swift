//
//  NewsDetailsViewModel.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

class NewsDetailsViewModel: NSObject {
    var article : Article?
    var tagsList = [String]()
    var tagsCount : Int {
        return tagsList.count
    }
    func getTag(_ index : Int) -> String {
        return tagsList[index]
    }
}
