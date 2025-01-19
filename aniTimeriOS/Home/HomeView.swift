//
//  HomeView.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 12/01/25.
//

import UIKit

class HomeView: UIView {
    
    private let scrollView: UIScrollView = {
           let scrollView = UIScrollView()
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           scrollView.showsVerticalScrollIndicator = false
           return scrollView
       }()

       // Content view inside the scroll view
       private let contentView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()

       // Banner image
       private let bannerImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.image = UIImage(named: "dscapa") // Replace with your image name
           return imageView
       }()

       // Text on top of the banner
       private let bannerTextLabel: UILabel = {
           let label = UILabel()
           label.text = "Welcome to AniTimer"
           label.textColor = .white
           label.font = UIFont.boldSystemFont(ofSize: 24)
           label.textAlignment = .center
           label.numberOfLines = 0
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: "GenreCell")
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
            addSubview(scrollView)
            scrollView.addSubview(contentView)
            
            contentView.addSubview(bannerImageView)
            bannerImageView.addSubview(bannerTextLabel)
            contentView.addSubview(collectionView)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
          // Scroll view constraints
          NSLayoutConstraint.activate([
              scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
              scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
              scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
              scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
          ])

          // Content view constraints
          NSLayoutConstraint.activate([
              contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
              contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
              contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
              contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
              contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Ensures proper horizontal scrolling is disabled
          ])

          // Banner image constraints
          NSLayoutConstraint.activate([
              bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
              bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              bannerImageView.heightAnchor.constraint(equalToConstant: 200) // Adjust height as needed
          ])

          // Banner text constraints
          NSLayoutConstraint.activate([
              bannerTextLabel.centerXAnchor.constraint(equalTo: bannerImageView.centerXAnchor),
              bannerTextLabel.centerYAnchor.constraint(equalTo: bannerImageView.centerYAnchor),
              bannerTextLabel.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor, constant: 16),
              bannerTextLabel.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: -16)
          ])

          // Collection view constraints
          NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
                        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        collectionView.heightAnchor.constraint(equalToConstant: 600), // Adjust this based on content
                        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
          ])
      }
    
    // Create compositional layout
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(300)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension HomeView: UICollectionViewDelegate {
    // Implement delegate methods as needed
}
