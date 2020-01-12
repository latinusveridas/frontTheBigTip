//
//  GridRow.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 29/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI

struct PreviewRow : View {
    var tipVideo: TipVideo
    
    let sharedThumbCache = sharedtipVideoData.ThumbnailCache
    
    var body: some View {
        HStack {
            Image(uiImage:
                sharedThumbCache.object(forKey: tipVideo.tipVideoId as NSString)!)
                .resizable()
                .frame(width: 50, height: 50)
            Text(tipVideo.tipVideoId)
        }
    }
    
}

struct PreviewRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        PreviewRow(tipVideo: tipVideoList[0])
        }

            .previewLayout(.fixed(width: 300, height: 70))
    }
}
