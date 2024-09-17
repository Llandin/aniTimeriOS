//
//  LoginViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 05/09/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var bemVinDoLabel: UILabel!
    @IBOutlet weak var emailTextFiel: UITextField!
    @IBOutlet weak var senhaTextFiel: UITextField!
    @IBOutlet weak var esqueceuSenhaButton: UIButton!
    @IBOutlet weak var appendAddUser: UIButton!
    @IBOutlet weak var cadastroButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configLabelBemVindo(label: bemVinDoLabel)
        configemailText()
        configsenhaText()
        configesqueceuSenha()
        appendUser()
        configcadastroButton()
    }
    
    
    func setupView() {
         view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    }
    
    func configLabelBemVindo(label : UILabel ){
        
        bemVinDoLabel.text = "Bem-Vindo "
        bemVinDoLabel.textAlignment = .center
        bemVinDoLabel.textColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
        bemVinDoLabel.font = UIFont.boldSystemFont(ofSize: 30)
    
            
    }
    
    func configemailText(){
        
        emailTextFiel.placeholder = "Digite seu email"
        emailTextFiel.layer.cornerRadius = 10
        emailTextFiel.clipsToBounds = true
        
      
    }
    
    func configsenhaText(){
        senhaTextFiel.placeholder = "Digte sua senha "
        senhaTextFiel.layer.cornerRadius = 10
        senhaTextFiel.clipsToBounds = true
        
    }
    
    func configesqueceuSenha(){
        
        esqueceuSenhaButton.setTitle("Esqueceu sua senha?", for: .normal)
        esqueceuSenhaButton.tintColor = .gray
    
        
    }
    
    
    func appendUser(){
        
        appendAddUser.setTitle("Confirmar", for: .normal)
        appendAddUser.clipsToBounds = true
        appendAddUser.layer.cornerRadius = 10
        
    }
    

    func configcadastroButton(){
    
        cadastroButton.setTitle("Não possui conta? Cadastre-se!", for: .normal)
        cadastroButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cadastroButton.tintColor = .gray
       
        
    }

    @IBAction func appendUserButton(_ sender: Any) {
        
        let controller = UIStoryboard(name: "HomeView", bundle: nil).instantiateViewController(withIdentifier: "HomeView") as? HomeViewController
        
        
        navigationController?.pushViewController(controller ?? ViewController(), animated: true)
        
    }
    
    
    @IBAction func appendEsqueceuSenhaButton(_ sender: Any) {
        let controller = UIStoryboard(name: "TelaResetPassword", bundle: nil).instantiateViewController(withIdentifier: "TelaResetPasswordViewController") as? TelaResetPasswordViewController
        
        
        navigationController?.pushViewController(controller ?? ViewController(), animated: true)
        
    }
    
    
    @IBAction func appendCadastroButton(_ sender: Any) {
        
        let cont = UIStoryboard(name: "TelaCadastroViewController", bundle: nil).instantiateViewController(withIdentifier: "TelaCadastroViewController") as? TelaCadastroViewController
        
        navigationController?.pushViewController(cont ?? UIViewController(), animated: true)
    }
    
}
