//
//  MovieTableViewCell.swift
//  MovieBrowser
//
//  Created by Kevin Varghese on 12/1/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 28.0)
        return label
    }()
    
    var releaseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .ultraLight)
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    // class property to reduce memory allocation on dateformatter object as cells are recycled
    let dateFormatter = DateFormatter()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        let hStackView = UIStackView(frame: .zero)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.axis = .horizontal
        
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 20
        
        vStackView.addArrangedSubview(self.titleLabel)
        vStackView.addArrangedSubview(self.releaseLabel)
        
        hStackView.addArrangedSubview(vStackView)
        hStackView.addArrangedSubview(self.ratingLabel)
        
        self.contentView.addSubview(hStackView)
        
        hStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        
        self.ratingLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configure(movie: Movie) {
        self.titleLabel.text = movie.title
        self.releaseLabel.text = self.dateFormatter.movieCellDateFormat(from: movie.releaseDate ?? "")
        self.ratingLabel.text = "\(movie.rating)"
    }
    
}
