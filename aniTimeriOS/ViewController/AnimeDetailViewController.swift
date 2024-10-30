//
//  AnimeDetailViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 18/09/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol AnimeDetailViewControllerDelegate: AnyObject {
    func didUpdateFavoriteStatus(for anime: Anime)
}

class AnimeDetailViewController: UIViewController {
    
    @IBOutlet weak var animeCover: UIImageView?
    @IBOutlet weak var animeTitle: UILabel?
    @IBOutlet weak var episodeCount: UILabel?
    @IBOutlet weak var animeDescription: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: AnimeDetailViewControllerDelegate?
    var anime: Anime?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        fetchFavoriteStatus()
    }
    
    private func fetchFavoriteStatus() {
        guard let animeId = anime?.id, let userId = Auth.auth().currentUser?.uid else { return }
        let favoriteRef = db.collection("users").document(userId).collection("favorites").document(animeId)
        
        favoriteRef.getDocument { [weak self] document, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching favorite status: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists, let data = document.data(), let isFavorite = data["isFavorite"] as? Bool {
                self.anime?.isFavorite = isFavorite
            } else {
                self.anime?.isFavorite = false
            }
            
            DispatchQueue.main.async {
                self.updateFavoriteButton()
            }
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        toggleFavoriteStatus()
    }
    
    private func toggleFavoriteStatus() {
        guard let animeId = anime?.id, let userId = Auth.auth().currentUser?.uid else { return }
        let favoriteRef = db.collection("users").document(userId).collection("favorites").document(animeId)
        
        if anime?.isFavorite == true {
            // If already favorited, unfavorite by deleting the document
            favoriteRef.delete { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print("Error removing favorite: \(error.localizedDescription)")
                } else {
                    self.anime?.isFavorite = false
                    self.updateFavoriteButton()
                    if let updatedAnime = self.anime {
                        self.delegate?.didUpdateFavoriteStatus(for: updatedAnime)
                    }
                    print("Successfully removed from favorites")
                }
            }
        } else {
            // If not favorited, add to favorites collection
            let favoriteData: [String: Any] = [
                "isFavorite": true,
                "title": anime?.title ?? "",
                "description": anime?.description ?? "",
                "episodes": anime?.episodes ?? 0,
                "genres": anime?.genres ?? [],
                "bannerImage": anime?.bannerImage ?? "",
                "coverImage": anime?.coverImage ?? ""
            ]
            
            favoriteRef.setData(favoriteData) { [weak self] error in
                guard let self = self else { return }
                if let error = error {
                    print("Error updating favorite status: \(error)")
                } else {
                    self.anime?.isFavorite = true
                    self.updateFavoriteButton()
                    if let updatedAnime = self.anime {
                        self.delegate?.didUpdateFavoriteStatus(for: updatedAnime)
                    }
                    print("Successfully added to favorites")
                }
            }
        }
    }
    
    private func updateFavoriteButton() {
        guard let isFavorite = anime?.isFavorite else { return }
        favoriteButton.setTitle(isFavorite ? "Unfavorite" : "Favorite", for: .normal)
        favoriteButton.setTitleColor(isFavorite ? .red : .white, for: .normal)
    }
    
    func configUI() {
        guard let anime = anime else { return }
        animeTitle?.text = anime.title
        episodeCount?.text = "\(anime.episodes ?? 0) episodes"
        animeDescription.text = anime.description
        
        if let imageUrl = anime.coverImage, let url = URL(string: imageUrl) {
            loadImage(from: url) { [weak self] image in
                self?.animeCover?.image = image
            }
        }
        
        updateFavoriteButton()
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
