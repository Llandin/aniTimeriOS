//
//  HomeEmptyTableViewCell.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 20/10/24.
//

import UIKit

class HomeEmptyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
    
    static let identifier: String = String(describing: HomeEmptyTableViewCell.self)

    
    static func nib() -> UINib {
         return UINib(nibName: identifier, bundle: nil)
     }
    
    func configLabels(label:UILabel,text: String, color: UIColor, aligment: NSTextAlignment,fonte: UIFont? = nil,numberOfLines: Int ){
    
        label.text = text;
        label.textColor = color
        label.textAlignment = aligment
        label.font = fonte
        label.numberOfLines = numberOfLines
       
    }
    
    public func setupCell(mensagem: String) {
        userMessageLabel.text = mensagem
        
        configLabels(label: userMessageLabel, text: mensagem, color: .white, aligment: .center,fonte: UIFont(name: "Courier", size: 16)!, numberOfLines: 0)
    }

    
}
