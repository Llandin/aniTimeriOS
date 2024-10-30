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
        configureCell() // Configure cell appearance when the nib is loaded
    }
    
    func configureCell() {
        fixedLabel1.textColor = .white
        remainingDaysLabel.textColor = .white
    }
    
    public func setupCell(anime: Anime) {
        // Use the cover image URL to set the background image
        guard let imageUrl = anime.bannerImage else { return } // Assuming this is a non-optional String
        if let url = URL(string: imageUrl) {
            loadImage(from: url) { [weak self] image in
                guard let self = self else { return }
                let backgroundImageView = UIImageView(image: image)
                backgroundImageView.contentMode = .scaleAspectFill
                backgroundImageView.clipsToBounds = true
                self.backgroundView = backgroundImageView
                
                // Create a dark overlay
                let overlayView = UIView(frame: backgroundImageView.bounds)
                overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5) // Adjust the alpha as needed
                overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                
                // Add the overlay to the background view
                self.backgroundView?.addSubview(overlayView)
            }
        }

        // Configure labels with anime data
        fixedLabel1.text = anime.title
        remainingDaysLabel.text = anime.remainingDays ?? 0 > 0 ? "\(anime.remainingDays) days left" : "Airing ended"
        fixedLabel2.text = ""
    }
    
    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
