//
//  CustomImageView.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

// Custom ImageView to download image from URL and assiging
class CustomImageView: UIImageView {
    // To download the image from URL and assigning created custom view
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        self.image = nil
        self.backgroundColor = .clear
        DataManager.HTTPGetRequest(url: url) { (data) in
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }

}
