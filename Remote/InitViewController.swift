//
//  ViewController.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InitViewController: UIViewController {

    @IBOutlet weak var sRemote: UIButton!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sRemote.customize()
        LogMinx.logData(string: "Got here")
        self.ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.setNavBarTitle("Remote")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionStartRemote(_ sender: UIButton) {
        self.showProgressView(message: "Initiating Session...")
        resetAll(done: {
            self.dismissProgressOverview()
            self.performSegue(identifier: Constants.Segue.segueStartRemote)
        }, failed: {
            self.dismissProgressOverview()
            self.createAlertDialog(message: "Could not write commands. Please try again.")
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.setNavBarTitle(nil);
    }

    func resetAll(done: @escaping () -> Void, failed: @escaping () -> Void) {
        for command in Generator.getCommands(){
            command.current_status = false;
            let dict = ["action": "\(!(command.current_status))", "details" : command.toJsonString()]
            LocalStorage.getInstance().persistString(string: command.commandHash, key: command.toJsonString());
            self.ref.child("command").setValue(dict);
        }
        
        self.ref.child("command").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if(snapshot.value != nil){
                done();
                LogMinx.logData(string: "Updated valued");
            }
        }) { (error) in
            failed();
            print(error.localizedDescription)
        }
        
    }
    
}

