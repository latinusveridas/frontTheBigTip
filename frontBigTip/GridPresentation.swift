//
//  PreviewList.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 26/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI

let previewList = sharedPreviewData.PreviewList

struct ContentView: View {
    
    var body: some View {
    
        VStack {
            
            previewList.forEach { elem in
                elem.
            }
            
        }
                
    }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
