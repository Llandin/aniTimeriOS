//
//  LoginViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 05/09/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var bemVinDoLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    @IBOutlet weak var esqueceuSenhaButton: UIButton!
    @IBOutlet weak var appendAddUser: UIButton!
    @IBOutlet weak var cadastroButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configLabelBemVindo(label: bemVinDoLabel)
        configemailText()
        configsenhaText(isSecure: true)
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
        
        emailTextField.placeholder = "Digite seu email"
        emailTextField.layer.cornerRadius = 10
        emailTextField.clipsToBounds = true
    }
    
    func configsenhaText(isSecure : Bool	){
        senhaTextField.placeholder = "Digte sua senha "
        senhaTextField.layer.cornerRadius = 10
        senhaTextField.clipsToBounds = true
        senhaTextField.isSecureTextEntry = isSecure
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
        
        performLogin()
    }
    
    
    func performLogin() {
        guard let username = emailTextField.text,
              let password = senhaTextField.text else {
            return
        }
        
        // Verificação dos dados mockados
        if  username == mockUserData["email"], password == mockUserData ["senha"]{
            // Login bem-sucedido, navegando para outra tela
            
           let tabBarVC = UIStoryboard(name: "TabBarViewController", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
            
            print(navigationController) 
            
           navigationController?.pushViewController(tabBarVC, animated: true)
            
           
        } else {
            
            // Falha no login
            showAlert(title: "Erro", message: "Usuário ou senha inválidos.")
        }
    
    
    // Função para exibir alerta
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true, completion: nil)
    }
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
