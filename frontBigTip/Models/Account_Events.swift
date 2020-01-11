//
//  AccountStatement.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class AccountEvent {
}

final class AccountDrawdown: AccountEvent, Codable, Equatable {
/* Account Drawdown is created when a tap session ended */
    
    static func == (lhs: AccountDrawdown, rhs: AccountDrawdown) -> Bool {
        return lhs.accountDrawdownId == rhs.accountDrawdownId
    }
    
    var accountDrawdownId: String!
    var userId: String!
    var date: Date!
    var tapSessionId: String!
    var tipVideoId: String!
    var tipNb: Int!
    var coinPrice: Int!
    var totalCoinsDrawdown: Double! { Double( coinPrice * tipNb) }
    
    enum CodingKeys: String, CodingKey {
        case accountDrawdownId
        case userId
        case date
        case tapSessionId
        case tipVideoId
        case tipNb
        case coinPrice
    }
    
    init(accountDrawdownId: String, userId: String!, date: Date! , tapSessionId: String!, tipVideoId: String!, tipNb: Int!, coinPrice: Int!) {
        self.accountDrawdownId = accountDrawdownId
        self.userId = userId
        self.date = date
        self.tapSessionId = tapSessionId
        self.tipVideoId = tipVideoId
        self.tipNb = tipNb
        self.coinPrice = coinPrice
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accountDrawdownId = try container.decode(String.self, forKey: .accountDrawdownId)
        self.userId = try container.decode(String.self, forKey: .userId)
        let strDate = try container.decode(String.self, forKey: .date)
        let formatter = ISO8601DateFormatter()
        self.date = formatter.date(from: strDate)
        self.tapSessionId = try container.decode(String.self, forKey: .tapSessionId)
        self.tipVideoId = try container.decode(String.self, forKey: .tipVideoId)
        self.tipNb = try container.decode(Int.self, forKey: .tipNb)
        self.coinPrice = try container.decode(Int.self, forKey: .coinPrice)
    }
}

final class AccountRefill: AccountEvent, Codable, Equatable {
/* Account Refill is created when the user refilled the account with cash */

    static func == (lhs: AccountRefill, rhs: AccountRefill) -> Bool {
        return lhs.accountRefillId == rhs.accountRefillId
    }
    
    var accountRefillId: String!
    var userId: String!
    var date: Date!
    var cashAmount: Double!
    var coinsAmount: Double!
    
    enum CodingKeys: String, CodingKey {
        case accountRefillId
        case userId
        case date
        case cashAmount
        case coinsAmount
    }
    
    init(accountRefillId: String!, userId: String!, date: Date!, cashAmount: Double!, coinsAmount: Double!) {
        self.accountRefillId = accountRefillId
        self.userId = userId
        self.date = date
        self.cashAmount = cashAmount
        self.coinsAmount = coinsAmount
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accountRefillId = try container.decode(String.self, forKey: .accountRefillId)
        self.userId = try container.decode(String.self, forKey: .userId)
        let strDate = try container.decode(String.self, forKey: .date)
        let formatter = ISO8601DateFormatter()
        self.date = formatter.date(from: strDate)
        self.cashAmount = try container.decode(Double.self, forKey: .cashAmount)
        self.coinsAmount = try container.decode(Double.self, forKey: .coinsAmount)
    }
    
}


