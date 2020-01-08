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
    var roleID = RoleID(role_id:2) 

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var instructorButton: UIButton!

    private var isInstructor: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func instructorTapped(sender: UIButton) {
        if isInstructor {
            instructorButton.setImage(UIImage.init(systemName: "square"), for: .normal)
        } else {
            instructorButton.setImage(UIImage.init(systemName: "checkmark.square.fill"), for: .normal)
        }
        isInstructor.toggle()
    }

    @IBAction func loginTapped(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let instructorID = true
        let testUser = UserRepresentation(username:username, password:password, isInstructor: instructorID)
        databaseController.signIn(with: testUser){
             error in
                               if let error = error {
                                   print("Error occurred during sign up: \(error)")
                               } else {
                                   DispatchQueue.main.async {
                                       self.dismiss(animated: true, completion: nil)
                                   }
       
     
                

    }
}


}
}
