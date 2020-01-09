//
//  User.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class User: Codable {
/* Represent a user object */

    var userId: String!
    var followedUserList: [User?]
    var publicName: String!
    
    enum CodingKeys: String, CodingKey {
        case userId
        case followedUserList
        case publicName
    }
    
    init(userId: String!, publicName: String!) {
        self.userId = userId
        self.followedUserList = []
        self.publicName = publicName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.followedUserList = try container.decode([User?].self, forKey: .followedUserList)
        self.publicName = try container.decode(String.self, forKey: .publicName)
    }
}

class PublicUser: User, Hashable {
    
    init() {
        super.init(userId: "", publicName: "")
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.userId)
    }
    
    static func == (lhs: PublicUser, rhs: PublicUser) -> Bool {
        return lhs.userId == rhs.userId
    }
    
}

class CurrentUser: User {
/* Represent a the current user object, used as a singleton through the application */    

    static let shared = CurrentUser()
    private init() {
        // PLACEHOLDER API CALL
        super.init(userId: "", publicName: "")
    }
    
    // Static data
    var login: String!
    var email: String!
    var password : String!
    var jwt: String?

    // Variable data
    var tipVideoList: [TipVideo?]? // Own TipVideo
    var tipsList: [Tip?]? // 

    // Coins data
    var coinsAvailable: Double!

    enum CodingKeys: String, CodingKey {
        case login
        case email
        case password
        case tipVideoList
        case tipsList
        case coinsAvailable
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.login = try container.decode(String.self, forKey: .login)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.coinsAvailable = try container.decode(Double.self, forKey: .coinsAvailable)
        self.tipVideoList = try container.decode([TipVideo?]?.self, forKey: .tipVideoList)
        self.tipsList = try container.decode([Tip?]?.self, forKey: .tipsList)
        try super.init(from: container.superDecoder())
    }
    
    
}

