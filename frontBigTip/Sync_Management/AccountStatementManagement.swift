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
    
    var bucketDDnewInAPI: [Drawdown?]
    var bucketDDnewInLocal: [Drawdown?]
    var bucketDDcommon: [Drawdown?]
    
    var bucketRnewInAPI: [Refill?]
    var bucketRnewInLocal: [Refill?]
    var bucketRcommon: [Refill?]
    
        // 0. Get API Account Object
        var apiAccount: Account = fetchAPIAccount()
        var userAccount: Account = shareduserData.currentUser!
    
        // 1. Sync RefillList to increase account
        let RefillResult = CompareArrays(APIarray: apiAccount.refillList, Localarray: userAccount.refillList)
        bucketRnewInAPI = RefillResult.bucketNewInAPI
        bucketRnewInLocal = RefillResult.bucketNewInLocal
        bucketRcommon = RefillList.bucketCommon
        
        // 2. Sync Drawdown to decrease account
        let DrawDownResult = CompareArrays(APIarray: apiAccount.drawdownList, Localarray: userAccount.drawdownList)
        bucketRnewInAPI = DrawDownResult.bucketNewInAPI
        bucketRnewInLocal = DrawDownResult.bucketNewInLocal
        bucketRcommon = DrawDownResult.bucketCommon
        
        // 3. Update local data
        userAccount.refillList = userAccount.refillList + bucketRnewInAPI
        
        // 4. Update API data
        
        
    }
    
    func FetchAPIAccount() -> Account {
        let url = Bundle.main.url(forResource: "APIAccountStatement", withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let account = try? decoder.decode(Account.self, from: data) else { fatalError("Impossible to parse Json to Preview")}
        return account
    }
    
    func CompareArrays(APIarray: [], Localarray: []) -> (bucketNewInAPI: [], bucketNewInLocal: [], bucketCommon: []) {
    
    var bucketNewInAPI = []
    var bucketNewInLocal = []
    var bucketCommon = []
    
        APIarray.forEach { 
            if Localarray.contains($0) {
                bucketCommon.append($0)
            } else {
                bucketNewInAPI.append($0)
            }
        }
        Localarray.forEach {
            if APIarray.contains($0) {
                // Do nothing, bucketCommon already populated
            } else {
                bucketNewInLocal.append($0)
            }
        }
        
        return (bucketNewInAPI, bucketNewInLocal, bucketCommon)
    }
    
    func RefreshAPIaccount(refillList: [Refill?]!, drawdownList: [Drawdown?]!) {
        
    }
    
    
}
