//
//  ViewController.swift
//  NewsApp
//
//  Created by Ahmed Abaza on 24/11/2021.
//

import UIKit

fileprivate let cellId: String = "aricleCell"

class ViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.test()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureView() -> Void {
        //view configuration
        self.view.backgroundColor = .black
        
        
        //adding subviews
        self.view.addSubview(tableView)
        
        //positioning subviews
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        
    }
    
    private func test() -> Void {
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



extension ViewController: UITableViewDataSource {
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


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 370.0
    }
}
