//
//  ViewController.swift
//  NewsApp-MVVM
//
//  Created by Justyna Kowalkowska on 25/02/2021.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    var viewModel = NewsListViewModel()
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView(fontSize: 32)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: viewModel.reuseID)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
        fetchNews()
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        //heardeView
        NSLayoutConstraint.activate([
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        //tableView
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchNews() {
        viewModel.getNews { (_) in
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseID, for: indexPath) as? NewsTableViewCell
        let news = viewModel.newsVM[indexPath.row]
        cell?.newsVM = news
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.newsVM[indexPath.row]
        guard let url = URL(string: news.url) else { return }
        
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .formSheet
        present(safariViewController, animated: true)
    }
    
    
}

