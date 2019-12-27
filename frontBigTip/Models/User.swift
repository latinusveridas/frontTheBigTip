//
//  User.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

struc User {
/* Represent a user object */

    var userId: String
    var login: String
    var email: String
    var password : String
    
    init(userId: String, login: String, email: String, password: String) {
        self.userId = userId
        self.login = login  
        self.email = email
        self.password = password
    }
}