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
    
    var body: some View {

        List {
            GridRow(preview: XXXX)
        }
                
    }
        
    
}

struct GridPresentation_Previews: PreviewProvider {
    static var previews: some View {
        GridPresentation()
    }
}
