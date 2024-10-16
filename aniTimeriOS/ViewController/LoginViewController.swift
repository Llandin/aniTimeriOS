//
//  LoginViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 05/09/24.
//

import UIKit
import Firebase
import FirebaseAuth
class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureWelcomeLabel(label: welcomeLabel)
        configureEmailTextField()
        configurePasswordTextField(isSecure: true)
        configureForgotPasswordButton()
        configureLoginButton()
        configureSignUpButton()
    }
    
    
    func setupView() {
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    }
    
    func configureWelcomeLabel(label : UILabel ){
        
        welcomeLabel.text = "Bem-Vindo "
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        
    }
    
    func configureEmailTextField(){
        
        emailTextField.placeholder = "Digite seu email"
        emailTextField.layer.cornerRadius = 10
        emailTextField.clipsToBounds = true
    }
    
    func configurePasswordTextField(isSecure : Bool	){
        passwordTextField.placeholder = "Digte sua senha "
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.clipsToBounds = true
        passwordTextField.isSecureTextEntry = isSecure
    }
    
    func configureForgotPasswordButton(){
        
        forgotPasswordButton.setTitle("Esqueceu sua senha?", for: .normal)
        forgotPasswordButton.tintColor = .gray
        
        
    }
    
    
    func configureLoginButton(){
        
        loginButton.setTitle("Confirmar", for: .normal)
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 10
        
    }
    
    
    func configureSignUpButton(){
        
        signUpButton.setTitle("Não possui conta? Cadastre-se!", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.tintColor = .gray
        
        
    }
    
    @IBAction func navigateToTabBarController(_ sender: Any) {
        
        let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        

        guard let email = emailTextFiel.text, !email.isEmpty,
              let senha = senhaTextFiel.text, !senha.isEmpty else {
            print("Erro: Preencha todos os campos.")
            return
        }
        
        // Tente fazer o login com Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: senha) { authResult, error in
            if let error = error {
                print("Erro ao fazer login: \(error.localizedDescription)")
                return
            }
            
            
            let tabBarVC = TabBarViewController()
            self.navigationController?.pushViewController(tabBarVC, animated: true)
            
        }

        
        navigationController?.pushViewController(tabBarVC, animated: true)
    }
    

    
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        let controller = UIStoryboard(name: "TelaResetPassword", bundle: nil).instantiateViewController(withIdentifier: "TelaResetPasswordViewController") as? TelaResetPasswordViewController
        
        
        navigationController?.pushViewController(controller ?? ViewController(), animated: true)
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let cont = UIStoryboard(name: "TelaCadastroViewController", bundle: nil).instantiateViewController(withIdentifier: "TelaCadastroViewController") as? TelaCadastroViewController
        
        navigationController?.pushViewController(cont ?? UIViewController(), animated: true)
    }
    
    
}
