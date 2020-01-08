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

final class AccountDrawdown: AccountEvent, Codable {
/* Account Drawdown is created when a tap session ended */
    
    var accountDrawdownId: String!
    var userId: String!
    var date: Date!
    var tapSessionId: String!
    var tipVideoId: String!
    var tipNb: Int!
    var coinPrice: Int!
    var totalCoinsDrawdown: Double { Double( coinPrice * tipNb) }
    
    init(accountDrawdownId: String, userId: String!, date: Date! , tapSessionId: String!, tipVideoId: String!, tipNb: Int!, coinPrice: Int!) {
        self.accountDrawdownId = accountDrawdownId
        self.userId = userId
        self.date = date
        self.tapSessionId = tapSessionId
        self.tipVideoId = tipVideoId
        self.tipNb = tipNb
        self.coinPrice = coinPrice
    }
}

final class AccountRefill: AccountEvent, Codable {
/* Account Refill is created when the user refilled the account with cash */

    var accountRefillId: String!
    var userId: String!
    var date: Date!
    var cashAmount: Double!
    var coinsAmount: Double!
    
    init(accountRefillId: String!, userId: String!, date: Date!, cashAmount: Double!, coinsAmount: Double!) {
        self.accountRefillId = accountRefillId
        self.userId = userId
        self.date = date
        self.cashAmount = cashAmount
        self.coinsAmount = coinsAmount
    }
    
}


