//
//  User.swift
//  AnywhereFitness
//
//  Created by Lambda_School_Loaner_204 on 1/6/20.
//  Copyright © 2020 Lambda_School_Loaner_219. All rights reserved.
//

import Foundation

class User {
    let username: String
    let password: String
    let isInstructor: Bool

    init(username: String, password: String, isInstructor: Bool = false) {
        self.username = username
        self.password = password
        self.isInstructor = isInstructor
    }
}
