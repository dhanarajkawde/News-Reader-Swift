//
//  NewsDetailsViewController.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import UIKit
import SDWebImage
import SafariServices

/// NewsDetailsViewController
class NewsDetailsViewController: UIViewController {

    /// IBOutlets
    @IBOutlet weak var scrlViwCustom: UIScrollView!
    @IBOutlet weak var viwBack: UIView!
    @IBOutlet weak var imgViwNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnMoreDetails: UIButton!
    
    /// Properties
    static let identifier = "NewsDetailsViewController"
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnMoreDetails.addCornerRadius(radius: self.btnMoreDetails.frame.size.height/2)
        
        self.setData()
    }
    
    /// Set data
    func setData() {
        self.lblTitle.text = self.article?.title
        self.lblAuthor.text = "by: \(self.article?.author ?? "")"
        self.lblDescription.text = self.article?.description
        self.imgViwNews.sd_setImage(with: URL(string: article?.urlToImage ?? ""), placeholderImage: UIImage(named: "news-placeholder"))
        
        self.lblDate.text = Constants.convertServerDateToCurrentDate(serverDate: article?.publishedAt ?? "")
    }
    
    /// Open Safari View for more details
    /// - Parameter sender: sender description
    @IBAction func btnMoreDetailsClicked(_ sender: UIButton) {
        if let url = URL(string: (article?.url ?? "").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            let controller = SFSafariViewController(url: url)
            self.present(controller, animated: false, completion: nil)
        }
    }
}
