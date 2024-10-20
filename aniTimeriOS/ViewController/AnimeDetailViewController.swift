//
//  AnimeDetailViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 18/09/24.
//

import UIKit

class AnimeDetailViewController: UIViewController {
        
    
    @IBOutlet weak var animeCover: UIImageView?
    @IBOutlet weak var animeTitle: UILabel?
    @IBOutlet weak var episodeCount: UILabel?
    @IBOutlet weak var animeDescription: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var anime: MockAnimeData?

      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
          configUI()
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.navigationController?.setNavigationBarHidden(false, animated: animated)
          updateFavoriteButton() // Update the button when the view appears
      }
      
      // Action for the favorite button
      @IBAction func favoriteButtonTapped(_ sender: UIButton) {
          guard let anime = anime else { return }
          toggleFavorite(for: anime)
          updateFavoriteButton() // Update the button appearance after toggling
      }
      
      func toggleFavorite(for anime: MockAnimeData) {
          if let index = mockAnimeList.firstIndex(where: { $0.id == anime.id }) {
              mockAnimeList[index].isFavorite.toggle()
          }
      }

      // Method to update the favorite button's text and color
      private func updateFavoriteButton() {
          guard let anime = anime else { return }
             // Check the favorite status of the anime
             let isFavorite = mockAnimeList.first(where: { $0.id == anime.id })?.isFavorite ?? false
             // Update the button's title and color based on the favorite status
             favoriteButton.setTitle(isFavorite ? "Unfavorite" : "Favorite", for: .normal)
          favoriteButton.setTitleColor(isFavorite ? .red : .white, for: .normal)
      }
      
      func configUI() {
          if let anime = anime {
              animeTitle?.text = anime.title?.english
              episodeCount?.text = "\(anime.episodes ?? 0) episodes"
              animeDescription.text = anime.description
              animeCover?.image = UIImage(named: anime.localCoverImage ?? "")
          }
          updateFavoriteButton()
      }
    
}
