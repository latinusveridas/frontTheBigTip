//
//  previewUserHandling.swift
//  frontBigTip
//
//  Created by Quentin Duquesne on 28/12/2019.
//  Copyright © 2019 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class sharedUserData {

    static var InitializedCurrentUser: User? = {
        guard let data = loadJSONfile(url: "currentUser") else {
            print("Loading of the file is not possible")
            return nil
        }
        
        guard let user = ParsingJSONtoUser(data: data) else {
            print("No user handled")
            return nil
        }
        
        print("Current user loaded successfully :)")
        return user
    } ()
    
    fileprivate static func loadJSONfile(url: String) -> Data? {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("☠️") }
        return data
    }
    
    fileprivate static func ParsingJSONtoUser(data: Data) -> User? {
    /* Serialize JSON to List of Preview objects */
        
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let user = try? decoder.decode(User.self, from: data) else { fatalError("Impossible to parse Json to User")}
            return user
    }

}
