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
    func didUpdateFavoriteStatus()
}

class AnimeDetailViewController: UIViewController {
    
    @IBOutlet weak var animeCover: UIImageView?
    @IBOutlet weak var animeTitle: UILabel?
    @IBOutlet weak var episodeCount: UILabel?
    @IBOutlet weak var animeDescription: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var delegate: AnimeDetailViewControllerDelegate?
    var anime: Anime? // Updated to use Firestore model
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        fetchFavoriteStatus() // Ensure we fetch the favorite status when the view appears
    }
    
    // Fetch the favorite status from Firestore and update the button
    private func fetchFavoriteStatus() {
        guard let animeId = anime?.id, let userId = Auth.auth().currentUser?.uid else { return }
        let favoriteRef = db.collection("users").document(userId).collection("favorites").document(animeId)
        
        favoriteRef.getDocument { [weak self] document, error in
            guard let self = self else { return }
            if let document = document, document.exists, let data = document.data(), let isFavorite = data["isFavorite"] as? Bool {
                self.anime?.isFavorite = isFavorite
                self.updateFavoriteButton()
            } else {
                // If it doesn't exist, assume not favorite
                self.anime?.isFavorite = false
                self.updateFavoriteButton()
            }
        }
    }
    
    // Action for the favorite button
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        toggleFavoriteStatus()
    }
    
    // Toggle favorite status for the anime
    private func toggleFavoriteStatus() {
        guard let animeId = anime?.id, let userId = Auth.auth().currentUser?.uid else { return }
        let favoriteRef = db.collection("users").document(userId).collection("favorites").document(animeId)
        
        // Fetch current favorite status from Firestore
        favoriteRef.getDocument { [weak self] document, error in
            guard let self = self else { return }
            if let document = document, document.exists, let data = document.data(), let isFavorite = data["isFavorite"] as? Bool {
                // Toggle the favorite status
                let updatedFavoriteStatus = !isFavorite
                self.updateFavoriteStatusInFirestore(favoriteRef: favoriteRef, anime: self.anime, isFavorite: updatedFavoriteStatus)
            } else {
                // If it doesn't exist, mark as favorite (true) and add new document
                self.updateFavoriteStatusInFirestore(favoriteRef: favoriteRef, anime: self.anime, isFavorite: true)
            }
        }
    }
    
    // Update Firestore with favorite status
    private func updateFavoriteStatusInFirestore(favoriteRef: DocumentReference, anime: Anime?, isFavorite: Bool) {
        guard let anime = anime else { return }
        
        let favoriteData: [String: Any] = [
            "isFavorite": isFavorite,
            "title": anime.title,
            "description": anime.description,
            "episodes": anime.episodes,
            "genres": anime.genres,
            "bannerImage": anime.bannerImage,
            "coverImage": anime.coverImage
        ]

        favoriteRef.setData(favoriteData) { error in
            if let error = error {
                print("Error updating favorite status: \(error)")
            } else {
                self.anime?.isFavorite = isFavorite // Update local model for UI only
                self.updateFavoriteButton() // Update the UI
                self.delegate?.didUpdateFavoriteStatus()
                print("Favorite status updated successfully in Firestore")
            }
        }
    }
    
    // Method to update the favorite button's text and color
    private func updateFavoriteButton() {
        guard let isFavorite = anime?.isFavorite else { return }
        favoriteButton.setTitle(isFavorite ? "Unfavorite" : "Favorite", for: .normal)
        favoriteButton.setTitleColor(isFavorite ? .red : .white, for: .normal)
    }
    
    func configUI() {
        guard let anime = anime else { return }
        animeTitle?.text = anime.title
        episodeCount?.text = "\(anime.episodes) episodes"
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
