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
    var sec:[String] = []
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FavoriteView", bundle: nil) // Adjust the storyboard name
        if let newViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteView") as? FavoriteViewController {
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        createSec()
        setBackgroundColor()
        configLabels(label: titleLabel, title: pageTitle, color: UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0))
        configTableView()
        categorizeAnimes()
        remainingDaysTableView.separatorStyle = .none
    }
    
    func getTopThreeFavoriteAnimes(animeList: [MockAnimeData]) -> [MockAnimeData] {
        let favoriteAnimes = animeList.filter { $0.isFavorite }
        if favoriteAnimes.count == 1{
            return Array(favoriteAnimes.prefix(1))
        }else if favoriteAnimes.count == 2{
            return Array(favoriteAnimes.prefix(2))
        }
        return Array(favoriteAnimes.prefix(3))
    }
    
    func getfavoriteQtd(animeList: [MockAnimeData]) -> Int{
        let favoriteAnimes = animeList.filter { $0.isFavorite }
        let quantity: Int = favoriteAnimes.count
        return quantity
    }
    
    private func categorizeAnimes() {
        for category in categories {
                let animesForCategory = mockAnimeList.filter { $0.category == category }
                categorizedAnimes[category] = animesForCategory
            }
    }
    
    func countCategories() -> Int {
        return categorizedAnimes.filter { !$0.value.isEmpty }.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func createSec(){
        sec.append(" ")
        sec.append(" ")
    }
    
    private func setBackgroundColor(){
        view.backgroundColor = background
    }
    
    private func configLabels(label:UILabel,title:String,color:UIColor){
        titleLabel.text = title
        titleLabel.textColor = color
    }
    
    private func checkTopThreeIsEmpty() -> Bool{
        let topThreeFavorites = getTopThreeFavoriteAnimes(animeList: mockAnimeList)
            if topThreeFavorites.isEmpty{
            return true
        }
        return false
    }
    
    private func configTableView() {
        remainingDaysTableView.backgroundColor = background
        remainingDaysTableView.delegate = self
        remainingDaysTableView.dataSource = self
        remainingDaysTableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        remainingDaysTableView.register(HomeTableViewCollectionCell.nib(),forCellReuseIdentifier: HomeTableViewCollectionCell.identifier)
        remainingDaysTableView.clipsToBounds = true
        remainingDaysTableView.register(HomeEmptyTableViewCell.nib(), forCellReuseIdentifier: HomeEmptyTableViewCell.identifier)
       
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
        if checkTopThreeIsEmpty(){
            print("Não fazer nada")
            
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            
            let selectedAnime = mockAnimeList[indexPath.row]
            
            let storyboard = UIStoryboard(name: "AnimeDetailViewController", bundle: nil)
            if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AnimeDetailViewController") as? AnimeDetailViewController {
                
                detailViewController.anime = selectedAnime
                
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if checkTopThreeIsEmpty(){
                return 1
            }else if getfavoriteQtd(animeList: mockAnimeList) == 1{
                return 1
            }else if getfavoriteQtd(animeList: mockAnimeList) == 2{
                return 2
            }
            else if getfavoriteQtd(animeList: mockAnimeList) == 3{
                return 3
                }
    }
        else{
            return countCategories()
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topThreeFavorites = getTopThreeFavoriteAnimes(animeList: mockAnimeList)
        if indexPath.section == 0 {
            if checkTopThreeIsEmpty(){
                let emptyCell = remainingDaysTableView.dequeueReusableCell(withIdentifier: HomeEmptyTableViewCell.identifier, for: indexPath) as? HomeEmptyTableViewCell
                
                emptyCell?.setupCell(mensagem: "Seja bem vindo!\nNesta seção você poderá acessar mais rapidamente seus animes favoritos! Atualmente ainda não possui favoritos.\nQue tal adicionar realizando a busca por animes de sua preferência?")
                
                emptyCell?.selectionStyle = .none
                
                return emptyCell ?? UITableViewCell()
            } else{
                let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
                
                cell?.setupCell(anime:topThreeFavorites[indexPath.row])
                
                cell?.selectionStyle = .none
                
                return cell ?? UITableViewCell()
            }
            
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return topThreeFavorites.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
                cell?.setupCell(anime:mockAnimeList[indexPath.row])
                
                cell?.selectionStyle = .none
                
                return cell ?? UITableViewCell()
            }
            
            func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
                return 120
            }
        
        }else{
            let cell2 = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCollectionCell.identifier, for: indexPath) as? HomeTableViewCollectionCell
                        
            let category = categories[indexPath.row]
            
                   if let animesForCategory = categorizedAnimes[category] {
                       cell2?.setupCellTableView(categoryAnimes: animesForCategory)
                   }
            
            cell2?.selectionStyle = .none
            return cell2 ?? UITableViewCell()
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


