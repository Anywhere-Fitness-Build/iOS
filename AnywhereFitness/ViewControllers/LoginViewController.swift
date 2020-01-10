//
//  ViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
   // var databaseController = DatabaseController()
    

    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var instructorButton: UIButton!

    private var userController = UserController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
          backgroundImage.image = UIImage(named: "poly")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
          self.view.insertSubview(backgroundImage, at: 0)
        
        
    }

    private func isUserAnInstructor() -> Bool {
        let roleId = DatabaseController.sharedDatabaseController.loginStruct?.roleId
        if let roleId = roleId {
            return roleId % 2 == 0 ? true : false
        }
        return false
    }

    @IBAction func loginTapped(sender: UIButton) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!

        
        var loginUser = UserRepresentation(username:username, password:password)
        DatabaseController.sharedDatabaseController.signIn(with: loginUser){
            error in
            if let error = error {
                print("Error occurred during sign up: \(error)")
                return
            } else {
                loginUser.isInstructor = self.isUserAnInstructor()
                DatabaseController.sharedDatabaseController.getAllClasses { (data, error) in
                    if let error = error {
                        print("Error occurred getting all classes: \(error)")
                    }
                    guard let data = data else { return }
                    self.userController.setUser(user: loginUser, fitnessClasses: data)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ShowUserSegue", sender: self)
                    }
                }
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUserSegue" {
            guard let tabBarController = segue.destination as? UserTabBarController else { return }
            let tabViewControllers = tabBarController.viewControllers
            if let navController = tabViewControllers?[1] as? UINavigationController {
                if let myClassesTVC = navController.topViewController as? MyClassesTableViewController {
                    myClassesTVC.userController = self.userController
                }
            }
            if let navController = tabViewControllers?[0] as? UINavigationController {
                if let classesTVC = navController.topViewController as? SearchClassesTableViewController {
                    classesTVC.userController = self.userController
                }
            }
        }
    }
}
