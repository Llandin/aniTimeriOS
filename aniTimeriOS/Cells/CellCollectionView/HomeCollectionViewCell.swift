//
//  HomeCollectionViewCell.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 14/09/24.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animeCatalogItemImage: UIImageView!
    
    static let identifier: String = String(describing: HomeCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arendodarCell()
    }
    
    func setupCellCollectionView(anime: Anime){
        animeCatalogItemImage.image = UIImage(named: anime.image)
    }
    
    func arendodarCell(){
        animeCatalogItemImage.clipsToBounds = true
        animeCatalogItemImage.layer.cornerRadius = 10
        
    }

}
