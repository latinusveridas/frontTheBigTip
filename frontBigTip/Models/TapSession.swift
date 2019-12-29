//
//  TapSession.swift
//  TheBigTip_0.0.0
//
//  Created by Quentin Duquesne on 02/01/2020.
//  Copyright © 2020 Quentin Duquesne. All rights reserved.
//

/* A tap session is a sequence of tap */
/* Once the session is finished, the data packet is sent to the API to debit the remaining coins */

import Foundation

//isTapSessionRunning: Bool = False

struct TapSession {
    
    var lastTap: Tip // LastTap is reset when re-taping before end of countdown 
    fileprivate var countdown: Double // Represent the time 
    let timer = Timer()
    
    
}
