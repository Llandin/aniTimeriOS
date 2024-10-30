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
    @IBOutlet weak var remainingDaysLabel: UILabel!
    @IBOutlet weak var fixedLabel2: UILabel!
    @IBOutlet var imageImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        layer.cornerRadius = 30
        backgroundColor = .clear
    }
    
    func configLabels(label: UILabel, text: String, color: UIColor, alignment: NSTextAlignment, font: UIFont? = nil) {
        label.text = text
        label.textColor = color
        label.textAlignment = alignment
        label.font = font
    }
    
    public func setupCell(anime: Anime) {
        
        let remainingDays = anime.remainingDays ?? 0
        
        configLabels(label: fixedLabel, text: "Faltam", color: .white, alignment: .center, font: UIFont(name: "Helvetica Neue", size: 16)!)
        configLabels(label: fixedLabel2, text: "Dias", color: .white, alignment: .center, font: UIFont(name: "Helvetica Neue", size: 16)!)
        configLabels(label: remainingDaysLabel, text: "\(remainingDays)", color: .white, alignment: .center, font: UIFont(name: "Futura", size: 30.0))
        
        // Directly use bannerImage since it's non-optional
        let url = URL(string: anime.bannerImage ?? "")
        if let url = url {
            loadImage(from: url)
        } else {
            imageImg.image = nil // Clear image if URL is invalid
        }
        imageImg.contentMode = .scaleAspectFill
        imageImg.alpha = 0.5
    }

    
    private func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageImg.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.imageImg.image = nil // Set to nil if image fails to load
                }
            }
        }
    }
}
