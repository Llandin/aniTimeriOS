//
//  ProfileViewController.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 17/09/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var userCityLabel: UILabel!
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var extraLabel: UILabel!
    @IBOutlet weak var aboutMeTextView: UITextView!
    
    let backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1)
    
    @IBOutlet weak var extraTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        ajustProfileImage()
        configLabels(label: userNamelabel, text:"Murilo Coutinho",color: .white)
        configLabels(label: userCityLabel, text: "Aracajú - Sergipe",color: .white)
        configLabels(label: aboutMeLabel, text: "Sobre Mim:",color: .white)
        configLabels(label: extraLabel, text: "Extras:",color: .white)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    func ajustProfileImage(){
        profileImage.image = UIImage(named: "ippocapa.jpeg")
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    }
    
    func configLabels(label:UILabel,text:String,color:UIColor? = nil,fonte:UIFont? =  nil){
        label.text = text
        label.textColor = color
        label.font = fonte
        label.numberOfLines = 0
        label.textAlignment = .center
    }
    
}
