//
//  AnimeCollectionView.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 13/01/25.
//

import UIKit

class AnimeCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var animeData: [Anime] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.dataSource = self
        self.delegate = self
        self.register(AnimeCell.self, forCellWithReuseIdentifier: "AnimeCell")
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateAnimeData(_ anime: [Anime]) {
        self.animeData = anime
        self.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animeData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnimeCell", for: indexPath) as! AnimeCell
        let animeItem = animeData[indexPath.row]
        cell.configure(with: animeItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150) // Correct for horizontal scrolling
    }
}
