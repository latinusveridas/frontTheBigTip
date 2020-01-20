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
        guard let dataDict = defaults.object(forKey: "storedTipVideoLinks") as? [String : StoredVideo] else { return [:] }
        return dataDict
    }
    
    func storeTipVideoLink_Auto(tipVideo: TipVideo) {
        let storedVideo = StoredVideo(tipVideo.tipVideoId,tipVideo.tipVideoLocalLink!, "Automatic")
        var storedData = fetchDictionnary()
        storedData[tipVideo.tipVideoId] = storedVideo
        defaults.set(storedData, forKey: "storedTipVideoLinks")
    }
    
    func storeTipVideoLink_Manual(tipVideo: TipVideo) {
        let storedVideo = StoredVideo(tipVideo.tipVideoId,tipVideo.tipVideoLocalLink!, "Manual")
        var storedData = fetchDictionnary()
        storedData[tipVideo.tipVideoId] = storedVideo
        defaults.set(storedData, forKey: "storedTipVideoLinks")
    }
    
    func removeTipVideoLink(tipVideo: TipVideo) {
        var storedData = fetchDictionnary()
        storedData.removeValue(forKey: tipVideo.tipVideoId)
        defaults.set(storedData, forKey: "storedTipVideoLinks")
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
