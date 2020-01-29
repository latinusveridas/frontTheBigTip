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
        
    init(tipVideo2: TipVideo) {
    
        //self.tipVideo = tipVideo
        let tipVideo = TipVideo(tipVideoId: "xx", tipNb: 0, authorName: "quentin", authorId: "xx", maxTip: 10, priceTip: 5, tipsList: [], maxSize: 10, currentSize: 1, tipVideoRemoteLink: "", tipVideoLocalLink: "xx")
        
        let rawURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                .appendingPathComponent("BigTip")
                .appendingPathComponent("cache")
                .appendingPathComponent("TheNewVideo.mp4")
                
        let strURL = rawURL.absoluteString
        print("URL of TheNewVideo is \(strURL)")
        tipVideo.tipVideoLocalLink = strURL
        
        self.tipVideo = tipVideo
        
    }
    
    var body: some View {
        
        VideoPlayer(url: .constant(tipVideo.getLocalTipVideoURL()!), isPlay: $isPlay)
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
