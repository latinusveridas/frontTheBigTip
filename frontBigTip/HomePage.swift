//
//  GridPresentation.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 26/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI

let tipVideoDict = sharedtipVideoData.TipVideoDict
let tipVideoList = tipVideoDict.map{$0.value}

struct HomePage: View {

    var body: some View {
        
    NavigationView {
        List(tipVideoList, id: \.self) { elem in
            NavigationLink(destination: TipVideoDetail(tipVideo: elem)) {
                PreviewRow(tipVideo: elem)
            }
        }
    .navigationBarTitle(Text("Last Videos"))
        }
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
            HomePage()
    }
}
