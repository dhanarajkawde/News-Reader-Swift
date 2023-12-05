//
//  NewsCollectionViewCell.swift
//  News-Reader-Swift
//
//  Created by Dhanraj Kawade on 05/12/23.
//

import UIKit
import SDWebImage

/// NewsCollectionViewCell
class NewsCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var viwBack: UIView!
    @IBOutlet weak var imgViwNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.viwBack.layer.cornerRadius = 10
        self.imgViwNews.layer.cornerRadius = 10
        self.viwBack.addShadow(offset: CGSize(width: 0, height: 0), color: UIColor.black, radius: 3, opacity: 0.2)
    }
    
    /// Set data
    /// - Parameter article: article
    func setData(article: Article?) {
        self.imgViwNews.sd_setImage(with: URL(string: article?.urlToImage ?? ""), placeholderImage: UIImage(named: "news-placeholder"))
        self.lblTitle.text = article?.title ?? ""
        self.lblDescription.text = article?.description ?? ""
        
        self.lblDate.text = Constants.convertServerDateToCurrentDate(serverDate: article?.publishedAt ?? "")
    }
}
