//
//  previewUserHandling.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 28/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class SharedUserData {
    
    var currentUser: CurrentUser?
    
    static let shared = SharedUserData()
    private init() {    }
    
    func getCurrentUser() {
        
        let data = loadJSONfile(url: "Current_User_Launch")
        let user = parsingJSONtoUser(data: data)
        
        print("Current user loaded successfully !")
        self.currentUser = user
    }
    
    fileprivate func loadJSONfile(url: String) -> Data {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        
        return data
    }
    
    fileprivate func parsingJSONtoUser(data: Data) -> CurrentUser {
    /* Serialize JSON to List of Preview objects */
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let user = try? decoder.decode(CurrentUser.self, from: data) else { fatalError("Impossible to parse Json to User")}
        print("Parsing previews succeeded !")
        return user
    }

}
