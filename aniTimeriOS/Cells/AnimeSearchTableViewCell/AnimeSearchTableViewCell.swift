//
//  AnimeSearchTableViewCell.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 17/10/24.
//

import UIKit

class AnimeSearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectionStyle = .none

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10))
    }
    
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var logoImage: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var episodesLabel: UILabel?

    func configure(with anime: MockAnimeData) {
        titleLabel?.text = anime.title?.english ?? "nothing"
        descriptionLabel?.text = anime.genres?.joined(separator: ", ") ?? "nothing"
        episodesLabel?.text = "\(anime.episodes ?? 0) episodes"
        // Configure the image
        if let localImageName = anime.localCoverImage {
               logoImage?.image = UIImage(named: localImageName)
           } else if let imageUrl = anime.coverImage?.medium, let url = URL(string: imageUrl) {
               // If a local image is not available, download from the URL
               // Use a library like Kingfisher to load the image from the URL
               // Example: logoImage?.kf.setImage(with: url)
           } else {
               logoImage?.image = nil // Clear the image if not available
           }
    }
    
    func setupUI() {
        logoImage?.layer.cornerRadius = 8
        cellContentView.layer.cornerRadius = 16
        cellContentView.backgroundColor = UIColor(red: 241/255, green: 153/255, blue: 141/255, alpha: 1)
    }
}
