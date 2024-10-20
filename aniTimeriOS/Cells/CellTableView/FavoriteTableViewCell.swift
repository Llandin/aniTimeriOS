//
//  FavoriteTableViewCell.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 17/09/24.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var fixedLabel1: UILabel!
    @IBOutlet weak var remainingDaysLabel: UILabel!
    @IBOutlet weak var fixedLabel2: UILabel!
    
    static let identifier = String(describing: FavoriteTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configLabels(label:UILabel,text: String, color: UIColor, aligment: NSTextAlignment,fonte: UIFont? = nil ){
        
        label.text = text;
        label.textColor = color
        label.textAlignment = aligment
        label.font = fonte
    }
    
    public func setupCell(anime: Anime) {
        configLabels(label: fixedLabel1, text: "Faltam", color: .white, aligment: .center,fonte: UIFont(name: "Helvetica Neue", size: 16)! )
        
        configLabels(label: remainingDaysLabel, text: String("\(anime.remainingDays)"),color: .white, aligment: .center, fonte: UIFont(name:"Futura", size: 30.0))
//        
        configLabels(label: fixedLabel2, text: "Dias", color: .white, aligment: .center,fonte: UIFont(name: "Helvetica Neue", size: 16)!)
        
        
        backgroundView = UIImageView(image: UIImage(named: "\(anime.image)")!)
        
        
        
    }
}
