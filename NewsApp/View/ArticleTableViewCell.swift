//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 25/11/2021.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    
    public var article: Article! {
        didSet {
            self.label.text = article.title
            self.setImage(from: article.urlToImage)
        }
    }

    //MARK: -UIElements
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 22.0, weight: .heavy)
        lbl.text = "Loading...."
        
        return lbl
    }()
    
    private let articleImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemBlue
        iv.clipsToBounds = true
        
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCell() -> Void {
        
        
        self.contentView.addSubview(articleImageView)
        self.contentView.addSubview(label)
        
        
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        articleImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        articleImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
//        articleImageView.bottomAnchor.constraint(equalTo: self.label.topAnchor).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.articleImageView.bottomAnchor, constant: 8.0).isActive = true
        label.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16.0).isActive = true
        label.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16.0).isActive = true
    }
    
    
    private func setImage(from urlString: String) -> Void {
        guard let url = URL(string: urlString) else { return }
        articleImageView.sd_setImage(with: url) { [weak self](image, error, _, _) in
            guard let image = image, error == nil else { return }
            self?.articleImageView.image = image
        }
    }
}
