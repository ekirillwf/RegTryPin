//
//  ViewController.swift
//  RegTryPin
//
//  Created by Кирилл Елсуфьев on 02.03.2020.
//  Copyright © 2020 Кирилл Елсуфьев. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()

        } catch {
            print (error)
            
        }
    }
    
}

