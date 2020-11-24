//
//  ArticleTableViewCell.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImage: CustomImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ article : Article) {
        self.selectionStyle = .none
        self.titleLabel.text = article.title ?? ""
        // some texts are containing html tags to make it readable
        self.content.text = article.description?.htmlConvertedString
        self.publishedDate.text = article.publishedAt ?? ""
        if let imageURL = URL(string: article.urlToImage ?? "") {
            self.articleImage.downloadedFrom(imageURL)
        }
    }

}
