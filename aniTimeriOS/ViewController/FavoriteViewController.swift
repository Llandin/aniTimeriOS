//
//  FavoriteViewController.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 17/09/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var titleScreenLabel: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    var animeFavoriteList: [Anime] = []  // Updated to use the Anime model
    let backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    let pinkColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.reloadData()
        setBackgroundColor()
        configLabels(label: titleScreenLabel, text: "FAVORITOS", color: pinkColor, fonte: UIFont(name: "Sinhala Sangam MN", size: 30)!)
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        loadFavoriteAnimes()
    }
    
    private func configTableView() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.backgroundColor = backgroundColor
        favoritesTableView.register(FavoriteTableViewCell.nib(), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = backgroundColor
    }
    
    private func loadFavoriteAnimes() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let favoritesRef = Firestore.firestore().collection("users").document(userId).collection("favorites")
        
        favoritesRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching favorite anime: \(error.localizedDescription)")
                return
            }
            
            self.animeFavoriteList = snapshot?.documents.compactMap { doc in
                let data = doc.data()
                return Anime(
                    id: doc.documentID,
                    title: data["title"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    episodes: data["episodes"] as? Int ?? 0,
                    genres: data["genres"] as? [String] ?? [],
                    bannerImage: data["bannerImage"] as? String ?? "",
                    coverImage: data["coverImage"] as? String ?? "",
                    isFavorite: data["isFavorite"] as? Bool ?? false,
                    remainingDays: data["remainingDays"] as? Int ?? 0
                )
            } ?? []
            
            DispatchQueue.main.async {
                self.favoritesTableView.reloadData()
            }
        }
    }
    
    func configLabels(label: UILabel, text: String, color: UIColor? = nil, fonte: UIFont? = nil) {
        label.text = text
        label.textColor = color
        label.font = fonte
        label.numberOfLines = 0
        label.textAlignment = .center
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeFavoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell
        cell?.setupCell(anime: animeFavoriteList[indexPath.row])
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnime = animeFavoriteList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
            detailViewController.anime = selectedAnime
            detailViewController.delegate = self
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            let animeToRemove = self.animeFavoriteList[indexPath.row]
            
            guard let userId = Auth.auth().currentUser?.uid else { return }
            let favoritesRef = Firestore.firestore().collection("users").document(userId).collection("favorites")
            
            favoritesRef.document(animeToRemove.id ?? "").delete { error in
                if let error = error {
                    print("Error removing favorite anime: \(error.localizedDescription)")
                } else {
                    self.animeFavoriteList.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        self.favoritesTableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                    completionHandler(true)
                }
            }
        }
        
        deleteAction.backgroundColor = pinkColor
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
}

extension FavoriteViewController: AnimeDetailViewControllerDelegate {
    func didUpdateFavoriteStatus(for anime: Anime) {
        if let index = animeFavoriteList.firstIndex(where: { $0.id == anime.id }) {
            animeFavoriteList.remove(at: index)
            
            // Remove the row in the table view
            favoritesTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
}
