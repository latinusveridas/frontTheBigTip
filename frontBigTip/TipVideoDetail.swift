//
//  TipVideoDetail.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 11/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import SwiftUI
import VideoPlayer

struct TipVideoDetail: View {
    
    @ObservedObject var tipVideo: TipVideo // Static Data
    
    @State var isAutoReplay: Bool = true
    @State var isMute: Bool = false
    @State var isPlay: Bool = true
    @State var stateText: String = ""
        
    init(tipVideo: TipVideo) {
        self.tipVideo = tipVideo
    }
    
    var body: some View {
        
        List {
            Text("Author is \(tipVideo.authorName)")
            Text("TipVideoId is \(tipVideo.tipVideoId)")
            VideoPlayer(url: .constant(tipVideo.stringToURL()!), isPlay: $isPlay)
            .autoReplay($isAutoReplay)
            .mute($isMute)
            .onPlayToEndTime { print("onPlayToEndTime") }
            .onReplay { print("onReplay") }
            .onStateChanged { state in
                switch state {
                case .none:
                    self.stateText = "None"
                case .loading:
                    self.stateText = "Loading..."
                case .playing:
                    self.stateText = "Playing!"
                case .paused(_, let playProgress, let bufferProgress):
                    self.stateText = "Paused: play \(Int(playProgress * 100))% buffer \(Int(bufferProgress * 100))%"
                case .error(let error):
                    self.stateText = "Error: \(error)"
                }
            }
//            .onReceive(tipVideo.didChange) { url in
//                self.VideoPlayer = VideoPlayer(url: url, isPlay: $isPlay)
//            }
        }
    }
}
