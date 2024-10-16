//
//  TelaCadastroViewController.swift
//  aniTimeriOS
//
//  Created by Sthashy Vieira on 12/09/24.
//

import UIKit
import Firebase
import FirebaseAuth

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
        
        // Verifique se os campos de email e senha estão preenchidos
            guard let email = emailTextFiel.text, !email.isEmpty,
                  let senha = senhaTextFiel.text, !senha.isEmpty,
                  let confirmarSenha = configSenhaTextFiel.text, !confirmarSenha.isEmpty else {
                print("Erro: Por favor, preencha todos os campos.")
                return
            }

            // Verifique se as senhas coincidem
            guard senha == confirmarSenha else {
                print("Erro: As senhas não coincidem.")
                return
            }

            // Iniciar o processo de cadastro com Firebase Authentication
            Auth.auth().createUser(withEmail: email, password: senha) { authResult, error in
                if let error = error {
                    // Se houve um erro, exibir a mensagem no console
                    print("Erro ao cadastrar usuário: \(error.localizedDescription)")
                } else {
                    // Sucesso ao criar o usuário, exibir no console
                    print("Usuário cadastrado com sucesso! ID: \(authResult?.user.uid ?? "Sem ID")")
                    // Navegar para a tela de login
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        
    }
}
