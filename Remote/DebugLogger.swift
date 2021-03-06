//
//  DebugLogger.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import Foundation

struct LogMinx {
    static let state: Bool = true;
    static func logData(string: String){
        if(state == true){
            debugPrint(string);
        }
    }
    
    static func logData(string: AnyObject){
        if(state == true){
            debugPrint(string);
        }
    }
}
