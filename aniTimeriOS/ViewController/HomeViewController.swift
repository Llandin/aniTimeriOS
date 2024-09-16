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
    
    var animeList: [Anime] = []
    var sec:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSec()
        setBackgroundColor()
        configLabels(label: titleLabel)
        configTableView()
    }
    
    private func createAnimelist(){
        animeList.append(Anime(remainingDays: 7, image: "images.png"))
        animeList.append(Anime(remainingDays: 6, image: "images2.png"))
        animeList.append(Anime(remainingDays: 29, image: "images3.png"))
    }
    
    private func createSec(){
        sec.append("    ")
        sec.append("    ")
    }
    
    private func setBackgroundColor(){
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    }
    
    private func configLabels(label: UILabel){
        titleLabel.text = "ANITIMER"
        titleLabel.textColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    }
    
    private func configTableView() {
        remainingDaysTableView.delegate = self
        remainingDaysTableView.dataSource = self
        remainingDaysTableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
        createAnimelist()
        remainingDaysTableView.register(HomeTableViewCollectionCell.nib(),forCellReuseIdentifier: HomeTableViewCollectionCell.identifier)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
            cell?.setupCell(anime:animeList[indexPath.row])
            return cell ?? UITableViewCell()
            
        }else{
            let cell2 = remainingDaysTableView.dequeueReusableCell(withIdentifier:HomeTableViewCollectionCell.identifier, for: indexPath) as? HomeTableViewCollectionCell
            return cell2 ?? UITableViewCell()
            }
    }
    
    func tableView(_ tableview: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}

