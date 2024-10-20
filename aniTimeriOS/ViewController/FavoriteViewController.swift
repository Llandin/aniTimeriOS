//
//  FavoriteViewController.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 17/09/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var titleScreenLabel: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView!
    //    var animeFavoriteList: [Anime] = []
    var animeFavoriteList: [MockAnimeData] = []
    let backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    
    let pinkColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        configLabels(label: titleScreenLabel, text: "FAVORITOS", color: pinkColor, fonte: UIFont(name: "Sinhala Sangam MN", size: 30)!)
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        loadFavoriteAnimes() // Load the favorited animes every time the view appears
        favoritesTableView.reloadData()
    }
    
    
    private func configTableView() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.backgroundColor = backgroundColor
        favoritesTableView.register(FavoriteTableViewCell.nib(), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        favoritesTableView.register(FavoriteTableViewCell.nib(),forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    }
    
    private func setBackgroundColor(){
        view.backgroundColor = backgroundColor
    }
    
    private func loadFavoriteAnimes() {
        animeFavoriteList = mockAnimeList.filter { $0.isFavorite }
    }
    
    
    func configLabels(label:UILabel,text:String,color:UIColor? = nil,fonte:UIFont? =  nil){
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
        let selectedAnime = mockAnimeList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
            
            detailViewController.anime = selectedAnime
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            let animeToRemove = self.animeFavoriteList[indexPath.row]
            if let indexInMainList = mockAnimeList.firstIndex(where: { $0.id == animeToRemove.id }) {
                mockAnimeList[indexInMainList].isFavorite = false
            }
            
            self.animeFavoriteList.remove(at: indexPath.row)
            self.favoritesTableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = pinkColor
        let swipeAction = UISwipeActionsConfiguration(actions: [deleteAction])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
}
