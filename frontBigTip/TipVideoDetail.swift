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
    
    var tipVideo: TipVideo! // Static Data
    
    @ObservedObject private var tipVideoLoader: TipVideoLoader // Loader
    // End of download, we've got the url of the file
    
    @State private var videoUrl: String?
    
    @State var isAutoReplay: Bool = true
    @State var isMute: Bool = false
    @State var isPlay: Bool = true
    @State var stateText: String = ""
    
        
    init(tipVideo: TipVideo) {
        self.tipVideo = tipVideo
        //self.tipVideoLoader = TipVideoLoader(tipVideoId: preview.tipVideoId)
    }
    
    var body: some View {
        
        List {
            Text("Author is \(tipVideo.authorName)")
            Text("TipVideoId is \(tipVideo!.tipVideoId)")
        VideoPlayer(url: videoUrl, isPlay: $isPlay)
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
            .onReceive(TipVideoLoader.didChange) { url in
                self.VideoPlayer = VideoPlayer(url: url)
            }
        }
    }
}

class TipVideoLoader: ObservableObject {
    @Published var url: String?

    init(tipVideoId: String) {
    // Get tipVideo Thumbnail link 
    // Check if not already downloaded
    // Download if applicable
    // Return link
    }
}


// VIDEO PLAYER PATTERN

//@State var isAutoReplay: Bool = true
//@State var isMute: Bool = false
//@State var isPlay: Bool = true
//@State var stateText: String = ""

//        VideoPlayer(url: .constant(preview.), isPlay: $isPlay)
//            .autoReplay($isAutoReplay)
//            .mute($isMute)
//            .onPlayToEndTime { print("onPlayToEndTime") }
//            .onReplay { print("onReplay") }
//            .onStateChanged { state in
//                switch state {
//                case .none:
//                    self.stateText = "None"
//                case .loading:
//                    self.stateText = "Loading..."
//                case .playing:
//                    self.stateText = "Playing!"
//                case .paused(_, let playProgress, let bufferProgress):
//                    self.stateText = "Paused: play \(Int(playProgress * 100))% buffer \(Int(bufferProgress * 100))%"
//                case .error(let error):
//                    self.stateText = "Error: \(error)"
//                }
//            }
//          .onReceive(TipVideoLoader.didChange) { url in
            //     self.VideoPlayer = VideoPlayer(url: url)
            // }


//struct ImageView: View {
//    @ObservedObject var imageLoader:ImageLoader
//    @State var image:UIImage = UIImage()
//
//    init(withURL url:String) {
//        imageLoader = ImageLoader(urlString:url)
//    }
//
//    var body: some View {
//        VStack {
//            Image(uiImage: image)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width:100, height:100)
//        }.onReceive(imageLoader.didChange) { data in
//            self.image = UIImage(data: data) ?? UIImage()
//        }
//    }
//}
//
//class ImageLoader: ObservableObject {
//    @Published var data:Data?
//
//    init(urlString:String) {
//        guard let url = URL(string: urlString) else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { return }
//            DispatchQueue.main.async {
//                self.data = data
//            }
//        }
//        task.resume()
//    }
//}

//struct StargazersView: View {
//    var stargazers:[User] = []
//
//    var body: some View {
//        List(stargazers) { stargazer in
//            HStack {
//                ImageView(withURL: stargazer.avatarUrl)
//                Text(stargazer.login)
//            }
//        }
//    }
//}
//