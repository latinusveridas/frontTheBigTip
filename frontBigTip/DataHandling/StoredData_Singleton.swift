//
//  StoredData_Singleton.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 09/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class SharedStoredData {
/* This class represent the shared stored TipVideos Links */
/* Type method are used as we do not instance an object, we directly use the type property */

    let defaults = UserDefaults.standard

    static let shared = SharedStoredData()
    private init() {    }
    
    func fetchDictionnary() -> [String : StoredVideo] {
        guard let dataDict = defaults.object(forKey: "storedTipVideoLinks") as? Data else { return [:] }
        if let decodedData = JSONDecoder().decode([String:StoredVideo], from: dataDict) {
            return decodedData    
        } else {
            return [:]
        }
        
    }
    
    func storeTipVideoLink_Auto(tipVideo: TipVideo) {
        let storedVideo = StoredVideo(tipVideo.tipVideoId,tipVideo.tipVideoLocalLink!, "Automatic")
        var storedData = fetchDictionnary()
        storedData[tipVideo.tipVideoId] = storedVideo
        let encodedData = JSONEncoder().encode(storedData)
        defaults.set(encodedData, forKey: "storedTipVideoLinks")
    }
    
    func storeTipVideoLink_Manual(tipVideo: TipVideo) {
        let storedVideo = StoredVideo(tipVideo.tipVideoId,tipVideo.tipVideoLocalLink!, "Manual")
        var storedData = fetchDictionnary()
        storedData[tipVideo.tipVideoId] = storedVideo
        let encodedData = JSONEncoder().encode(storedData)
        defaults.set(encodedData, forKey: "storedTipVideoLinks")
    }
    
    func removeTipVideoLink(tipVideo: TipVideo) {
        var storedData = fetchDictionnary()
        storedData.removeValue(forKey: tipVideo.tipVideoId)
        let encodedData = JSONEncoder().encode(storedData)
        defaults.set(encodedData, forKey: "storedTipVideoLinks")
    }
    
}

class StoredVideo: Codable {
    
    var tipVideoId: String!
    var tipVideoLocalLink: String!
    var mode: String!
    
//    enum Mode: String, Codable {
//        case Manual
//        case Automatic
//    }
    
    init(_ tipVideoId: String,_ tipVideoLocalLink: String,_ mode: String) {
        self.tipVideoId = tipVideoId
        self.tipVideoLocalLink = tipVideoLocalLink
        self.mode = mode
    }
    
}

///MARK: Additional classes, as File Management
    
class TipFileManagement {
/*
 * All data stored is stored in a specific folder called BigTip
 * The automaticaly downloaded videos are saved in a subfolder called "cache"
 * The manually downloaded videos are saved in a subfolder called "user"
 *
 */
    func readFolder() {
    // Read the content of the folder and return a list of the content
    
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        do {
        
            let items = try fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                print("Found \(item)")
            }
        } catch let error as NSError  {
            print(“Unable to read directory”,error)
        }
    }
    
    func createFolder() {
    // Create a folder
    
    let userDir = FileManager.default.homeDirectoryForCurrentUser
    let path = Bundle.main.resourcePath!
    
    do {
        try fm.createDirectory(atPath: logsPath!.path, withIntermediateDirectories: true, attributes: nil)
    
    } catch let error as NSError{
    print(“Unable to create directory”,error)
    }
    
    }
    
}
    
    