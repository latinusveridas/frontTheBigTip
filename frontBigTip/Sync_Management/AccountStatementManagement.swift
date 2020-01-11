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
    
        var bucketDDnewInAPI: [AccountDrawdown?]
        var bucketDDnewInLocal: [AccountDrawdown?]
        var bucketDDcommon: [AccountDrawdown?]
        
        var bucketRnewInAPI: [AccountRefill?]
        var bucketRnewInLocal: [AccountRefill?]
        var bucketRcommon: [AccountRefill?]
    
        // 0. Get API Account Object
        let apiAccount: Account = fetchAPIAccount()
        let userAccount: Account = SharedAccount.shared.account!
    
        // 1. Sync RefillList to increase account
        let RefillResult = CompareArrays(APIarray: apiAccount.refillList, Localarray: userAccount.refillList)
        bucketRnewInAPI = RefillResult.bucketNewInAPI
        bucketRnewInLocal = RefillResult.bucketNewInLocal
        bucketRcommon = RefillResult.bucketCommon
        
        // 2. Sync Drawdown to decrease account
        let DrawDownResult = CompareArrays(APIarray: apiAccount.drawdownList, Localarray: userAccount.drawdownList)
        bucketDDnewInAPI = DrawDownResult.bucketNewInAPI
        bucketDDnewInLocal = DrawDownResult.bucketNewInLocal
        bucketDDcommon = DrawDownResult.bucketCommon
        
        // 3. Update local data
        userAccount.refillList = userAccount.refillList + bucketRnewInAPI
        
        // 4. Update API data
        
        
    }
    
    func fetchAPIAccount() -> Account {
        let url = Bundle.main.url(forResource: "Account_API_Statement", withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let account = try? decoder.decode(Account.self, from: data) else { fatalError("Impossible to parse Json to Preview")}
        return account
    }
    
    func CompareArrays<T: Equatable>(APIarray: [T], Localarray: [T]) -> (bucketNewInAPI: [T], bucketNewInLocal: [T], bucketCommon: [T]) {
    
        var bucketNewInAPI: [T] = []
        var bucketNewInLocal: [T] = []
        var bucketCommon:  [T] = []
    
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
    
    func RefreshAPIaccount(refillList: [AccountRefill?]!, drawdownList: [AccountDrawdown?]!) {
        
    }
    
    
}
