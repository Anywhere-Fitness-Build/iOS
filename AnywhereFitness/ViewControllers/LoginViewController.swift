//
//  ViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    var databaseController = DatabaseController()
    

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var instructorButton: UIButton!

    private var isInstructor: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func loginTapped(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        let loginUser = UserRepresentation(username:username, password:password)
        databaseController.signIn(with: loginUser){
            error in
            if let error = error {
                print("Error occurred during sign up: \(error)")
            }
        }
    }
}
