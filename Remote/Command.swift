//
//  Command.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import Foundation
import EVReflection

@objc(Command)
public class Command: EVObject{
    var commandTitle: String = "";
    var commandTitleReverse: String = "";
    var commandHash: String = "";
    var current_status: Bool = false;
    var lastSessionId: String? = nil;
    var index: String! = "";
}


public struct Generator{
    
    internal static func createHash(string: String) -> String{
        guard let messageData = string.data(using:String.Encoding.utf8) else
        { return  string.trim()}
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
    
    internal static func createReverse(string: String) -> String{
        return string.replacingOccurrences(of: "Put on WiFi AP hotspot", with: "Put off WiFi AP hotspot").replacingOccurrences(of: "Unlock Phone", with: "Lock Phone").replacingOccurrences(of: "Put on WiFi", with: "Put off WiFi");
    }
    
    static func getCommands() -> [Command]{
        let options: [String] = ["Put on WiFi AP hotspot", "Unlock Phone", "Put on WiFi"];
        var commands: [Command] = [];
        
        for option in options{
            let command = Command();
            command.commandTitle = option;
            if(!command.commandTitle.isEmpty){
                command.commandHash = createHash(string: command.commandTitle.lowercased().trim());
                command.commandTitleReverse = createReverse(string: command.commandTitle)
                commands.append(command)
            }
            
        }
        
        return commands;
    }
    
    
    static func generateNewSessionId() -> String{
        let oldId: String! = LocalStorage.getInstance().getString(key: Constants.SESSION_ID) ?? randomString(length: 16)
        LocalStorage.getInstance().persistString(string: Constants.SESSION_ID, key: oldId)
        return oldId;
    }
    
    static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }

}
