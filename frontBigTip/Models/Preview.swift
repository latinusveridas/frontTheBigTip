//
//  Preview.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class Preview: Codable, Hashable {
/* Represent a thumbnailLink object */
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(previewId)
    }
    
    static func == (lhs: Preview, rhs: Preview) -> Bool {
        return lhs.previewId == rhs.previewId
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
    var maxTipNb: Int // Represent the maximum nb of tips a user can give | Common w/ TipVideo
    
    init(previewId: String, authorId: String, authorName: String, thumbnailLink: String, thumbnailImage: UIImage?, tipVideo: TipVideo?, tipNb: Int, maxTipNb: Int) {
        self.previewId = previewId
        self.authorId = authorId
        self.authorName = authorName
        self.thumbnailLink = thumbnailLink
        self.tipNb = tipNb
        self.maxTipNb = maxTipNb
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
    
        let link = thumbnailLink
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
    
    func updatethumbnailLink(newLink: String) {
        thumbnailLink = newLink
    }
    
    private func generateId() -> String {
        return "test"
    }
}
