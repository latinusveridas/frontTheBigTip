//
//  ContentView.swift
//  Demo
//
//  Created by Gesen on 2019/7/14.
//

import SwiftUI
import VideoPlayer

private let demoURL = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!

struct ContentView : View {
    @State var isAutoReplay: Bool = true
    @State var isMute: Bool = false
    @State var isPlay: Bool = true
    @State var stateText: String = ""
    
    var tipVideo: TipVideo
    var videoURL: URL?
    
    init() {
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
        self.videoURL = URL(fileURLWithPath: strURL)
    }
    
    var body: some View {
        VStack {
            VideoPlayer(url: .constant(videoURL!), isPlay: $isPlay)
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
            
            Text(stateText)
                .padding()
            
            HStack {
                Button(self.isPlay ? "Pause" : "Play") { self.isPlay.toggle() }
                Divider().frame(height: 20)
                Button(self.isMute ? "Sound Off" : "Sound On") { self.isMute.toggle() }
                Divider().frame(height: 20)
                Button(self.isAutoReplay ? "Auto Replay On" : "Auto Replay Off") { self.isAutoReplay.toggle() }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
