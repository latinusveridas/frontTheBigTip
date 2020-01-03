//
//  AccountStatement.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class AccountEvent {
    
}

class AccountDrawdown: AccountEvent {
    
    // Static Data
    var accountStatementId: String!
    weak var user: User!
    
    // Variable Data
    var TapSessionList: [TapSession?]
    
    init(accountStatementId: String, user: User) {
        self.accountStatementId = accountStatementId
        self.user = user
    }
    
    
}

class AccountStatementManagement {
/* Manage the synchronisation of the local Account Statements and the API */    
    
    static var shared = AccountStatementManagement()
    private init() {}
    
    var SyncTimer: Timer()
    
    var LocalAccountStatement = [AccountStatement?]
    var APIAccountStatement = [AccountStatement?]

    func startTimer() {
        self.SyncTimer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
    // Function called each second, and perform the assessment
         if seconds < self.countdown {
          self.SyncTimer.invalidate()
          
         } else {
              self.countdown -= 1
         }
     
    }
    
    func endTimer() {
        self.timer.invalidate()
    }    
    
    func syncAccountEventssWithApi() {
        
    }
    
    
}