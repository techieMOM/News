//
//  NewsViewController.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import UIKit

class NewsViewController: BaseViewController {
    @IBOutlet weak var articleTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var viewModel: NewsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showOverlay()
        self.articleTable.estimatedRowHeight = 1000
        // Fetching news API
        self.viewModel.fetchNewsFromSource("wired") {_ in
            // Loading news items
            self.loadArticles()
        }
        // Do any additional setup after loading the view.
    }
    
}
// UITableView Delegate and DataSource Methods
extension NewsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.articleCell, for: indexPath) as? ArticleTableViewCell else { return UITableViewCell() }
        let article = self.viewModel.getArticle(indexPath.row)
        cell.setupCell(article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.detailsSegue, sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detialsVc = segue.destination as? NewsDetailsViewController {
            detialsVc.viewModel.article = self.viewModel.getArticle(sender as! Int)
        }
    }
}

// SearchBar Delegate Methods
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
        // as keyboard is not dismissing in this case have added delay of second
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
