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

class AccountDrawdown: AccountEvent {
/* Account Drawdown is created when a tap session ended */
    
    var accountDrawdownId: String!
    weak var user: User!
    var tapSessionId: String!
    var tipNb: Int!
    var coinPrice: Int!
    var totalCoinsDrawdown: Double { Double( coinPrice * tipNb) }
    
    init(accountDrawdownId: String, user: User, tapSessionId: String!, tipNb: Int!, coinPrice: Int!) {
        self.accountDrawdownId = accountDrawdownId
        self.user = user
        self.tapSessionId = tapSessionId
        self.tipNb = tipNb
        self.coinPrice = coinPrice
    }
    
}


