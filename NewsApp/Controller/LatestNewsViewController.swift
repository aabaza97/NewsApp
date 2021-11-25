//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 24/11/2021.
//

import UIKit
import SafariServices


fileprivate let cellId: String = "aricleCell"

class LatestNewsViewController: UIViewController {
    
    //MARK: -Properties
    private var articles: [Article] = []
    
    
    
    //MARK: -UI Elements
    private lazy var tableView: UITableView = {
        let tbl = UITableView()
        
        tbl.dataSource = self
        tbl.delegate = self
        tbl.register(ArticleTableViewCell.self, forCellReuseIdentifier: cellId)
        tbl.backgroundColor = .clear
        tbl.separatorColor = .black
        tbl.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return tbl
    }()

    
    //MARK: -Overrides & LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fetchNews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: -Fucntions
    private func configureView() -> Void {
        //view configuration
        self.title = "Latest News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .white
        
        
        //adding subviews
        self.view.addSubview(tableView)
        
        //positioning subviews
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    private func fetchNews() -> Void {
        DataLoader.shared.makeRequest() { [weak self] (_, articles, error) in
            guard let articles = articles, articles.count != 0, error == nil else {
                print("Data Loader Error: \(error!)")
                return
            }
            
            guard let self = self else { return }
            
            self.articles = articles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}


//MARK: - EXT(TableView DataSource)
extension LatestNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        cell.article = articles[indexPath.row]
        
        return cell
    }
}


//MARK: - EXT(TableView Delegate)
extension LatestNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 420.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: self.articles[indexPath.row].url) else { return }
        self.openInSafari(using: url)
    }
    
    
    private func openInSafari(using url: URL) -> Void {
        let config = SFSafariViewController.Configuration.init()
        config.entersReaderIfAvailable = true
        config.barCollapsingEnabled = true
        
        let safariReader = SFSafariViewController(url: url, configuration: config)
        
        self.present(safariReader, animated: true, completion: nil)
        self.modalPresentationStyle = .fullScreen
    }
}
