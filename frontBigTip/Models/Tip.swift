//
//  Tip.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class Tip: Codable, Hashable {
/* Represent a Tip object */

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.tipId)
    }
    
    static func == (lhs: Tip, rhs: Tip) -> Bool {
        return lhs.tipId == rhs.tipId
    }
    
    var tipId: String!
    var price: Int!
    var date: Date!
    var tipVideoId: String!
    var userId: String!
    
    enum CodingKeys: String, CodingKey {
        case tipId
        case price
        case date
        case tipVideoId
        case userId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tipId = try container.decode(String.self, forKey: .tipId)
        price = try container.decode(Int.self, forKey: .price)
        let strDate = try container.decode(String.self, forKey: .date)
        let formatter = ISO8601DateFormatter()
        date = formatter.date(from: strDate)
        tipVideoId = try container.decode(String.self, forKey: .tipVideoId)
        userId = try container.decode(String.self, forKey: .userId)
    }

    init(tipId: String, price: Int, date: Date, tipVideoId: String!, userId: String!) {
        self.tipId = tipId
        self.price = price
        self.date = date
        self.tipVideoId = tipVideoId
        self.userId = userId
    }

}
