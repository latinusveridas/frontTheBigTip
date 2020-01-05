//
//  Account.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 04/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

final class Account {
    
    static let shared = Account()
    private init() {
        self.user = shareduserData.CurrentUser!
        self.coinsAvailable = shareduserData.CurrentUser!.coinsAvailable
        self.accountDrawdownsList = []
        self.refillList = []
    }
    
    let user: User!
    
    var refillList: [Refill?] // A
    var accountDrawdownsList: [AccountDrawdown?] // B
    var coinsAvailable: Double! // A - B
        
    func calculateCoinsAvailable() {
        var calcCoins: Double = 0.00
        
        self.refillList.forEach { refillItem in
            calcCoins = calcCoins + refillItem!.coinsAmount
        }
        
        self.accountDrawdownsList.forEach { drawdownItem in
            calcCoins = calcCoins - drawdownItem!.totalCoinsDrawdown
        }
        
        self.coinsAvailable = calcCoins
    }
    
    func getAccountStatement() {
        
    }
    
    
}

final class Refill {
    
    var date: Date!
    var cashAmount: Double!
    var coinsAmount: Double!
    var user: User!
    
}
