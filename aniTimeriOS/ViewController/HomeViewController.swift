//
//  HomeViewController.swift
//  aniTimeriOS
//
//  Created by Sthashy Vieira on 06/09/24.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet weak var remainingDaysTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let pageTitle: String = "ANITIMER"
    let background: UIColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    
    var animeList: [Anime] = [] // This will store the fetched anime data
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FavoriteView", bundle: nil)
        if let newViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteView") as? FavoriteViewController {
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        configLabels()
        configTableView()
        fetchAnimesFromFirestore() // Fetch anime data from Firestore
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    private func setBackgroundColor() {
        view.backgroundColor = background
    }
    
    private func configLabels() {
        titleLabel.text = pageTitle
        titleLabel.textColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    }
    
    private func configTableView() {
        remainingDaysTableView.backgroundColor = background
        remainingDaysTableView.delegate = self
        remainingDaysTableView.dataSource = self
        remainingDaysTableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        remainingDaysTableView.clipsToBounds = true
    }
    
    private func fetchAnimesFromFirestore() {
        let animeRef = Firestore.firestore().collection("anime")
        
        animeRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching animes: \(error.localizedDescription)")
                return
            }
            
            self.animeList = snapshot?.documents.compactMap { doc in
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
            
            self.remainingDaysTableView.reloadData() // Reload table view with fetched data
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Only one section for the anime list
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the cell after selection
        tableView.deselectRow(at: indexPath, animated: true)

        // Get the selected anime
        let selectedAnime = animeList[indexPath.row]

        // Instantiate the AnimeDetailViewController from the storyboard
        let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
            detailViewController.anime = selectedAnime // Pass the selected anime data to the detail view controller
            navigationController?.pushViewController(detailViewController, animated: true) // Navigate to the detail view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeList.count // Return the number of animes fetched
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        
        let anime = animeList[indexPath.row]
        cell?.setupCell(anime: anime) // Setup cell with anime data
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 // Set a fixed height for the cells
    }
}
