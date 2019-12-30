//
//  TipVideo.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class TipVideo: Codable {
/* Represent a video object */

    // Static data
    var tipVideoId: String
    var previewId: String
    var preview: Preview? // Preview is set as optionnal as we init first TipVideo then the Preview
    var authorName: String
    var authorId: String
    var maxTipNb: Int // Represent the maximum nb of tips a user can give
    var priceTip: Int // Represent the price of 1 tip

    // Variable data
    var tipNb: Int // Represent the current nb of tips a user gave

    // Aggregated data, e.g. total calculations
    var tipsList: [Tip?] // Represent the total nb of tips, all users included
    var totalTipsNb: Int
    var totalIncome: Int

    // Video data
    var maxSize: Double
    var currentSize: Double

    init(tipVideoId: String, previewId: String, tipNb: Int, authorName: String, authorId: String, maxTip: Int, priceTip: Int, tipsList: [Tip?], totalTipsNb: Int, totalIncome: Int, maxSize: Double, currentSize: Double) {
        self.tipVideoId = tipVideoId
        self.previewId = previewId
        self.authorName = authorName
        self.authorId = authorId
        self.tipNb = tipNb
        self.maxTipNb = maxTip
        self.priceTip = priceTip
        self.totalTipsNb = totalTipsNb
        self.totalIncome = totalIncome
        self.tipsList = tipsList
        self.maxSize = maxSize
        self.currentSize = currentSize
    }

    func updateTipVideo() {
        self.totalTipsNb = self.tipsList.count
        self.totalIncome = self.totalTipsNb * self.priceTip
    }

//    func tipped() {
//        /* This function is launch when the user had tiped */
//
//        let dateTip = Date()
//        let user = User
//        let newTip = Tip(price: self.priceTip, tipVideo: self, user: user )
//
//        self.tipVideo.tipsList.append(newTip) // Add tip in the TipList of related TipVideo Object
//        self.tipVideo.updateTipVideo() // Update nb tips
//    }

    private func generateId() -> String {
    /* ID structure is TP_authorId_randomNb */
        return "test"
    }
    
}
