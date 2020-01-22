//
//  AppDelegate.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 23/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import UIKit

let sharedtipVideoData = SharedTipVideoData.shared
let sharedUserData = SharedUserData.shared
let sharedAccountData = SharedAccount.shared

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
               
        // Preview List initialization
        sharedtipVideoData.getPreviewList()
        sharedtipVideoData.cacheAllThumbnails()
        
        // Current user initialization
        sharedUserData.getCurrentUser()
        
        // Account initialization
        sharedAccountData.getAccountStatement(url: "Account_State_Launch")
        
        // Testing Account update, we update refillList
        print("On start, nb of refills is \(sharedAccountData.account!.refillList.count)")
        
        // Testing account sync
        AccountStatementManagement.shared.syncAccountEventssWithApi()
        print("After sync, nb of refills is \(sharedAccountData.account!.refillList.count)")
        
        // Testing Stored Data
        let storeTest = Debug_DataStoredInit.shared
        storeTest.writeDogVideoInAutomatic()
        
        // Testing File Management
        TipFileManagement().checkFoldersStructure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

