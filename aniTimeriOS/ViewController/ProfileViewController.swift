//
//  ProfileViewController.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 17/09/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var titlePageLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNametextField: UITextField!
    @IBOutlet weak var userCityLabel: UILabel!
    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    let pinkColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
    let backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    
    
    @IBAction func changePictureButton(_ sender: Any) {
        openGallery()
    }
    
    func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        ajustProfileImage()
        configLabels(label: titlePageLabel, text: "Perfil", color: pinkColor,fonte: UIFont.boldSystemFont(ofSize: 30))
        configLabels(label: userNameLabel, text:"Nome",color: pinkColor,fonte: UIFont.boldSystemFont(ofSize: 17))
        configLabels(label: userCityLabel, text: "Cidade",color: pinkColor,fonte:UIFont.boldSystemFont(ofSize: 17))
        configLabels(label: userEmailLabel, text: "E-mail",color: pinkColor,fonte: UIFont.boldSystemFont(ofSize: 17))
        configTextField(textField:userNametextField)
        configTextField(textField:userCityTextField)
        configTextField(textField: userEmailTextField)
        configButton(button: saveButton)
        userEmailTextField.text = "laislandin@gmail.com"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func ajustProfileImage(){
        profileImage.image = UIImage(named: "ippocapa.jpeg")
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
    }
    
    func configLabels(label:UILabel,text:String,color:UIColor? = nil,fonte:UIFont? =  nil){
        label.text = text
        label.textColor = color
        label.font = fonte
        label.numberOfLines = 0
        label.textAlignment = .left
    }
    
    func configTextField(textField:UITextField,fonte:UIFont? =  nil){
        textField.textColor = .white
        textField.font = fonte
        textField.textAlignment = .center
        textField.tintColor = .clear
        textField.borderStyle = .none
        textField.textAlignment = .left
    }
    
    func configButton(button:UIButton){
        button.layer.cornerRadius = 20
        button.setTitle("Salvar", for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 146/255, blue: 139/255, alpha: 1.0)
        button.tintColor = backgroundColor
    }
    
    func canEdit(textField:UITextField) -> Bool{
        if textField.text == nil{
            return false
        }else
        {
            return true
        }
    }

}

extension ProfileViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
