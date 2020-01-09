//
//  SignUpController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/7/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    var signUpDataBaseController = DatabaseController() 
    @IBOutlet weak var usernameTextField: UITextField!
      private var isInstructor: Bool = false
    @IBOutlet weak var instructorButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func isInstructorButtonTapped(_ sender: Any) {
            if isInstructor {
                instructorButton.setImage(UIImage.init(systemName: "square"), for: .normal)
            } else {
                instructorButton.setImage(UIImage.init(systemName: "checkmark.square.fill"), for: .normal)
            }
            isInstructor.toggle()
        }
    
    
    @IBAction func SignUpUserTapped(_ sender: Any) {
                let username = usernameTextField.text!
                let password = passwordTextField.text!
                let isInstructorValue = isInstructor
                let newUser = UserRepresentation(username:username, password:password, isInstructor: isInstructorValue)
                signUpDataBaseController.signUp(with: newUser){
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
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


