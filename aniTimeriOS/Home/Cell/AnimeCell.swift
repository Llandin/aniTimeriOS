//
//  AnimeCell.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 16/01/25.
//

import UIKit

class AnimeCell: UICollectionViewCell {
    
    var viewModel = HomeViewModel()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 240/255, green: 156/255, blue: 248/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.numberOfLines = 2
        
        contentView.backgroundColor = .blue
        contentView.addSubview(coverImage)
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            coverImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            
            titleLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func constructImageURL(from slug: String) -> URL? {
        let baseURL = "https://img.animeschedule.net/production/assets/public/img/"
        let fullURLString = baseURL + slug
        return URL(string: fullURLString)
    }

    
    func configure(with anime: Anime) {
        
        titleLabel.text = anime.title
        
        guard let slug = anime.imageVersionRoute else { return }
        let fullURL = URL(string: "https://img.animeschedule.net/production/assets/public/img/\(slug)")!
        
        viewModel.fetchAnimeCellImage(from: fullURL) { [weak self] image in
            DispatchQueue.main.async {
                self?.coverImage.image = image
            }
        }
    }
}
