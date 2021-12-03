//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    static func createViewController() -> MovieDetailViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(MovieDetailViewController.self)") as? MovieDetailViewController
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie?
    var networkManager: NetworkManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.update()
    }
    
    func configure(movie: Movie, networkManager: NetworkManager) {
        self.movie = movie
        self.networkManager = networkManager
    }
    
    private func update() {
        self.titleLabel.text = self.movie?.title
        self.releaseLabel.text = "Release Date: \(DateFormatter().movieDetailDateFormat(from: self.movie?.releaseDate ?? "") ?? "N/A")"
        self.descriptionLabel.text = self.movie?.overview
        
        guard let imagePath = self.movie?.posterImage else { return }
        
        if let imageData = ImageCache.shared.getData(with: imagePath) {
            self.posterImageView.image = UIImage(data: imageData)
        } else {
            self.networkManager?.getData(url: NetworkParams.imageRequest(imagePath).url, completion: { [weak self] result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        self?.posterImageView.image = UIImage(data: imageData)
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    
}
