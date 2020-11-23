//
//  ArticleTableViewCell.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImage: UIImageView!
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

}
