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
    
    @IBOutlet weak var nameLabelAviso: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTelaCadastro()
        configRegistro(regist: registroLabel)
        configSetTextFiel(name: nameTextField, email: emailTextFiel, senha: senhaTextFiel, confimarSenha: configSenhaTextFiel)
        tenhoConta(conta: tenhoContaLabel)
        configButton()
        configSenha(isSecure: true, confirmarSenha: true	)
        avisoLabel()
        
        
        nameTextField.delegate = self
        emailTextFiel.delegate = self
        senhaTextFiel.delegate = self
        configSenhaTextFiel.delegate = self
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
    
    func isAbleToRegistry() -> Bool{
        if mandatoryFieldsdFilled() == true && isPasswordsEqual() == true{
            return true
        }else{
            return false
        }
    }
    
    func avisoLabel(){
        
        
        nameLabelAviso.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabelAviso.font = UIFont(name: "Menlo", size:13)!
        nameLabelAviso.textColor =  .systemPink
        nameLabelAviso.text = ""
        
        
    }
    
    @IBAction func apeendCadastroButton(_ sender: UIButton) {
        
        if isAbleToRegistry() == true{
            let email = emailTextFiel.text!
            let senha = senhaTextFiel.text!
            
            Auth.auth().createUser(withEmail: email, password: senha) { authResult, error in
                if let error = error {
                    if error.localizedDescription == "The email address is already in use by another account."{
                        self.nameLabelAviso.text = "Email já cadastrado em nosso app! Recupere sua senha para logar"
                    }else{
                        self.nameLabelAviso.text = "Erro ao cadastrar o usuário, confira os dados e tente novamente."
                        print("Erro ao cadastrar usuário: \(error.localizedDescription)")
                    }
                } else {
                    // Sucesso ao criar o usuário, exibir no console
                    self.nameLabelAviso.text = "Usuário cadastrado com sucesso!"
                    print("Usuário cadastrado com sucesso! ID: \(authResult?.user.uid ?? "Sem ID")")
                    // Navegar para a tela de login
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    func mandatoryFieldsdFilled()-> Bool{
        let fields = [
            ("nome", nameTextField.text),
            ("email", emailTextFiel.text),
            ("senha", senhaTextFiel.text),
            ("confirmacaoSenha", configSenhaTextFiel.text)
        ]
        
        for (_,text) in fields {
            switch text {
            case .none, "":
                nameLabelAviso.text = "Favor preencher todos os campos acima"
                return false
            default:
                continue
            }
        }
        return true
    }
    
    func isPasswordsEqual() -> Bool{
        let password = senhaTextFiel?.text
        let confirmationPassword = configSenhaTextFiel?.text
        
        if password == confirmationPassword{
            return true
        }else{
            nameLabelAviso.text = "Senhas não coicidem."
            return false
        }
    }
    
    func validateEmail(_ email: String) {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        
        if isValid{
            emailTextFiel.layer.borderColor = UIColor.green.cgColor
            emailTextFiel.layer.borderWidth = 2.0
            nameLabelAviso.text = " "
        } else {
            emailTextFiel.layer.borderColor = UIColor.red.cgColor
            nameLabelAviso.text = "Formato de email inválido"
            emailTextFiel.layer.borderWidth = 2.0
        }
    }
    
    func validatePassword(_ password: String) {
        if password.count >= 6 {
            senhaTextFiel.layer.borderColor = UIColor.green.cgColor
            senhaTextFiel.layer.borderWidth = 2.0
            nameLabelAviso.text = " "
        } else {
            senhaTextFiel.layer.borderColor = UIColor.red.cgColor
            nameLabelAviso.text = "Senha deve conter o mínimo de 6 caracteres!"
            senhaTextFiel.layer.borderWidth = 2.0
        }
    }
    
}

extension TelaCadastroViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if textField == emailTextFiel {
            validateEmail(updatedText)
        } else if textField == senhaTextFiel {
            validatePassword(updatedText)
        }
        return true
    }
}
