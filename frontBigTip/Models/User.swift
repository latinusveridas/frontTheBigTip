//
//  User.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class User: Codable, Hashable {
/* Represent a user object */

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.userId)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userId == rhs.userId
    }
    
    // Static data
    var userId: String
    var login: String
    var email: String
    var password : String
    
    // Variable data
    var tipVideoList: [TipVideo?]?
    var tipsList: [Tip?]?
    
    // Coins data
    var coinsAvailable: Double
    
    init(userId: String, login: String, email: String, password: String, tipVideoList: [TipVideo?]?, tipsList: [Tip?]?, coinsAvailable: Double) {
        self.userId = userId
        self.login = login  
        self.email = email
        self.password = password
        self.coinsAvailable = coinsAvailable
        self.tipVideoList = tipVideoList
        self.tipsList = tipsList
    }
        
}

