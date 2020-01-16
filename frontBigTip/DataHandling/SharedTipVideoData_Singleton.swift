//
//  DataProcessing.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class SharedTipVideoData {
/* This class represent the fetched Preview data */
/* Type method are used as we do not instance an object, we directly use the type property */
    
    var TipVideoDict: [String:TipVideo] = [:]
    var ThumbnailCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    static let shared = SharedTipVideoData()
    private init() {    }
    
    func getPreviewList() {
        let data = loadJSONfile(url: "Public_TipVideos_Launch")
        let previewDict = parsingJSONtoTipVideoDict(data: data)
        
        self.TipVideoDict.removeAll()
        self.TipVideoDict = previewDict
    }
    
    func cacheAllThumbnails() {
        let cacheThumbnails = NSCache<NSString, UIImage>()
        cacheThumbnails.name = "TipVideos Thumbnails Cache"
        
        for (_, tipVideo) in TipVideoDict {
            tipVideo.setThumbnailImageToCache(cache: cacheThumbnails)
        }
        
        self.ThumbnailCache.removeAllObjects()
        self.ThumbnailCache = cacheThumbnails
        print("Thumbnail Cache loaded !")
            
    }
    
    func RectifyWithLocalStoredData() {
        let storedData: [String : StoredVideo]  = StoredData.shared.fetchDictionnary()
        for (sharedId, sharedTipVideo) in self.TipVideoDict {
            for (storedId, storedVideo) in storedData {
                if sharedId == storedId {
                    sharedTipVideo.tipVideoLocalLink = storedVideo.tipVideoLocalLink
                } else { // Do Nothing}
            }
        }
    }
}

extension SharedTipVideoData {

    fileprivate func loadJSONfile(url: String) -> Data {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        return data
    }
    
    fileprivate func parsingJSONtoTipVideoDict(data: Data) -> [String:TipVideo] {
    /* Serialize JSON to List of Preview objects */
                    
        var tempDict: [String:TipVideo] = [:]
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let tipVideoList = try decoder.decode([TipVideo].self, from: data)
            
            tipVideoList.forEach { item in
                tempDict[item.tipVideoId] = item
            }
            
            print("TipVideos successfully loaded :)")
            return tempDict
        } catch  {
            
            print(error)
            fatalError()
        }
    }    
    
}