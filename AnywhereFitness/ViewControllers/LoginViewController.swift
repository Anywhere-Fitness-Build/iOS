//
//  ViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_219 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {

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

    }
}

