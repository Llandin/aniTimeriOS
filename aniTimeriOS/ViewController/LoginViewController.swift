//
//  LoginViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 05/09/24.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtonUI()
    }
    @IBOutlet weak var loginButton: UIButton!

    
    func setupView() {
        view.backgroundColor = .red
    }
    
    func setupButtonUI() {
        loginButton.backgroundColor = .blue
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let ctrl = UIStoryboard(name: "HomeView", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeViewController else { return }
        
//        guard let controller = UIStoryboard(name: String(describing: HomeViewController.self), bundle: nil).instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController else { return }
        navigationController?.pushViewController(ctrl, animated: true)
    }
}
