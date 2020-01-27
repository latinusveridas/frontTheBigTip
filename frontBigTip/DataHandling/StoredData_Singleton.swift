//
//  StoredData_Singleton.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 09/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SharedStoredData {
/* This class represent the shared stored TipVideos Links */
/* Type method are used as we do not instance an object, we directly use the type property */

    let defaults = UserDefaults.standard

    static let shared = SharedStoredData()
    private init() {    }
    
    func fetchDictionnary() -> [String : StoredVideo] {
        guard let dataDict = defaults.object(forKey: "storedTipVideoLinks") as? Data else { return [:] }
        if let decodedData = try! JSONDecoder().decode([String:StoredVideo]?.self, from: dataDict) {
            return decodedData    
        } else {
            return [:]
        }
        
    }
    
    func storeTipVideoLink_Auto(tipVideo: TipVideo) {
        let storedVideo = StoredVideo(tipVideo.tipVideoId,tipVideo.tipVideoLocalLink!, "Automatic")
        var storedData = fetchDictionnary()
        storedData[tipVideo.tipVideoId] = storedVideo
        let encodedData = try!  JSONEncoder().encode(storedData)
        defaults.set(encodedData, forKey: "storedTipVideoLinks")
    }
    
    func storeTipVideoLink_Manual(tipVideo: TipVideo) {
        let storedVideo = StoredVideo(tipVideo.tipVideoId,tipVideo.tipVideoLocalLink!, "Manual")
        var storedData = fetchDictionnary()
        storedData[tipVideo.tipVideoId] = storedVideo
        let encodedData = try! JSONEncoder().encode(storedData)
        defaults.set(encodedData, forKey: "storedTipVideoLinks")
    }
    
    func removeTipVideoLink(tipVideo: TipVideo) {
        var storedData = fetchDictionnary()
        storedData.removeValue(forKey: tipVideo.tipVideoId)
        let encodedData = try! JSONEncoder().encode(storedData)
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

// MARK: Additional classes, as File Management
    
class TipFileManagement {
/*
 * All data stored is stored in a specific folder called BigTip
 * The automaticaly downloaded videos are saved in a subfolder called "cache"
 * The manually downloaded videos are saved in a subfolder called "user"
 *
 */
    
    let root = "BigTip"
    let auto = "cache"
    let user = "user"
    
    enum Mode {
        case automatic
        case manual
    }
    
    func checkItemsInTheDirectory(mode: Mode) {
    // Read the content of the folder and return a list of the content
        let fm = FileManager.default
        let docsFolder = try! fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let rootURL = docsFolder.appendingPathComponent(root)
        
        switch mode {
        case .automatic:
            let autoURL = rootURL.appendingPathComponent(auto)
            let fileURLs = try? fm.contentsOfDirectory(at: autoURL, includingPropertiesForKeys: nil)
            fileURLs?.forEach { item in
                print(item)
            }
        case .manual:
            let userURL = rootURL.appendingPathComponent(user)
            let fileURLs = try? fm.contentsOfDirectory(at: userURL, includingPropertiesForKeys: nil)
            fileURLs?.forEach { item in
                print(item)
            }
        }
    }
    
    func checkFoldersStructure() {
        let fileManager = FileManager.default
        let documentsFolder = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        // Testing root folder
        let rootURL = documentsFolder.appendingPathComponent(root) // Returns an URL
        let rootExists: Bool = (try? rootURL.checkResourceIsReachable()) ?? false
        
        print("Root exists ?: \(rootExists)")
        
        do {
            if !rootExists {
            // Setup of root + two sub folders
                try fileManager.createDirectory(at: rootURL, withIntermediateDirectories: false)
                
                let autoURL = rootURL.appendingPathComponent(auto)
                try fileManager.createDirectory(at: autoURL, withIntermediateDirectories: false)
                
                let userURL = rootURL.appendingPathComponent(user)
                try fileManager.createDirectory(at: userURL, withIntermediateDirectories: false)
                
                print("autoURL exists ?: \(String(describing: try? autoURL.checkResourceIsReachable())) | userURL exists ?: \(String(describing: try? userURL.checkResourceIsReachable()))")
                
            } else {
            // Setup only sub folders
                let autoURL = rootURL.appendingPathComponent(auto)
                let userURL = rootURL.appendingPathComponent(user)
                
                if (try? autoURL.checkResourceIsReachable()) == false {
                    try fileManager.createDirectory(at: autoURL, withIntermediateDirectories: false)
                }
                
                if (try? userURL.checkResourceIsReachable()) == false {
                    try fileManager.createDirectory(at: userURL, withIntermediateDirectories: false)
                }
                
                print("autoURL exists ?: \(try autoURL.checkResourceIsReachable()) | userURL exists ?: \(try userURL.checkResourceIsReachable())")
                
            }
        } catch { print(error) }
    }
    
    func writeDataToFile(data: Data!, fileName: String!, folderMode: Mode) {
    
        let newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let rootURL = newURL.appendingPathComponent(root)
        
        do {
        
            switch folderMode {
            
            case .automatic:
                let targetURL = rootURL.appendingPathComponent(auto)
                try data.write(to: targetURL)
            
            case .manual:
                let targetURL = rootURL.appendingPathComponent(user)
                try data.write(to: targetURL)
                
            }
            
        } catch {
            print(error)
        }
            
    }
    
    func getFileURL(fileName: String!, mode: Mode) -> URL? {
    
        let newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let rootURL = newURL.appendingPathComponent(root)
               
            switch mode {
            
            case .automatic:
                let modeURL = rootURL.appendingPathComponent(auto)
                let targetURL = modeURL.appendingPathComponent(fileName)
                if (try? targetURL.checkResourceIsReachable()) == true {
                    return targetURL
                }
                
            
            case .manual :
                let modeURL = rootURL.appendingPathComponent(user)
                let targetURL = modeURL.appendingPathComponent(fileName)
                if (try? targetURL.checkResourceIsReachable()) == true {
                    return targetURL
                }
                
            }

        return URL(fileURLWithPath: "")
        
    }
    
}
    
    
