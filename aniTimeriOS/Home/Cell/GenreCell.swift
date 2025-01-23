//
//  GenreCell.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 16/01/25.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    lazy var animeCollectionView: AnimeCollectionView = {
        let collectionView = AnimeCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(animeCollectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            animeCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            animeCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            animeCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            animeCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with animeData: [Anime], delegate: AnimeCollectionViewDelegate) {
        animeCollectionView.updateAnimeData(animeData)
        animeCollectionView.selectionDelegate = delegate
    }
}
