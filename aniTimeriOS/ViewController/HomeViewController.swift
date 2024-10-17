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
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FavoriteView", bundle: nil) // Adjust the storyboard name
        if let newViewController = storyboard.instantiateViewController(withIdentifier: "FavoriteView") as? FavoriteViewController {
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    
    var animeList: [Anime] = []
    var sec:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        createSec()
        setBackgroundColor()
        configLabels(label: titleLabel, title: pageTitle, color: UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0))
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    private func createAnimelist(){
        animeList.append(Anime(remainingDays: 7, image: "anime1.jpg"))
        animeList.append(Anime(remainingDays: 6, image: "anime2.jpg"))
        animeList.append(Anime(remainingDays: 29, image: "anime3.png"))
    }
    
    private func createSec(){
        sec.append("    ")
        sec.append("    ")
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
        createAnimelist()
        remainingDaysTableView.register(HomeTableViewCollectionCell.nib(),forCellReuseIdentifier: HomeTableViewCollectionCell.identifier)
        remainingDaysTableView.clipsToBounds = true
        
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        sec.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        tableView.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
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
        return animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
            cell?.setupCell(anime:animeList[indexPath.row])
            
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return animeList.count
            }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
                cell?.setupCell(anime:animeList[indexPath.row])
                
                
                return cell ?? UITableViewCell()
            }
            
            func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
                return 120
            }
            
            cell?.selectionStyle = .none
            
            return cell ?? UITableViewCell()
            
        }else{
            let cell2 = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCollectionCell.identifier, for: indexPath) as? HomeTableViewCollectionCell
            return cell2 ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


