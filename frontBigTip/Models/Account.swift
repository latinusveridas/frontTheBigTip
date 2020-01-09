//
//  Account.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 04/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

final class Account: Codable {
    
    static let shared = Account()
    init() {
        self.userId = shareduserData.currentUser!.userId
        self.coinsAvailable = shareduserData.currentUser!.coinsAvailable
        self.drawdownList = []
        self.refillList = []
    }
    
    let userId: String!
    var refillList: [AccountRefill?] // A
    var drawdownList: [AccountDrawdown?] // B
    var coinsAvailable: Double! // A - B
        
    func calculateCoinsAvailable() {
    /* Calculate coinsAvalaible based on accountDrawdowns list & refill List */
        var calcCoins: Double = 0.00
        self.refillList.forEach { refillItem in
            calcCoins = calcCoins + refillItem!.coinsAmount
        }
        self.drawdownList.forEach { drawdownItem in
            calcCoins = calcCoins - drawdownItem!.totalCoinsDrawdown
        }
        self.coinsAvailable = calcCoins
    }
    
    func getAccountStatement() {
        
    }
    
    
}


