//
//  TelaResetPasswordViewController.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 16/09/24.
//

import UIKit

class TelaResetPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var titleScreenLabel: UILabel!
    @IBOutlet weak var resetPassLabel: UILabel!
    @IBOutlet weak var textForUserLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    let backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    let pinkColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configLabels(label: titleScreenLabel, text: "ANITIMER", color:pinkColor ,fonte: UIFont(name: "Sinhala Sangam MN", size: 30)!)
        
        configLabels(label: resetPassLabel, text: "Redefinição de Senha!", color: .white)
        resetPassLabel.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        
        configLabels(label: textForUserLabel, text: "Informe um email e enviaremos um link para recuperação da sua senha.", color: .white, fonte: UIFont(name: "Arial", size: 15)!)
        
        configLabels(label: emailLabel, text: "E-mail", color: .white, fonte: UIFont(name: "Helvetica Neue", size: 16)!)
        
        configTextField(textfield: emailTextField,backgroundcolor: backgroundColor)
        
        emailTextField.setupLeftSideImage(ImageViewNamed: "icons8-envelope-48.png")
        
        cofigButton(resetPassButton: resetPasswordButton, title: "Enviar link de recuperação", tintColor: pinkColor)
        
        
        setBackgroundColor()
    }
    
    func configLabels(label:UILabel,text:String,color:UIColor? = nil,fonte:UIFont? =  nil){
        label.text = text
        label.textColor = color
        label.font = fonte
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
    func configTextField(textfield:UITextField,placeHolder: String? = nil,backgroundcolor:UIColor? = nil){
        textfield.placeholder = placeHolder
        textfield.backgroundColor = backgroundColor
        textfield.layer.borderColor = pinkColor.cgColor
        textfield.layer.cornerRadius = 10
        textfield.textColor = .white
        textfield.layer.borderWidth = 0.9
        //textfield.frame = CGRect(x: 10, y: 10, width: 300, height: 50)

    }
    
    func cofigButton(resetPassButton:UIButton, title:String,tintColor:UIColor){
        resetPassButton.setTitle(title, for: .normal)
        resetPassButton.tintColor = tintColor
        resetPassButton.layer.cornerRadius = 15
        
    }
    
    private func setBackgroundColor(){
        view.backgroundColor = backgroundColor
    }
    
}

extension UITextField {
    func setupLeftSideImage (ImageViewNamed:String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        imageView.image = UIImage(named: ImageViewNamed)
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        imageViewContainerView.addSubview(imageView)
        leftView = imageViewContainerView
        leftViewMode = .always
        
    }
}

