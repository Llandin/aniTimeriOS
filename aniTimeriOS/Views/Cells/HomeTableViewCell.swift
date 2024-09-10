//
//  HomeTableViewCell.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 09/09/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: HomeTableViewCell.self)
    
    static func nib() -> UINib {
         return UINib(nibName: identifier, bundle: nil)
     }

    @IBOutlet weak var remainingDayslabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func setupCell(anime: Anime) {
        remainingDayslabel.text = String("Faltam \(anime.remainingDays) dias");
        remainingDayslabel.textColor = .white
        backgroundView = UIImageView(image: UIImage(named: "\(anime.image)")!)
    }

    
}
