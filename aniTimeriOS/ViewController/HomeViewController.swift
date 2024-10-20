//
//  HomeViewController.swift
//  aniTimeriOS
//
//  Created by Sthashy Vieira on 06/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var remainingDaysTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    let pageTitle:String = "ANITIMER"
    let background:UIColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    let categories = AnimeCategory.allCases
    var categorizedAnimes: [AnimeCategory: [MockAnimeData]] = [:]
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FavoriteView", bundle: nil) // Adjust the storyboard name
        if let newViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteView") as? FavoriteViewController {
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    
    var listAllanimesmock: [MockAnimeData] = mockAnimeList
    var sec:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        createSec()
        setBackgroundColor()
        configLabels(label: titleLabel, title: pageTitle, color: UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0))
        configTableView()
       
    }
    
    func getTopThreeFavoriteAnimes(animeList: [MockAnimeData]) -> [MockAnimeData] {
        let favoriteAnimes = animeList.filter { $0.isFavorite }
        return Array(favoriteAnimes.prefix(3))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func createSec(){
        sec.append("Favoritos")
        sec.append("Catalogo")
    }
    
    private func setBackgroundColor(){
        view.backgroundColor = background
    }
    
    private func configLabels(label:UILabel,title:String,color:UIColor){
        titleLabel.text = title
        titleLabel.textColor = color
    }
    
    private func configTableView() {
        remainingDaysTableView.backgroundColor = background
        remainingDaysTableView.delegate = self
        remainingDaysTableView.dataSource = self
        remainingDaysTableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        remainingDaysTableView.register(HomeTableViewCollectionCell.nib(),forCellReuseIdentifier: HomeTableViewCollectionCell.identifier)
        remainingDaysTableView.clipsToBounds = true
       
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        sec.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sec[section]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        else{
            return categories.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topThreeFavorites = getTopThreeFavoriteAnimes(animeList: mockAnimeList)
        if indexPath.section == 0 {
            let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
            
            cell?.setupCell(anime:topThreeFavorites[indexPath.row])
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return topThreeFavorites.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
                cell?.setupCell(anime:mockAnimeList[indexPath.row])
                
                
                return cell ?? UITableViewCell()
            }
            
            func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
                return 120
            }
            
            cell?.selectionStyle = .none
            
            return cell ?? UITableViewCell()
        }else{
            let cell2 = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCollectionCell.identifier, for: indexPath) as? HomeTableViewCollectionCell
            cell2?.setupCellTableView(categoryNameLabel: "Category", listImages: listAllanimesmock)
            
            return cell2 ?? UITableViewCell()
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


