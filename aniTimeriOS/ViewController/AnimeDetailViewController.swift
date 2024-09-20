//
//  AnimeDetailViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 18/09/24.
//

import UIKit

class AnimeDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    
    
}
