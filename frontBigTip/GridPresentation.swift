//
//  GridPresentation.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 26/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI

let previewList = sharedPreviewData.PreviewList



struct GridPresentation: View {
    
    //previewId: String, authorId: String, authorName: String, thumbnailLink: String, thumbnailImage: UIImage?, tipVideo: TipVideo?, tipNb: Int, priceTip: Int)
    
    let prev1 = Preview(previewId: "x1", authorId: "x", authorName: "x", thumbnailLink: "x", thumbnailImage: nil, tipVideo: nil, tipNb: 01, priceTip: 02)

    let prev2 = Preview(previewId: "x2", authorId: "x", authorName: "x", thumbnailLink: "x", thumbnailImage: nil, tipVideo: nil, tipNb: 01, priceTip: 02)
    
    let NewList = [prev1,prev2]
    
    var body: some View {

        List(previewList, id: \.id ) { previewElem in
            HStack {
                
            }
        }
                
    }
        
    
}

struct GridPresentation_Previews: PreviewProvider {
    static var previews: some View {
        GridPresentation()
    }
}
