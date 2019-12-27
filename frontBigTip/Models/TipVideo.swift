//
//  TipVideo.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

struct TipVideo: Codable {
/* Represent a video object */

    // Static data
    var preview: Preview? // Preview is set as optionnal as we init first TipVideo then the Preview
    var tipVideoId: String
    var authorName: String
    var authorId: String
    
    // Variable data
    var tipNb: Int // Represent the current nb of tips a user gave
    var maxTipNb: Int // Represent the maximum nb of tips a user can give 
    var priceTip: Int // Represent the price of 1 tip
    
    // Global data
    var tipsList: [Tip?] // Represent the total nb of tips, all users included
    var totalTipsNb: Int
    var totalIncome: Int
    
    init(preview: Preview, tipVideoId: String, tipNb: Int, authorName: String, authorId: String, maxTip: Int, priceTip: Int, totalTipsNb: Int, totalIncome: Int) {
        self.preview = Preview
        self.tipVideoId = tipVideoId
        self.authorName = authorName
        self.authorId = authorId
        self.tipNb = tipNb
        self.maxTip = maxTip
        self.priceTip = priceTip
        self.totalTipsNb = totalTipsNb
        self.totalIncome = totalIncome
    }
    
    func updateTipVideo() {
        self.totalTipsNb = self.tipsList.count
        self.totalIncome = self.totalTipsNb * self.priceTip
    }
    
    private func generateId() -> String {
        return "test"
    }
}
