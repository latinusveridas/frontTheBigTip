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
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(data: preview.thumbnailImageData))
                .resizable()
                .frame(width: 50, height: 50)
            Text(preview.authorName)
        }
    }
    
}
