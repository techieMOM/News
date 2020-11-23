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
        // Fetching news API
        self.viewModel.fetchNewsFromSource("wired") {_ in
            // Loading news items
            self.loadArticles()
        }
        // Do any additional setup after loading the view.
    }
    
}
extension NewsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        let article = self.viewModel.getArticle(indexPath.row)
        cell.selectionStyle = .none
        cell.titleLabel.text = article.title ?? ""
        // some texts are containing html tags to make it readable
        cell.content.text = article.description?.htmlToString
        cell.publishedDate.text = article.publishedAt ?? ""
        if let imageURL = URL(string: article.urlToImage ?? "") {
            cell.articleImage.downloadedFrom(url: imageURL)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueDetails", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detialsVc = segue.destination as? NewsDetailsViewController {
            detialsVc.viewModel.article = self.viewModel.getArticle(sender as! Int)
        }
    }
}
extension NewsViewController : UISearchBarDelegate {
    // If user clicks on Search button in keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? false{
            self.showWiredList()
        }else {
            searchBar.resignFirstResponder()
            self.showOverlay()
            // Seraching articles
            self.viewModel.searchForNews(searchBar.text ?? "") {_ in
                self.loadArticles()
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // If user clicks on X mark in search bar
            self.showWiredList()
        }
        // To get Search results while typing here in else block we need to call the API
        // As data is from API i have made call when only search pressed.
        // If it is local i will prefer making the call in else block
    }
    
    func showWiredList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.searchBar.resignFirstResponder()
        }
        self.viewModel.cancelSearch()
        self.loadArticles()
    }
    
    func loadArticles() {
        DispatchQueue.main.async {
            self.articleTable.reloadData()
            self.hideOverLay()
        }
    }
}
