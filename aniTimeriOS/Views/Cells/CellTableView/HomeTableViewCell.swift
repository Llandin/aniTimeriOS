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

    @IBOutlet weak var fixedLabel: UILabel!
    @IBOutlet weak var remainingDayslabel: UILabel!
    @IBOutlet weak var fixedlabel2: UILabel!
    
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
        configLabels(label: fixedLabel, text: "Faltam", color: .white, aligment: .center,fonte: UIFont(name: "Helvetica Neue", size: 16)! )
        
        configLabels(label: fixedlabel2, text: "Dias", color: .white, aligment: .center,fonte: UIFont(name: "Helvetica Neue", size: 16)!)
        
        configLabels(label: remainingDayslabel, text: String("\(anime.remainingDays)"),color: .white, aligment: .center, fonte: UIFont(name:"Futura", size: 30.0))
        
    
        backgroundView = UIImageView(image: UIImage(named: "\(anime.image)")!)
        
    }

    
}
