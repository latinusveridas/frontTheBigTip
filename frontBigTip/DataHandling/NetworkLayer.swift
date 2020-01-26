//
//  NetworkLayer.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

class BigTipAPI {
        
    enum FilterMode {
            .relevancy
            .tailored
    }
    
    
    func downloadTipsVideos(_ paginationSkip: Int,_ paginationFirst: Int, filterMode: FilterMode ) {
            
    }
    
    func downloadThumbnails(tipVideos: [TipVideo]) {
            
            
    }
    
    func downloadTipVideo(tipVideo: TipVideo) {
            
            
    }
    
    
        
        
        
}























// AF.request(url, headers).responseJSON { response in
//     guard response.result.isSuccess, let value = response.result.value as? [String : Any] else {
//         print("Error \(String(describing: response.result.error))")
//         return
//     }
// }
        