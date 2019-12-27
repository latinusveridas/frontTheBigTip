//
//  PreviewList.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 26/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI

struct PreviewList: View {
    var body: some View {
        List(previewData, id: \.previewId) { preview in
            PreviewRow(preview: preview)
        }
    }
}

struct PreviewList_Previews: PreviewProvider {
    static var previews: some View {
        PreviewList()
    }
}