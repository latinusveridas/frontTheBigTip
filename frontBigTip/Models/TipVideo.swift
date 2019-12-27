//
//  TipVideo.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

struct TipVideo {
/* Represent a video object */

    // Static data
    var previewId: String
    var tipVideoId: String
    var authorName: String
    var authorId: String
    
    // Variable data
    var tipNb: Int // Represent the current nb of tips a user gave
    var maxTipNb: Int // Represent the maximum nb of tips a user can give 
    var priceTip: Int // Represent the price of 1 tip
    
    // Global data
    var tipsList: [Tip] // Represent the total nb of tips, all users included
    var totalTipsNb = tipsList.count
    var totalIncome = totalTipsNb * priceTip
    
    init(previewId: String, tipVideoId: String, tipNb: Int, authorName: String, authorId: String, maxTip: Int, priceTip: Int) {
        self.previewId = previewId
        self.tipVideoId = tipVideoId
        self.authorName = authorName
        self.authorId = authorId
        self.tipNb = tipNb
        self.maxTip = maxTip
        self.priceTip = priceTip
    }
    
    func createTipVideo(previewId: String, tipNb: Int, authorName: String, authorId: String, maxTip: Int, priceTip: Int) {
        self.previewId = previewId
        self.tipVideoId = generateId()
        self.authorName = authorName
        self.authorId = authorId
        self.tipNb = 0
        self.maxTip = maxTip
        self.priceTip = priceTip
    }
    
    func updateTipNb() {
        
    }
    
    private func generateId() -> String {
        return "test"
    }
}
