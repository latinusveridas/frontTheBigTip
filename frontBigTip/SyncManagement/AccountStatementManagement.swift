//
//  AccountStatementManagement.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 04/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class AccountStatementManagement {
/* Manage the synchronisation of the local Account Statements and the API */
    
    var SyncTimer = Timer()
    var countdown : Double
    
    var LocalAccountStatement: [AccountDrawdown?] = []
    var APIAccountStatement: [AccountDrawdown?] = []
    
    static var shared = AccountStatementManagement()
    private init() {
        self.countdown = 60.00
    }

    func startTimer() {
        SyncTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
    // Function called each second, and perform the assessment
         if countdown < 1 {
            SyncTimer.invalidate()
            // PLACEHOLDER Function to Sync
            startTimer()
         } else {
          countdown -= 1
         }
     
    }
    
    func endTimer() {
        SyncTimer.invalidate()
    }
    
    func syncAccountEventssWithApi() {
        
        
        
    }
    
    
}
