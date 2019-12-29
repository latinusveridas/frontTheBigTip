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

    static var previewList: [Preview?] = {
        guard let data = loadJSONfile(url: "previewData") else {
            print("No data loaded")
            return []
        }
        let previewList = ParsingJSONtoListPreview(data: data)
        print(previewList)
        
        return previewList
    } ()
    
    let cacheThumbnails: NSCache<NSString, UIImage> = {
        let cacheThumbnails = NSCache<NSString, UIImage>()
        cacheThumbnails.name = "Preview Thumbnails Cache"
        
        for preview in previewList {
            preview!.loadThumbnailImage(cache: cacheThumbnails)
        }
        
        return cacheThumbnails
            
    } ()
    
    fileprivate static func loadJSONfile(url: String) -> Data? {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("☠️") }
        return data
    }
    
    fileprivate static func ParsingJSONtoListPreview(data: Data) -> [Preview?] {
    /* Serialize JSON to List of Preview objects */
        
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let previewsList = try? decoder.decode([Preview].self, from: data) else { fatalError("Impossible to parse Json to Preview")}
            return previewsList
    }

}
