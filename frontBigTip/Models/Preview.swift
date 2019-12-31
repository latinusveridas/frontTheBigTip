//
//  Preview.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

struct Preview: Codable, Hashable {
/* Represent a thumbnailLink object */
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(previewId)
    }
    
    // Static data
    var previewId: String
    var authorId: String // Common w/ TipVideo
    var authorName: String // Common w/ TipVideo
    
    var thumbnailLink: String
    var thumbnailImageData: Data?
    
    weak var tipVideo: TipVideo?
    
    // Variable data
    var tipNb: Int // Common w/ TipVideo
    var priceTip: Int // Common w/ TipVideo
    
    init(previewId: String, authorId: String, authorName: String, thumbnailLink: String, thumbnailImage: UIImage?, tipVideo: TipVideo?, tipNb: Int, priceTip: Int) {
        self.previewId = previewId
        self.authorId = authorId
        self.authorName = authorName
        self.thumbnailLink = thumbnailLink
        self.tipNb = tipNb
        self.priceTip = priceTip
        self.tipVideo = tipVideo
        self.thumbnailImageData = thumbnailImage?.pngData()
    }
    
    func thumbnailDataToImage() -> UIImage? {
        guard let imageData = self.thumbnailImageData else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
    
    func setThumbnailImageToCache(cache: NSCache<NSString, UIImage>) {
    /* Caching image from Thumbnail Link and load it in a NSCache parameter */
    
        let link = self.thumbnailLink
        guard let url = Bundle.main.url(forResource: link, withExtension: "png") else {
            print("URL not found")
            return
        }
        guard let data = try? Data(contentsOf: url) else { fatalError("☠️") }
        
        guard let img = UIImage(data: data) else {
            print("Image has not been loaded")
            return
        }
        cache.setObject(img, forKey: self.previewId as NSString)
    }
    
    func downloadThumbnailImage() {
    /* Caching image from URL */
    
    }
    
    mutating func updatethumbnailLink(newLink: String) {
        self.thumbnailLink = newLink
    }
    
    private func generateId() -> String {
        return "test"
    }
}
