//
//  Account_Singleton.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 09/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

import Foundation
import UIKit

class SharedAccount {
/* This class represent the shared User Account */
/* Type method are used as we do not instance an object, we directly use the type property */
    
    var account: Account?
    
    static let shared = SharedAccount()
    private init() {    }
    
    func getAccountStatement(url: String!) {
        let data = loadJSONfile(url: url)
        let account = parsingJSONtoAccount(data: data)
        
        self.account = account
    }
    
    fileprivate func loadJSONfile(url: String) -> Data {
    /* Load File to Data */
    
        let url = Bundle.main.url(forResource: url, withExtension: "json")!
        guard let data = try? Data(contentsOf: url) else { fatalError("Impossible to read the file") }
        return data
    }
    
    fileprivate func parsingJSONtoAccount(data: Data) -> Account {
    /* Serialize JSON to List of Preview objects */
            
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
            
        do {
            let account = try decoder.decode(Account.self, from: data)
            print("Launch Account state successfully loaded :)")
            return account
        } catch {
            print(error)
            fatalError()
        }
        
    }
    
}
