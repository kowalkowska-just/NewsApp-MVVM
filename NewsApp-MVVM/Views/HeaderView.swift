//
//  HeaderView.swift
//  NewsApp-MVVM
//
//  Created by Justyna Kowalkowska on 26/02/2021.
//

import UIKit

class HeaderView: UIView {
    
    private var fontSize: CGFloat
    
    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "News"
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        return label
    }()
    
    private lazy var headerCircleImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        image.image = UIImage(systemName: "largecircle.fill.circle", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return image
    }()
    
    private lazy var plusImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        let config = UIImage.SymbolConfiguration(pointSize: fontSize, weight: .bold)
        image.image = UIImage(systemName: "plus", withConfiguration: config)?.withRenderingMode(.alwaysOriginal)
        return image
    }()
    
    private lazy var subheadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(fontSize)
        label.text = "Top Headlines"
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [headerCircleImage, headingLabel, plusImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        addSubview(headerStackView)
        addSubview(subheadlineLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //news header
        NSLayoutConstraint.activate([
            headerStackView.leftAnchor.constraint(equalTo: leftAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        //subheadline
        NSLayoutConstraint.activate([
            subheadlineLabel.leftAnchor.constraint(equalTo: leftAnchor),
            subheadlineLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 8),
            subheadlineLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
