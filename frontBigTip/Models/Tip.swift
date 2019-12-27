//
//  Tip.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

struct Tip: Codable {
/* Represent a Tip object */

    var price: Int
    var date: Date
    var tipVideo: TipVideo
    var user: User
    
    init(price: Int, date: Date, tipVideo: TipVideo, user: User) {
        self.price = price
        self.date = date
        self.tipVideo = TipVideo
        self.user = User
    }
}