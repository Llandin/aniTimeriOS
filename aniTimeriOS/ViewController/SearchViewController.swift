//
//  SearchViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 17/09/24.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var filteredAnimeList: [MockAnimeData] = []

    
    
    @IBAction func searchAnimeTextField(_ sender: UITextField) {
        guard let searchText = sender.text, !searchText.isEmpty else {
                filteredAnimeList = mockAnimeList // Show all if search is empty
                tableView.reloadData()
                return
            }

            filteredAnimeList = mockAnimeList.filter { anime in
                let title = anime.title?.english?.lowercased() ?? ""
                return title.contains(searchText.lowercased())
            }

            tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
        filteredAnimeList = mockAnimeList
        tableView.dataSource = self
        tableView.delegate = self
        SearchTextField.addTarget(self, action: #selector(searchAnimeTextField(_:)), for: .editingChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var searchContainerView: UIView!
    
    
    @objc func viewTapped() {
        let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil) // Adjust the storyboard name
           if let newViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
               navigationController?.pushViewController(newViewController, animated: true)
           }
    }
    
    func setupUI() {
        searchContainerView.layer.borderColor = UIColor(red: 241/255, green: 153/255, blue: 141/255, alpha: 1).cgColor
        searchContainerView.layer.cornerRadius = 24
        searchContainerView.layer.borderWidth = 2
        searchContainerView.backgroundColor = .clear
        
        SearchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnimeList.count
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnime = mockAnimeList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
            
            detailViewController.anime = selectedAnime
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeSearchTableViewCell", for: indexPath) as! AnimeSearchTableViewCell
          let anime = filteredAnimeList[indexPath.row]
          cell.configure(with: anime)
          return cell
      }
}
