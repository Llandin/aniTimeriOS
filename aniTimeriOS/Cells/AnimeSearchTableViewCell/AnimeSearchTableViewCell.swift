//
//  AnimeSearchTableViewCell.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 17/10/24.
//

import UIKit
import Kingfisher // Make sure Kingfisher is installed for image loading

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

    func configure(with anime: Anime) {
        titleLabel?.text = anime.title
    }
    
    func setupUI() {
        logoImage?.layer.cornerRadius = 8
        cellContentView.layer.cornerRadius = 16
        cellContentView.backgroundColor = UIColor(red: 241/255, green: 153/255, blue: 141/255, alpha: 1)
    }
}
