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
        // Initialization code
    }
    
    func configureCell() {
        fixedLabel1.textColor = .white
        remainingDaysLabel.textColor = .white
    }
    
    public func setupCell(anime: MockAnimeData) {
        let backgroundImageView = UIImageView(image: UIImage(named: anime.localBannerImage ?? ""))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundView = backgroundImageView
        
        // Create a dark overlay
        let overlayView = UIView(frame: backgroundImageView.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Adjust the alpha as needed
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add the overlay to the background view
        backgroundView?.addSubview(overlayView)
        
        // Configure labels
        fixedLabel1.text = anime.title?.english
        remainingDaysLabel.text = anime.airing
        fixedLabel2.text = ""
        fixedLabel1.textColor = .white
        remainingDaysLabel.textColor = .white
    }
}
