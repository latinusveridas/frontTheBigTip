//
//  DataHandling.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

func populateEventsList(targetURL: String,theSessionManager: SessionManager, completion: @escaping ([eventClass]?) -> Void) {

    theSessionManager.request(targetURL, method: .get)
        .validate()
        .responseJSON { response in
            print(response)
            switch response.result {
                
            case .success:
                
                guard response.result.isSuccess else {return completion(nil)}
                guard let rawData = response.result.value as? [[String:Any]?] else {return completion(nil)}
                
                let inventory = rawData.compactMap { EvenDict -> eventClass? in
                    let data = EvenDict!
                    return eventClass(data: data)
                }
                
                completion(inventory)
                
            case .failure(let error):
                print(error)
                
            }
            
    }
    
} // end of populateEventsList

func getJSON(endpoint: String, theSessionManager: SessionManager, completion: @escaping () -> Void) {
/* Generic method to get JSON data from API */
    theSessionManager.request(endpoint,method: .get)
        .validate()
        .responseJSON { response in
        
        switch response.result {
            
            case .success:
                return response.result.value as? [[String:Any]?] else {return completion(nil)}
                
            case .failure:
            
        }
            
        }
}

func getData(endpoint: String, theSessionManager: SessionManager, completion: @escaping () -> Void) {
/* Generic method to get data from API */
    theSessionManager.request(endpoint,method: .get)
        .validate()
        .responseData { response in
        
        switch response.result {
            
            case .success:
                return response.result.value as? Data
                
            case .failure:
            
        }
            
        }    
}
