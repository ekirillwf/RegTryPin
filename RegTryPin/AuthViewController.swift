//
//  AuthViewController.swift
//  RegTryPin
//
//  Created by Кирилл Елсуфьев on 02.03.2020.
//  Copyright © 2020 Кирилл Елсуфьев. All rights reserved.
//

import UIKit
import Firebase

class AuthViewController: UIViewController {


  
    
    var signup: Bool = true {
        willSet {
            if newValue {
                titleLabel.text = "Регистрация"
                nameFiled.isHidden = false
                enterButton.setTitle("Войти", for: .normal)

            } else {
                titleLabel.text = "Вход"
                nameFiled.isHidden = true
                enterButton.setTitle("Регистрация", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameFiled: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameFiled.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

    }
    @IBAction func switchLogin(_ sender: UIButton) {
        signup = !signup
    }
    
    func showAlert(){
          let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
          present(alert, animated: true, completion: nil)
      }
}


extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = nameFiled.text!
        let email = emailField.text!
        let password = passwordField.text!
        
        if (signup) {
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        if let result = result{
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } else {
                showAlert()
                
            }
        } else {
            if (!email.isEmpty && !password.isEmpty) {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
                showAlert()
            }
        }
        return true
    }
}

