//
//  Extensions.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import Foundation

// Convert HTML string to attributed string to make it readable
// This is the simplest way of showing HTML Text in attributedText if it is more complex then we need to follow other implementations
extension String {
    var htmlConvertedAttributeString: NSAttributedString? {
        // Here i'm just getting Data of the Attributed String and applying options to show html text by applying stylings to make it readable.
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlConvertedString: String {
        return htmlConvertedAttributeString?.string ?? ""
    }
}
