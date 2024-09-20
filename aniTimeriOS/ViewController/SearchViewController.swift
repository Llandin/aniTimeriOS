//
//  SearchViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 17/09/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tapGesture()
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    @IBOutlet weak var SearchTextField: UITextField!
    @IBOutlet weak var searchContainerView: UIView!
    
    @IBOutlet weak var animeResultView: UIView!
    
    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        animeResultView.addGestureRecognizer(tapGesture)
        animeResultView.isUserInteractionEnabled = true
    }
    
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
        
        
        animeResultView.layer.cornerRadius = 12
        animeResultView.backgroundColor = UIColor(red: 241/255, green: 153/255, blue: 141/255, alpha: 1)
        
    }
}
