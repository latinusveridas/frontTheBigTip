//
//  GridPresentation.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 26/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI

let previewDict = sharedpreviewData.PreviewDict
let previewList = previewDict.map{$0.value}

struct PreviewPresentation: View {

    var body: some View {
        
        NavigationView {
            
            List(previewList, id: \.self) { elem in
                HStack {
                    PreviewRow(preview: elem)
                }
            }
            
        }
    }
}


struct PreviewPresentation_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            PreviewPresentation()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
