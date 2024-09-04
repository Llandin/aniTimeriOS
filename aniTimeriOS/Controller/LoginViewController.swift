//
//  LoginViewController.swift
//  aniTimeriOS
//
//  Created by Lais Landin on 03/09/24.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var tappedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        
        let a = UIStoryboard(name:"HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                
                // CHAMAR NAVEGAÇÅO
                
                navigationController?.pushViewController( a ?? UIViewController(), animated: true)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
