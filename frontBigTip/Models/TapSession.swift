//
//  TapSession.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

var runningTapSessionList: [TapSession?] = [] // Contains only 1 value or empty

class TapSession: Codable {
/* A tap session is a sequence of tap */
/* Once the session is finished, the data packet is sent to the API to debit the remaining coins */  

    static var isTapSessionRunning: Bool = false
    
    var tapSessionId: String!
    
    var tipVideoId: String!
    var lastTip: Tip? // LastTap is reset when re-taping before end of countdown
    var tipList: [Tip?] = []
    
    var countdown: Double? // Represent the countdown, optional as non mandotory when retrieved from API
    var timer = Timer()
    
    enum CodingKeys: String, CodingKey {
        case tapSessionId
        case tipList
        case tipVideoId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tipVideoId = try container.decode(String.self, forKey: .tipVideoId)
        tapSessionId = try container.decode(String.self, forKey: .tapSessionId)
        tipList = try container.decode([Tip?].self, forKey: .tipList)
        timer = Timer()
    }
    
    init(tapSessionId: String!, tipVideoId: String!) {
        self.countdown = 60
        self.tapSessionId = tapSessionId
        self.tipVideoId = tipVideoId
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
    // Function called each second, and perform the assessment
        if countdown! < 1 {
          self.timer.invalidate()
         } else {
          self.countdown! -= 1
         }
    }
    
    func endTimer() {
        self.timer.invalidate()
    }
}

/* UI Patterns */

    func tapOccured() {
    /*  */
    
        let currentUser = sharedUserData.shared.currentUser!
        let tipVideo = TipVideo(tipVideoId: "xx", previewId: "xx", tipNb: 30, authorName: "john", authorId: "johnid", maxTip: 40, priceTip: 3, tipsList: [], totalTipsNb: 30, totalIncome: 130, maxSize: 30, currentSize: 10)
        let date = Date()
        let newTip = Tip(tipId: "XX", price: 4, date: date, tipVideo: tipVideo, user: currentUser)
        
        if TapSession.isTapSessionRunning == false {
        // Creation a new Tap Session
        
            let tapSession = TapSession(tapSessionId: "tapSessionId1")
            tapSession.tipList.append(newTip)
            tapSession.lastTip = newTip
            tapSession.startTimer()
            
            TapSession.isTapSessionRunning = true // Type Method
            runningTapSessionList.append(tapSession)
        } else {
        // Tap Session is already running, so we update the last tip
        
            // PLACEHOLDER check if new tipVideoId is same as previous one, if not => Save TapSession and Create a new one
            guard let tapSession = runningTapSessionList[0] else { return }
            tapSession.tipList.append(newTip) // update of running tapSession
            tapSession.lastTip = newTip
            
            tapSession.endTimer() // Timer restart
            tapSession.startTimer()
            
        }
        
    }





