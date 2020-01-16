//
//  TipVideo.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI

class TipVideo: Codable, Hashable {
/* Represent a video object */

    // Static data
    var tipVideoId: String!
    var authorId: String!
    var authorName: String!
    var maxTipNb: Int! // Represent the maximum nb of tips a user can give
    var priceTip: Int! // Represent the price of 1 tip
    
    // Preview
    var thumbnailLink: String!
    var thumbnailImageData: Data?

    // Variable data
    var tipNb: Int! // Represent the current nb of tips a user gave

    // Aggregated data, e.g. total calculations
    var tipsList: [Tip?] // Represent the total nb of tips, all users included
    var totalTipsNb: Int! { tipsList.count }
    var totalIncome: Double! { Double(totalTipsNb * priceTip) }
    
    // Video data
    var tipVideoRemoteLink: String!
    var tipVideoLocalLink: String?
    var maxSize: Double!
    var currentSize: Double!

    init(tipVideoId: String, tipNb: Int, authorName: String, authorId: String, maxTip: Int, priceTip: Int, tipsList: [Tip?], maxSize: Double, currentSize: Double) {
        self.tipVideoId = tipVideoId
        self.authorName = authorName
        self.authorId = authorId
        self.tipNb = tipNb
        self.maxTipNb = maxTip
        self.priceTip = priceTip
        self.tipsList = tipsList
        self.maxSize = maxSize
        self.currentSize = currentSize
    }


    
}

extension TipVideo {
    
    // Hashing functions to plug to SwiftUI
    func hash(into hasher: inout Hasher) {
        return hasher.combine(tipVideoId)
    }
    
    static func == (lhs: TipVideo, rhs: TipVideo) -> Bool {
        return lhs.tipVideoId == rhs.tipVideoId
    }
    
    private func generateId() -> String {
    /* ID structure is TP_authorId_randomNb */
        return "test"
    }
    
    // MARK: - Image Management
    
    func thumbnailDataToImage() -> UIImage? {
        guard let imageData = self.thumbnailImageData else { return nil }
        let image = UIImage(data: imageData)
        return image
    }
    
    func setThumbnailImageToCache(cache: NSCache<NSString, UIImage>) {
    /* Caching image from Thumbnail Link and load it in a NSCache parameter */
    
        let link = thumbnailLink
        guard let url = Bundle.main.url(forResource: link, withExtension: "png") else {
            print("Thumbnail link not found !!! \(String(describing: link))")
            return
        }
        guard let data = try? Data(contentsOf: url) else { fatalError("☠️") }
        
        guard let img = UIImage(data: data) else {
            print("Image has not been loaded")
            return
        }
        cache.setObject(img, forKey: self.tipVideoId as NSString)
    }
    
    // MARK: - Video Management
    
    func downloadTipVideo() {
        guard let remoteLink = self.tipVideoRemoteLink else {  }
     
    }
    
    func getTipVideo() -> String! {
        guard let localLink = self.tipVideoLocalLink else { 
        // File is not downloaded, launch download
            downloadTipVideo()
        }
        
        // Check if file exists
        let fileManager = FileManager.default()
        
        if !fileExists(atPath path: link) {
            // File does not exists so download
            downloadTipVideo()
        } else {
            return localLink
        }
        
    }
    
}
