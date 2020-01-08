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
    var preview: Preview
    
    let sharedThumbCache = sharedpreviewData.ThumbnailCache
    
    var body: some View {
        HStack {
            Image(uiImage:
                sharedThumbCache.object(forKey: preview.previewId as NSString)!)
                .resizable()
                .frame(width: 50, height: 50)
            Text(preview.authorName)
        }
    }
    
}

struct PreviewRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        PreviewRow(preview: previewList[0])
        //PreviewRow(preview: previewList[1]!)
        }

            .previewLayout(.fixed(width: 300, height: 70))
    }
}
