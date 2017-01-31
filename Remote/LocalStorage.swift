//
//  LocalStorage.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import Foundation
import Foundation

class LocalStorage{
    
    
    init() {
    }
    
    static public func getInstance() -> LocalStorage {
        return LocalStorage()
    }
    
    public func getCommand(key: String) -> Command? {
        let string: String? = getString(key: key)
        if(string != nil){
            return Command(json: string);
        }
        return nil;
    }
    
    public func persistString(string: String!, key: String!){
        delete(key: key);
        UserDefaults.standard.setValue(string, forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    public func getString(key: String!) -> String? {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.value(forKey: key) as? String;
    }
    
    public func delete(key: String!){
        UserDefaults.standard.removeObject(forKey: key);
        UserDefaults.standard.synchronize();
    }
    
    
    public func clearAll(){
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        UserDefaults.standard.synchronize()
    }
    
    
}
