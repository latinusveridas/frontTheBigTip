//
//  AppDelegate.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 23/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import UIKit

let sharedpreviewData = sharedPreviewData.shared
let shareduserData = sharedUserData.shared
let sharedAPITapSessions = sharedTapSessionAPI.shared

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
               
        // Preview List initialization
        SharedPreviewData.getPreviewList()
        SharedPreviewData.cacheAllThumbnails()
        
        // Current user initialization
        SharedUserData.getCurrentUser()
        
        // Fetching TapSessions from API
        sharedAPITapSessions.getTapSessionList()
                
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

