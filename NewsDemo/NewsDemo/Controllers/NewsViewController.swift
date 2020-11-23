//
//  NewsViewController.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

class NewsViewController: BaseVC {
    @IBOutlet weak var articleTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var viewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showOverlay()
        self.viewModel.fetchNewsFromSource("wired") {_ in
            self.loadArticles()
        }
        // Do any additional setup after loading the view.
    }

}
extension NewsViewController : UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        let article = self.viewModel.getArticle(indexPath.row)
        cell.selectionStyle = .none
        cell.titleLabel.text = article.title ?? ""
        cell.content.text = article.description ?? ""
        cell.publishedDate.text = article.publishedAt ?? ""
        if let imageURL = URL(string: article.urlToImage ?? "") {
            DataManager.HTTPGetRequest(url: imageURL) { (imageData) in
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                    cell.articleImage?.backgroundColor = .clear
                    cell.articleImage?.image = image
                    }
                }
            }
        }
        return cell
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.showOverlay()
        self.viewModel.searchForNews(searchBar.text ?? "") {_ in
            self.loadArticles()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            searchBar.resignFirstResponder()
            }
            self.viewModel.cancelSearch()
            self.loadArticles()
        }
        // To get Search results while typing here in else block we need to call the API
        // As data is from API i have made call when only search pressed.
        // If it is local i will prefer making the call in else block
    }
    
    func loadArticles() {
        DispatchQueue.main.async {
            self.articleTable.reloadData()
            self.hideOverLay()
        }
    }
}
