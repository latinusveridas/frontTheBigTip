//
//  DataProcessing.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class SharedPreviewData {
/* This class represent the fetched Preview data */
/* Type method are used as we do not instance an object, we directly use the type property */
    
    var PreviewDict: [String:Preview] = [:]
    var ThumbnailCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    static let shared = SharedPreviewData()
    private init() {    }
    
    func getPreviewList() {
        let data = loadJSONfile(url: "Public_Preview_Launch")
        let previewDict = parsingJSONtoPreviewDict(data: data)
        
        self.PreviewDict.removeAll()
        self.PreviewDict = previewDict
    }
    
    func cacheAllThumbnails() {
        let cacheThumbnails = NSCache<NSString, UIImage>()
        cacheThumbnails.name = "Preview Thumbnails Cache"
        
        for (_, preview) in PreviewDict {
            preview.setThumbnailImageToCache(cache: cacheThumbnails)
        }
        
        self.ThumbnailCache.removeAllObjects()
        self.ThumbnailCache = cacheThumbnails
        print("Thumbnail Cache loaded !")
            
    }
    
    fileprivate func loadJSONfile(url: String) -> Data {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        return data
    }
    
    fileprivate func parsingJSONtoPreviewDict(data: Data) -> [String:Preview] {
    /* Serialize JSON to List of Preview objects */
            
            var tempDict: [String:Preview] = [:]
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let previewList = try? decoder.decode([Preview].self, from: data) else { fatalError("Impossible to parse Json to Preview")}
            previewList.forEach { item in 
                tempDict[item.previewId] = item
            }
            return tempDict
    }
    
}
