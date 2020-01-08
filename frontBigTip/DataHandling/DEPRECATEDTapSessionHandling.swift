//
//  TapSessionHandling.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 04/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class SharedTapSessionAPI {
/* This class represent the fetched Tap Session data from API */
/* Type method are used as we do not instance an object, we directly use the type property */
    
    var TapSessionList: [TapSession?] = []
    
    static let shared = SharedTapSessionAPI()
    private init() {    }
    
    func getTapSessionList() {
        let data = loadJSONfile(url: "APITapSessions")
        let TapSessionList = parsingJSONtoListTapSession(data: data)
        
        self.TapSessionList.removeAll()
        self.TapSessionList = TapSessionList
    }
    
    fileprivate func loadJSONfile(url: String) -> Data {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        return data
    }
    
    fileprivate func parsingJSONtoListTapSession(data: Data) -> [TapSession?] {
    /* Serialize JSON to List of TapSession objects */
        
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let TapSessionList = try? decoder.decode([TapSession].self, from: data) else { fatalError("Impossible to parse Json to TapSession")}
            return TapSessionList
    }
    
}

