//
//  CommandViewCell.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CommandViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCurrentStatus: UIView!
    @IBOutlet weak var labelCommandName: UILabel!
    
    var command: Command? = nil {
        willSet(newValue){
            reverse(boolean: (newValue?.current_status)!)
        }
    }
    
    func setUpObserverForCommand(command: Command, indexPath: IndexPath,  ref: FIRDatabaseReference){
        self.command = command
        ref.child("command").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                if(snapshot.value != nil){
                    let value = snapshot.value as! NSDictionary
                    let command = Command(json: value["details"] as! String!);
                    self.command = command
                    LogMinx.logData(string: "Updated value from db \(value["action"]) \(command.commandHash))");
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        
    }
    
    
    func reverse(boolean: Bool){
        self.labelCommandName.text = boolean == true ? command?.commandTitle:command?.commandTitleReverse;
        self.labelCommandName.textColor = boolean == true ? UIColor.green:UIColor.red
        self.viewCurrentStatus.backgroundColor = boolean == false ? UIColor.green:UIColor.red
    }
    
}
