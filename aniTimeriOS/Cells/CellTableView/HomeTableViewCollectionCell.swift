//
//  HomeTableViewCollectionCell.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 14/09/24.
//

import UIKit

class HomeTableViewCollectionCell: UITableViewCell {
    
    var categorizedAnimes: [AnimeCategory: [MockAnimeData]] = [:]
    let categories = AnimeCategory.allCases
    
    var animes: [MockAnimeData] = []
    
    static let identifier:String = String(describing: HomeTableViewCollectionCell.self)
    
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var catalogCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCatalogCollectionView()
    }
    

    func configCatalogCollectionView(){
        catalogCollectionView.delegate = self
        catalogCollectionView.dataSource = self
        catalogCollectionView.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        if let layout = catalogCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = .zero
            layout.collectionView?.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
            self.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
            
        }
    }
    
    func CATransform3DMakePerspective() -> CATransform3D {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500 // Ajuste para profundidade
        return perspective
    }
    
    func setupCellTableView(categoryNameLabel: String, listImages:[MockAnimeData]){
        self.categoryNameLabel.text = categoryNameLabel
        self.animes = listImages
    }
    
}

extension HomeTableViewCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
        for: indexPath) as? HomeCollectionViewCell
        
        cell?.setupCellCollectionView(animeImage: animes[indexPath.row].image)
        
        return cell ?? UICollectionViewCell()
    }

}
