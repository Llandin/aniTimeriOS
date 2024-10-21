//
//  ProfileViewController.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 17/09/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Firebase



class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var userMessage: UILabel!
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
    
    let db = Firestore.firestore()
    
    
    
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
        profileImage.image = UIImage(named:"ippocapa.jpeg")
        loadUserProfile()
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
        configLabels(label: userMessage, text: "")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func ajustProfileImage(){
        profileImage.image = nil
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
    
    func uploadImageToFirebase(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("profile_images/\(UUID().uuidString).jpg")
        
        profileImageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Erro ao fazer upload da imagem: \(error.localizedDescription)")
                return
            }
            // Imagem enviada com sucesso
            profileImageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Erro ao obter a URL: \(error.localizedDescription)")
                    return
                }
                guard let downloadURL = url else { return }
                print("URL da imagem: \(downloadURL)")
            }
        }
    }
    
    
    @IBAction func saveProfileTapped(_ sender: Any){
        guard let user = Auth.auth().currentUser else { return }
        guard let name = userNametextField.text, !name.isEmpty,
              let city = userCityTextField.text, !city.isEmpty,
              let email = userEmailTextField.text, !email.isEmpty else {
            userMessage.text = "Erro ao alterar informações"
            userMessage.textColor = .red
            return
        }
        
        let userProfile = UserProfile(name: name, email: email, city: city)
        
       
        db.collection("users").document(user.uid).setData([
            "name": userProfile.name,
            "email": userProfile.email,
            "city": userProfile.city,
        ]) { error in
            if let error = error {
                self.userMessage.text = "Erro ao salvar perfil: \(error.localizedDescription)"
            } else {
                self.userMessage.text = "Perfil salvo com sucesso!"
                self.userMessage.textColor = .white
            }
        }
    }
    
    private func loadUserProfile() {
            guard let user = Auth.auth().currentUser else { return }
            
            db.collection("users").document(user.uid).getDocument { document, error in
                if let document = document, document.exists {
                    let data = document.data()
                    self.userNametextField.text = data?["name"] as? String
                    self.userEmailTextField.text = data?["email"] as? String
                    self.userCityTextField.text = data?["city"] as? String
                    
                } else {
                    self.userNametextField.text = " "
                    self.userEmailTextField.text = " "
                    self.userCityTextField.text = " "
                  
                }
            }
        }
        
}

    

extension ProfileViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
                profileImage.image = image
                uploadImageToFirebase(image)
            }
            dismiss(animated: true, completion: nil)
        }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
