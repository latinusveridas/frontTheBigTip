//
//  Account.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 04/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class Account: Codable {
    
    static let shared = Account()

    let userId: String!
    var refillList: [AccountRefill?] // A
    var drawdownList: [AccountDrawdown?] // B
    var coinsAvailable: Double! // A - B
    
    init() {
        self.userId = sharedUserData.currentUser!.userId
        self.coinsAvailable = sharedUserData.currentUser!.coinsAvailable
        self.drawdownList = []
        self.refillList = []
    }
    
    enum CodingKeys: String, CodingKey {
        case userId
        case refillList
        case drawdownList
        case coinsAvailable
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.refillList = try container.decode([AccountRefill?].self, forKey: .refillList)
        self.drawdownList = try container.decode([AccountDrawdown?].self, forKey: .drawdownList)
        self.coinsAvailable = try container.decode(Double.self, forKey: .coinsAvailable)
    }
        
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
        
    
}


