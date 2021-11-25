//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 25/11/2021.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    
    //MARK: -Properties
    public var article: Article! {
        didSet {
            self.setData()
        }
    }
    
    

    //MARK: -UIElements
    private let titleLabel: UILabel = {
        return UIBuilder.makeLabel(numberOfLines: 2, pointSize: 22.0, fontWeight: .heavy)
    }()
    
    private let subtitleLabel: UILabel = {
        return UIBuilder.makeLabel(numberOfLines: 2, pointSize: 17.0, fontWeight: .regular)
    }()
    
    private let sourceAuthorLabel: UILabel = {
        return UIBuilder.makeItalicLabel(numberOfLines: 3, pointSize: 15.0)
    }()
    
    
    private let articleImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemBlue
        iv.clipsToBounds = true
        
        return iv
    }()
    
    
    
    //MARK: -Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: -Functions
    private func configureCell() -> Void {
        //adding subviews
        self.contentView.addSubview(articleImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subtitleLabel)
        self.contentView.addSubview(sourceAuthorLabel)
        
        
        //positioning subviews
        //image
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        articleImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        articleImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        //title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.articleImageView.bottomAnchor, constant: 8.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20.0).isActive = true
        
        //subtitle
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5.0).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20.0).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20.0).isActive = true
        
        //source + author + date
        sourceAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceAuthorLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 32.0).isActive = true
        sourceAuthorLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -20.0).isActive = true
        sourceAuthorLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 20.0).isActive = true
    }
    
    private func setData() -> Void {
        let publishDate: String = formatDate(from: article.publishedAt)
        
        self.titleLabel.text = article.title
        self.setImage(from: article.urlToImage)
        self.subtitleLabel.text = article.description
        
        guard let author = article.author else {
            self.sourceAuthorLabel.text = "\(article.source.name),\n\(publishDate)"
            return
        }
        self.sourceAuthorLabel.text = "\(article.source.name),\n\(publishDate),\n– \(author)"
    }
    
    private func formatDate(from originalDate: String) -> String {
        var formattedDate: String = ""
        
        //let's do the formatting...
        //1. translate the string to date using ios8601 format
        //2. reformat the date to new format
        //3. return it
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = formatter.date(from: originalDate) else {return ""}
        
        formatter.dateFormat = "MM/DD/YYYY"
        
        formattedDate = formatter.string(from: date)
        
        return formattedDate
    }
    
    private func setImage(from urlString: String) -> Void {
        guard let url = URL(string: urlString) else { return }
        articleImageView.sd_setImage(with: url) { [weak self](image, error, _, _) in
            guard let image = image, error == nil else { return }
            self?.articleImageView.image = image
        }
    }
    
}
