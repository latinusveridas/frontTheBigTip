//
//  TapSession.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

var runningTapSessionList = [TapSession?]

class TapSession {
/* A tap session is a sequence of tap */
/* Once the session is finished, the data packet is sent to the API to debit the remaining coins */  

    static var isTapSessionRunning: Bool = False
    
    var lastTip: Tip // LastTap is reset when re-taping before end of countdown 
    var tipList: [Tip?]
    
    var countdown: Double // Represent the time 
    let timer: Timer?
    
    init(countdown: Double) {
        self.countdown = countdown
        self.timer = Timer()
        startTimer()
    }

    func startTimer() {
        self.timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
    // Function called each second, and perform the assessment
         if seconds < self.countdown {
          self.timer.invalidate()
          
         } else {
              self.countdown -= 1
         }
     
    }
    
    func endTimer() {
        self.timer.invalidate()
    }

}

/* UI Patterns */

    func tapOccured() {
    /*  */
    
        var currentUser = sharedUserData.CurrentUser
        var tipVideo  = // CurrentViewTipVideo
        var date = Date()
        var newTip = Tip(tipId: "XX", price: 4, date: date, tipVideo: tipVideo, user: currentUser)
        
        if TapSession.isTapSessionRunning = False {
        // Creation a new Tap Session
        
            var tapSession = TapSession()
            tapSession.tipList.append(newTip)
            tapSession.lastTip = newTip
            tapSession.startTimer()
            
            TapSession.isTapSessionRunning = True // Type Method
            runningTapSessionList.append(tapSession)
        } else {
        // Tap Session is already running, so we update the last tip
        
            guard let tapSession = runningTapSessionList[0] else { return }
            tapSession.tipList.append(newTip) // update of running tapSession
            tapSession.lastTip = newTip
            
            tapSession.endTimer() // Timer restart
            tapSession.startTimer()
            
        }
        
    }





