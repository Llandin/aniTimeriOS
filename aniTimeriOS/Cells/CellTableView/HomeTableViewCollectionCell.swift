//
//  HomeTableViewCollectionCell.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 14/09/24.
//

import UIKit

class HomeTableViewCollectionCell: UITableViewCell {

  //  let categories = AnimeCategory.allCases
    
    var animes: [MockAnimeData] = []
    
    static let identifier:String = String(describing: HomeTableViewCollectionCell.self)
    let pinkColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    
    
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
    
    func configLabel(label:UILabel,font:UIFont, color:UIColor){
        label.font = font
        label.textColor = color
    }
    
    func CATransform3DMakePerspective() -> CATransform3D {
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0 / 500 // Ajuste para profundidade
        return perspective
    }
    
    func setupCellTableView(categoryAnimes: [MockAnimeData]) {
        self.animes = categoryAnimes
        catalogCollectionView.reloadData()
    }
    
}

extension HomeTableViewCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier,
        for: indexPath) as? HomeCollectionViewCell
        
        configLabel(label: categoryNameLabel, font:UIFont(name: "Courier New", size:18)!,color:pinkColor)
        
        categoryNameLabel.text = animes[indexPath.row].category.rawValue
        
        
        
        cell?.setupCellCollectionView(animeImage: animes[indexPath.item].image)
        
        let perspective = CATransform3DMakePerspective()
        let scaleTransform = CATransform3DScale(perspective, 0.9, 0.9, 1.0)
        cell?.layer.transform = scaleTransform


        return cell ?? UICollectionViewCell()
    }

}
