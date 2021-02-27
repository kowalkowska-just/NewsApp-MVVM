//
//  NewsTableViewCell.swift
//  NewsApp-MVVM
//
//  Created by Justyna Kowalkowska on 26/02/2021.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    var newsVM: NewsViewModel? {
        didSet {
            if let newsVM = newsVM {
                titleLabel.text = newsVM.title
                NetworkManager.shared.getImage(urlString: newsVM.urlToImage) { (data) in
                    guard let data = data else { return }
                    DispatchQueue.main.async {
                        self.newsImage.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    var newsImageData: Data? {
        didSet {
            if let data = newsImageData {
                newsImage.image = UIImage(data: data)
            }
        }
    }
    
    private lazy var newsImage: ShadowImageView = {
        let image = ShadowImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helper Function
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(newsImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        //newsImage
        NSLayoutConstraint.activate([
            newsImage.leftAnchor.constraint(equalTo: leftAnchor),
            newsImage.rightAnchor.constraint(equalTo: rightAnchor),
            newsImage.topAnchor.constraint(equalTo: topAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        //titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
