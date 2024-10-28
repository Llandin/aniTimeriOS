//
//  LoginViewController.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 05/09/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var loginGoogle: UIButton!
    
    @IBOutlet weak var imageGoogle: UIImageView!
    var errorColor = UIColor(red: 247/255, green: 0/255, blue: 0/255, alpha: 1.0);
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupView()
        configureWelcomeLabel(label: welcomeLabel)
        configureEmailTextField()
        configurePasswordTextField(isSecure: true)
        configureForgotPasswordButton()
        configLabel(label: errorMessage, text: "", textColor: .systemPink, font:UIFont(name: "Menlo", size:13)!)
        configureLoginButton()
        configureSignUpButton()
        loginButtonGoogle()
        imageViewGoogle()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
      
        
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
        loginButton.backgroundColor = .lightGray
        loginButton.isEnabled = false
        
    }
    
    
    func configLabel(label:UILabel,text:String,textColor:UIColor,font:UIFont){
        label.text = text
        label.textColor = textColor
        label.font = font
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    
    func configureSignUpButton(){
        
        signUpButton.setTitle("Não possui conta? Cadastre-se!", for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.tintColor = .gray
        
        
    }
    
    func imageViewGoogle(){
        
        imageGoogle.image = UIImage(named: "Google")
        
        
    }
    
    
    func loginButtonGoogle(){
        
        loginGoogle.tintColor = .white
        loginGoogle.setTitle("Sign in with Google", for: .normal)
        loginGoogle.setTitleColor(.black, for: .normal)
        
    }
    
    
    
    
    @IBAction func navigateToTabBarController(_ sender: Any) {
        
        let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        
        
        guard let email = emailTextField.text, !email.isEmpty,
              let senha = passwordTextField.text, !senha.isEmpty else {
     
            return
        }
        
        
        // Tente fazer o login com Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: senha) { authResult, error in
            if let error = error {
                self.errorMessage.text = "Erro ao fazer login: Credenciais inválidas"
                return
            }
            
            
            let tabBarVC = TabBarViewController()
            self.navigationController?.pushViewController(tabBarVC, animated: true)
            
        }
        
    }
    
    
    
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        let controller = UIStoryboard(name: "TelaResetPassword", bundle: nil).instantiateViewController(withIdentifier: "TelaResetPasswordViewController") as? TelaResetPasswordViewController
        
        
        navigationController?.pushViewController(controller ?? ViewController(), animated: true)
        
    }
    
    @IBAction func GoogleSignInTapped(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [] result, error in
            if let error {
                // you can add error handling
                print("Error", error)
                return
            }
        }
      
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        let cont = UIStoryboard(name: "TelaCadastroViewController", bundle: nil).instantiateViewController(withIdentifier: "TelaCadastroViewController") as? TelaCadastroViewController
        
        navigationController?.pushViewController(cont ?? UIViewController(), animated: true)
    }
    

    func validateEmail(_ email: String) {
        loginButton.isEnabled = false
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)

        if isValid{
            emailTextField.layer.borderColor = UIColor.green.cgColor
            emailTextField.layer.borderWidth = 2.0
            loginButton.isEnabled = true
            errorMessage.text = " "
        } else {
            emailTextField.layer.borderColor = UIColor.red.cgColor
            errorMessage.text = "Formato de email inválido"
            emailTextField.layer.borderWidth = 2.0
            loginButton.isEnabled = false
        }
    }
    
    func validatePassword(_ password: String) {
        if password.count >= 6 {
            passwordTextField.layer.borderColor = UIColor.green.cgColor
            passwordTextField.layer.borderWidth = 2.0
            loginButton.isEnabled = true
            errorMessage.text = " "
        } else {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            errorMessage.text = "Senha deve conter o mínimo de 6 caracteres!"
            passwordTextField.layer.borderWidth = 2.0
            loginButton.isEnabled = false
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let currentText = textField.text ?? ""

          guard let stringRange = Range(range, in: currentText) else { return false }
          let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
 
          if textField == emailTextField {
              validateEmail(updatedText)
          } else if textField == passwordTextField {
              validatePassword(updatedText)
          }
          
          return true
      }
    
}
