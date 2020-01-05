//
//  User.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class User: Codable {
    var userId: String!
    
    enum SuperCodingKeys: String, CodingKey {
        case userId
    }
    
    init(userId: String!) {
        self.userId = userId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SuperCodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
    }
}

class PublicUser: User, Hashable {
/* Represent a user object */
    
    // Static data
    var publicName: String?
    
    enum CodingKeys: String, CodingKey {
        case publicName
    }

    init(userId: String!, publicName: String?) {
        super.init(userId: userId)
        self.userId = userId
        self.publicName = publicName
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.publicName = try container.decode(String.self, forKey: .publicName)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.userId)
    }
    
    static func == (lhs: PublicUser, rhs: PublicUser) -> Bool {
        return lhs.userId == rhs.userId
    }
    
}

class CurrentUser: User {
    
    static let shared = CurrentUser()
    private init() {
        super.init(userId: "")
        // PLACEHOLDER API CALL
    }
    
    // Static data
    var publicName: String!
    var login: String!
    var email: String!
    var password : String!

    // Variable data
    var tipVideoList: [TipVideo?]?
    var tipsList: [Tip?]?

    // Coins data
    var coinsAvailable: Double!

    enum CodingKeys: String, CodingKey {
        case userId
        case publicName
        case login
        case email
        case password
        case tipVideoList
        case tipsList
        case coinsAvailable
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.publicName = try container.decode(String.self, forKey: .publicName)
        self.login = try container.decode(String.self, forKey: .login)
        self.email = try container.decode(String.self, forKey: .email)
        self.password = try container.decode(String.self, forKey: .password)
        self.coinsAvailable = try container.decode(Double.self, forKey: .coinsAvailable)
        self.tipVideoList = try container.decode([TipVideo?]?.self, forKey: .tipVideoList)
        self.tipsList = try container.decode([Tip?]?.self, forKey: .tipsList)
        try super.init(from: decoder)
    }
    
    
}

