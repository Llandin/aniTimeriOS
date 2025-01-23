//
//  AnimeDetailViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 18/09/24.
//

import UIKit

class AnimeDetailViewController: UIViewController {
    
    // create the UI elements using storyboard (inside scroll view)
    
    @IBOutlet weak var titleEnglish: UILabel!
    
    var anime: Anime?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let anime = anime {
               configureData(with: anime)
           }
    }
    
    
    func configureData(with anime: Anime) {
        // pass the anime data to the fields
        titleEnglish.text = anime.title ?? "No Title Available"
    }
    
    
}
