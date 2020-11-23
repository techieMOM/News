//
//  NewsDetailsViewController.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

class NewsDetailsViewController: BaseVC {
    @IBOutlet var viewModel: NewsDetailsViewModel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var articleImage: CustomImageView!
    @IBOutlet weak var tagsCollection: UICollectionView!
    @IBOutlet weak var heightOfCollectionView: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = self.viewModel.article {
            DispatchQueue.main.async {
                if let imageURL = URL(string: article.urlToImage ?? "") {
                    self.articleImage.downloadedFrom(url: imageURL)
                }
            }
            self.setNavTitle(article.title ?? "")
            self.details.text = article.description?.htmlToString
            self.setupCollection()
            // As we don't have tags from API i did break the title and shown for demo purpose.
            self.viewModel?.tagsList = article.title?.components(separatedBy: " ") ?? []
        }
        // Do any additional setup after loading the view.
    }
    
    // we can make it reusable if more controllers are there
    // 2 line navbar title
    func setNavTitle(_ title : String) {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        label.textColor = .black
        label.text = title
        self.navigationItem.titleView = label
    }
}
// To show label in tags format used collection view with custim flow layout
extension NewsDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.tagsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as? TagsCollectionViewCell else {return UICollectionViewCell()}
        heightOfCollectionView.constant = tagsCollection.contentSize.height
        cell.tagLabel.text = self.viewModel.getTag(indexPath.item)
        cell.tagLabel.layer.cornerRadius = 8.0
        cell.tagLabel.clipsToBounds = true
        return cell
    }
    func setupCollection() {
        let layout = TagsCollectionViewLayout()
        tagsCollection.collectionViewLayout = layout
        tagsCollection.delegate = self
        tagsCollection.dataSource = self
        if self.viewModel.tagsList.isEmpty {
            heightOfCollectionView.constant = 0
        } else {
            tagsCollection.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Size of the cell based on text size and padding
        let item = self.viewModel.getTag(indexPath.item)
        if let font = UIFont(name: "GTWalsheimPro-Regular", size: 12.0) {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size: CGSize = item.size(withAttributes: fontAttributes)
        return CGSize(width: size.width + 12, height: 20.0)
        }
        return .zero
    }
    
}
