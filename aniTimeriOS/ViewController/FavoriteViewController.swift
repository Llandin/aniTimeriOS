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
    var animeFavoriteList: [Anime] = []
    
    let backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    
    let pinkColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        configLabels(label:titleScreenLabel, text: "FAVORITOS", color: pinkColor,fonte: UIFont(name: "Sinhala Sangam MN", size: 30)!)
        configTableView()
        
    }
    
    private func configTableView() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.register(FavoriteTableViewCell.nib(), forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        createFavoritelist()
        favoritesTableView.register(FavoriteTableViewCell.nib(),forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    }
    
    private func setBackgroundColor(){
        view.backgroundColor = backgroundColor
    }
    
    
    func configLabels(label:UILabel,text:String,color:UIColor? = nil,fonte:UIFont? =  nil){
        label.text = text
        label.textColor = color
        label.font = fonte
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    private func createFavoritelist(){
        animeFavoriteList.append(Anime(remainingDays: 7, image: "images.png"))
        animeFavoriteList.append(Anime(remainingDays: 6, image: "images2.png"))
        animeFavoriteList.append(Anime(remainingDays: 29, image: "images3.png"))
        animeFavoriteList.append(Anime(remainingDays: 7, image: "images.png"))
        animeFavoriteList.append(Anime(remainingDays: 6, image: "images2.png"))
        animeFavoriteList.append(Anime(remainingDays: 29, image: "images3.png"))
        animeFavoriteList.append(Anime(remainingDays: 7, image: "images.png"))
        animeFavoriteList.append(Anime(remainingDays: 6, image: "images2.png"))
        animeFavoriteList.append(Anime(remainingDays: 29, image: "images3.png"))
    }
    
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animeFavoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier:FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell
        cell?.setupCell(anime:animeFavoriteList[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title:"Excluir") {_, _, completionHandler in
            
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
