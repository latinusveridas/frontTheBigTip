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
/* Sync are manual and/or automatic */
    
    var SyncTimer = Timer()
    var countdown : Double
    
    static var shared = AccountStatementManagement()
    private init() {
        self.countdown = 15.00
    }

    /* AUTOMATIC SYNCHRONIZATION */
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
    
    /* MANUAL SYNCHRONIZATION */
    func syncAccountEventssWithApi() {
        // 0. Get API Account Object
        var APIAccount: Account = fetchAPIAccount()
    
        // 1. Sync RefillList to increase account
        
        
    }
    
    func fetchAPIAccount() -> Account {
        let url = Bundle.main.url(forResource: "DRAFTAPIAccountStatement", withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let account = try? decoder.decode(Account.self, from: data) else { fatalError("Impossible to parse Json to Preview")}
        return account
    }
    
    func testRefillArrays(array1: [refillList], array2: [refillList])
    
    
}
