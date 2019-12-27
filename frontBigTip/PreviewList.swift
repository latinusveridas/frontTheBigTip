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
        List {
            PreviewRow(preview: previewData[0])
            PreviewRow(preview: previewData[1])
        }
    }
}
