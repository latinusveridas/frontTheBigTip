//
//  Preview.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation

struct Preview: Codable {
/* Represent a thumbnailLink object */

    // Static data
    var previewId: String
    var authorId: String // Common w/ TipVideo
    var authorName: String // Common w/ TipVideo
    var thumbnailLink: String
    var thumbnailImage: Image?
    var tipVideo: TipVideo
    
    // Variable data
    var tipNb: Int // Common w/ TipVideo
    var priceTip: Int // Common w/ TipVideo
    
    init(previewId: String, authorId: String, authorName: String, thumbnailLink: String, tipVideo: TipVideo, tipNb: Int, priceTip: Int) {
        self.previewId = previewId
        self.authorId = authorId
        self.authorName = authorName
        self.thumbnailLink = thumbnailLink
        self.tipVideo = TipVideo
        self.tipNb = tipNb
        self.priceTip = priceTip
    }
    
    func loadThumbnailImage(cache: NSCache) {
    /* Caching image from bundle */
    
        let link = self.thumbnailLink
        guard let url = Bundle.main.url(forResource: link, withExtension: "png") else { print("URL not found")}
        guard let data = try! Data(contentsOf: url, using: .utf8) else { fatalError("☠️") }
        
        guard let img = UIImage(data: data) else { print("Image has not been loaded") }
        cache.setObject(img, forKey: self.previewId)
    }
    
    func downloadThumbnailImage() {
    /* Caching image from URL */
    
    }
    
    func updatethumbnailLink(newLink: String) {
        self.thumbnailLink = newLink
    }
    
    private func generateId() -> String {
        return "test"
    }
}