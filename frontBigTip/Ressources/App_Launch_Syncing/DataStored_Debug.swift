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
        
        let encodedData = try! JSONEncoder().encode(storedData)
        
        sharedDataStore.defaults.set(encodedData, forKey: "storedTipVideoLinks")
        
        // Get Dog Local Video
        let dict = sharedDataStore.fetchDictionnary()
        for (id, _) in dict {
            print(id)
        }
    }
    
    func writeDogVideoInAutomatic() {
        
        let videoURL = Bundle.main.url(forResource: "dog", withExtension: "mp4")!
        do {
            let rawData = try Data(contentsOf: videoURL)
            
            let newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                .appendingPathComponent("BigTip")
                .appendingPathComponent("auto")
                .appendingPathComponent("TheNewVideo.mp4")
            
            try rawData.write(to: newURL)
            
        } catch {
            print(error)
        }
        
        
    }
    
    
    
}
