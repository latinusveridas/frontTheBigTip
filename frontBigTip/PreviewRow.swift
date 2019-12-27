//
//  ContentView.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 23/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import SwiftUI

struct PreviewRow: View {
    var preview: Preview
    
    var body: some View {
        HStack {
            preview.thumbnailImage
            .resizable()
            .frame(width: 50, height: 50)
            Text(preview.authorName)
            Spacer()
        }
    }
}

struct PreviewRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        PreviewRow(preview: previewData[0])    
        PreviewRow(preview: previewData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
        
    }
}


