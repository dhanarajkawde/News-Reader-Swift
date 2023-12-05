//
//  ViewController.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import UIKit

/// NewsListViewController
class NewsListViewController: UIViewController {
    
    /// IBOutlets
    @IBOutlet weak var searchBarNews: UISearchBar!
    @IBOutlet weak var collectionViewNews: UICollectionView!
    
    /// Properties
    var searchStr = Constants.staticSearchString
    var page = 1
    var activityIndicator = UIActivityIndicatorView()
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    let dataController = NewsDataController()
    
    // MARK: Controller Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewNews.register(NewsCollectionViewCell.self)
        self.searchBarNews.delegate = self
        
        activityIndicator.style = .large
        activityIndicator.alpha = 1.0
        self.view.addSubview(activityIndicator)
        self.activityIndicator.center = CGPointMake(UIScreen.main.bounds.width/2, UIScreen.main.bounds.height/2)
        
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/2.1, height: 270)
        self.collectionViewNews.collectionViewLayout = self.flowLayout
        
        self.fetchNews()
    }
    
    // MARK: Custom methods
    
    /// Fetch News
    func fetchNews() {
        self.activityIndicator.startAnimating()
        self.dataController.fetchNews(searchStr: self.searchStr, page: self.page) { data, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if error == "" {
                    self.collectionViewNews.reloadData()
                }
                else {
                    self.showAlert(message: error ?? "")
                }
            }
        }
    }
    
    /// Show Alert
    /// - Parameter message: error message
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.error, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension NewsListViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataController.allNews?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsCollectionViewCell = self.collectionViewNews.dequeueReusableCell(for: indexPath)
        cell.setData(article: self.dataController.allNews?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if((self.dataController.allNews?.count ?? 0) > 1){ // handle pagination
            if(indexPath.row == (self.dataController.allNews?.count ?? 0) - 1) {
                self.page += 1;
                self.fetchNews()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsDetailsViewController: NewsDetailsViewController = UIStoryboard.main.instantiateViewController(withIdentifier: NewsDetailsViewController.identifier) as! NewsDetailsViewController
        newsDetailsViewController.article = self.dataController.allNews?[indexPath.row]
        self.navigationController?.pushViewController(newsDetailsViewController, animated: true)
    }
}

// MARK: UISearchBarDelegate
extension NewsListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" { // if searchbar text is not empty
            self.searchStr = searchBar.text ?? ""
        }
        else {
            self.searchStr = Constants.staticSearchString
        }
        self.page = 1
        self.dataController.allNews?.removeAll()
        self.view.endEditing(true)
        self.fetchNews()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" { // if searchbar text is empty
            self.page = 1
            self.searchStr = Constants.staticSearchString
            self.dataController.allNews?.removeAll()
            self.view.endEditing(true)
            self.fetchNews()
        }
    }
}
