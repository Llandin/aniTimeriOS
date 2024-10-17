//
//  HomeTableViewCollectionCell.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 14/09/24.
//

import UIKit

class HomeTableViewCollectionCell: UITableViewCell {
    
    static let identifier:String = String(describing: HomeTableViewCollectionCell.self)
    
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var animes:[Anime] = []
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var catalogCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        creatingAnimeList()
        configCatalogCollectionView()
    }
    
    func creatingAnimeList(){
        animes.append(Anime(remainingDays: 7, image: "ippocapa.jepeg"))
        animes.append(Anime(remainingDays: 3, image: "dscapa.jpg"))
        animes.append(Anime(remainingDays: 21, image: "boruto.jpg"))
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
    
}

extension HomeTableViewCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        categoryNameLabel.text = "Nome das categorias"
        categoryNameLabel.textColor = .white
        let cell = catalogCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell
        
        
        cell?.setupCellCollectionView(anime:(animes[indexPath.row]))
        
        let perspective = CATransform3DMakePerspective()
            let scaleTransform = CATransform3DScale(perspective, 0.9, 0.9, 1.0)
        
            cell?.layer.transform = scaleTransform
            return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    
}
