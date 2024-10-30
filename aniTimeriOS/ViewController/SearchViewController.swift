//
//  SearchViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 17/09/24.
//

import UIKit
import FirebaseFirestore

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchContainerView: UIView!
    
    private let db = Firestore.firestore()
    var filteredAnimeList: [Anime] = [] // Updated to use the Anime model from Firestore
    var allAnimeList: [Anime] = []      // List of all animes fetched from Firestore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        
        searchTextField.addTarget(self, action: #selector(searchAnimeTextField(_:)), for: .editingChanged)
        
        loadAnimeData() // Fetch initial data from Firestore
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // Firestore Fetch Function
    private func loadAnimeData() {
        db.collection("anime") // Replace with your actual collection name
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching animes: \(error)")
                } else if let snapshot = snapshot {
                    self.allAnimeList = snapshot.documents.compactMap { document in
                        try? document.data(as: Anime.self) // Decoding into Anime model
                    }
                    self.filteredAnimeList = self.allAnimeList
                    self.tableView.reloadData()
                }
            }
    }
    
    // Search Function for Filtering
    @objc func searchAnimeTextField(_ sender: UITextField) {
        guard let searchText = sender.text, !searchText.isEmpty else {
            filteredAnimeList = allAnimeList
            tableView.reloadData()
            return
        }
        
        filteredAnimeList = allAnimeList.filter { anime in
            if let title = anime.title?.lowercased() {
                return title.contains(searchText.lowercased())
            }
            return false
        }
        
        tableView.reloadData()
    }
    
    // UI Setup Function
    func setupUI() {
        searchContainerView.layer.borderColor = UIColor(red: 241/255, green: 153/255, blue: 141/255, alpha: 1).cgColor
        searchContainerView.layer.cornerRadius = 24
        searchContainerView.layer.borderWidth = 2
        searchContainerView.backgroundColor = .clear
        
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    
    // MARK: - Table View Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnimeList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeSearchTableViewCell", for: indexPath) as! AnimeSearchTableViewCell
        let anime = filteredAnimeList[indexPath.row]
        cell.configure(with: anime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnime = filteredAnimeList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
            detailViewController.anime = selectedAnime
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
