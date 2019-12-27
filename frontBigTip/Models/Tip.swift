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
    
    func Tipped() {
        /* This function is launch when the user had tiped */
        /* As the Tip instance is already created on init, only TipVideo object is amended */
        
        self.tipVideo.tipsList.append(self) // Add tip in the TipList of related TipVideo Object
        self.tipVideo.updateTipVideo() // Update
    }
    
}