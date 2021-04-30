//
//  AuthregViewController.swift
//  Cafe-Manager
//
//  Created by Bhanuka Nishen on 2021-04-30.
//

import UIKit
import FirebaseAuth
import Firebase

class AuthregViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    @IBAction func regevent(_ sender: Any) {
        
        
        if email.text == "" || phone.text == "" || password.text == ""
        {
            let alert = UIAlertController(title: "failure", message: "required feild empty", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 })
                 alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        else
        {
            
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (result, err) in
                if err != nil {
          
                    let alert = UIAlertController(title: "failure", message: "false", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                         })
                         alert.addAction(ok)
                    self.present(alert, animated: true)
                }
                else
                {
                    let db = Firestore.firestore()
                  
                    let ref =  db.collection("Userinfo")
                    
          
                    
                    
                    ref.addDocument(data: ["phone" :self.phone.text!,"UID" : result!.user.uid ,"email": result!.user.email!]) { (erro) in
                        if erro != nil
                        {
                         print(erro)
                        }
                        else
                        {
                          
                          
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "homesection") as! UITabBarController

                                self.navigationController?.pushViewController(nextViewController, animated: true)
                        }
                    }
                }
            }

        }
    }
    
}
