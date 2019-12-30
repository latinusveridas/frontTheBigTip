//
//  DataProcessing.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class sharedPreviewData {
/* This class represent the fetched Preview data */
/* Type method are used as we do not instance an object, we directly use the type property */
    
    static var PreviewList: [Preview?] = []
    static var ThumbnailCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    static func getPreviewList() {
        let data = loadJSONfile(url: "previewData")
        let previewList = parsingJSONtoListPreview(data: data)
        
        self.PreviewList.removeAll()
        self.PreviewList = previewList
    }
    
    static func cacheAllThumbnails() {
        let cacheThumbnails = NSCache<NSString, UIImage>()
        cacheThumbnails.name = "Preview Thumbnails Cache"
        
        for preview in self.PreviewList {
            preview!.cacheThumbnailImage(cache: cacheThumbnails)
        }
        
        self.ThumbnailCache.removeAllObjects()
        self.ThumbnailCache = cacheThumbnails
            
    }
    
    fileprivate static func loadJSONfile(url: String) -> Data {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        return data
    }
    
    fileprivate static func parsingJSONtoListPreview(data: Data) -> [Preview?] {
    /* Serialize JSON to List of Preview objects */
        
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let previewsList = try? decoder.decode([Preview].self, from: data) else { fatalError("Impossible to parse Json to Preview")}
            return previewsList
    }
    
}
