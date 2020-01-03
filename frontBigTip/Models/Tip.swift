//
//  Tip.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

struct Tip: Codable, Hashable {
/* Represent a Tip object */

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.tipId)
    }
    
    var tipId: String
    var price: Int
    var date: Date
    weak var tipVideo: TipVideo
    weak var user: User

    init(tipId: String, price: Int, date: Date, tipVideo: TipVideo, user: User) {
        self.tipId = tipId
        self.price = price
        self.date = date
        self.tipVideo = tipVideo
        self.user = user
    }

}
