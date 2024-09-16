//
//  TelaCadastroViewController.swift
//  aniTimeriOS
//
//  Created by Sthashy Vieira on 12/09/24.
//

import UIKit

class TelaCadastroViewController: UIViewController {

    
    @IBOutlet weak var registroLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextFiel: UITextField!
    @IBOutlet weak var senhaTextFiel: UITextField!
    @IBOutlet weak var configSenhaTextFiel: UITextField!
    @IBOutlet weak var tenhoContaLabel: UILabel!
   
    @IBOutlet weak var appendCadastrarButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      setupTelaCadastro()
      configRegistro(regist: registroLabel)
        configSetTextFiel(name: nameTextField, email: emailTextFiel, senha: senhaTextFiel, confimarSenha: configSenhaTextFiel)
        tenhoConta(conta: tenhoContaLabel)
        configButton()
        configSenha(isSecure: true, confirmarSenha: true	)
     
        
    }
    
    func setupTelaCadastro(){
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    }
    
   
    func configRegistro(regist:UILabel){
        
        registroLabel.text = "Registro"
        registroLabel.textAlignment = .center
        registroLabel.textColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
        registroLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
    }
    


    func configSetTextFiel(name : UITextField, email : UITextField, senha : UITextField , confimarSenha : UITextField){
        
        nameTextField.placeholder = "Digite seu nome "
        nameTextField.layer.cornerRadius = 10
        nameTextField.clipsToBounds = true
        
        emailTextFiel.placeholder = "Digete seu email"
        emailTextFiel.clipsToBounds = true
        emailTextFiel.layer.cornerRadius = 10
        
        senhaTextFiel.placeholder = "Digite sua senha"
        senhaTextFiel.clipsToBounds = true
        senhaTextFiel.layer.cornerRadius = 10
        
        configSenhaTextFiel.placeholder = "Confirme sua senha"
        configSenhaTextFiel.clipsToBounds = true
        configSenhaTextFiel.layer.cornerRadius = 10
        
    }
    
    func configSenha(isSecure : Bool, confirmarSenha : Bool){
        
        senhaTextFiel.isSecureTextEntry = isSecure
        configSenhaTextFiel.isSecureTextEntry = confirmarSenha
    }
    
    func tenhoConta(conta : UILabel){
        
        tenhoContaLabel.text = "Já possui conta? Login"
        tenhoContaLabel.textColor = .gray
        
    }
    
    
    func configButton(){
        
        appendCadastrarButton.setTitle("Cadastrar", for: .normal)
        
        
    }
    
    
    
    @IBAction func apeendCadastroButton(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
