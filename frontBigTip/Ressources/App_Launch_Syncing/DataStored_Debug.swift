//
//  DataStored_Debug.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 19/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

class Debug_DataStoredInit {
    
    static let shared = Debug_DataStoredInit()
    private init() {
    
        // Set Dog Local Video
        
        let storedVideo = StoredVideo("dogTipVideoId", "dog", "Automatic")
        
        let sharedDataStore = SharedStoredData.shared
        
        var storedData = sharedDataStore.fetchDictionnary()
        
        print("Current number of elements in the storedTipVideoLinks dictionnary: \(storedData.count)")
        
        storedData["dogTipVideoId"] = storedVideo
        
        print("Current number of elements in the storedTipVideoLinks dictionnary: \(storedData.count)")
        
        let encodedData = JSONEncoder().encode(storedData)
        
        sharedDataStore.defaults.set(encodedData, forKey: "storedTipVideoLinks")
        
        // Get Dog Local Video
        let dict = sharedDataStore.fetchDictionnary()
        for (id, _) in dict {
            print(id)
        }
    }
    
    
    
}
