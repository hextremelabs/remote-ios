//
//  HomeViewController.swift
//  Remote
//
//  Created by Akapo Damilola Francis on 30/01/2017.
//  Copyright © 2017 CottaCush. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var commandList: [Command] = Generator.getCommands();
    
    var ref: FIRDatabaseReference! = FIRDatabase.database().reference()
    let sessionId = Generator.generateNewSessionId();
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNormalTitle("Home")
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        LogMinx.logData(string: sessionId);
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commandRView", for: indexPath) as! CommandViewCell
        let c: Command = commandList[indexPath.row];
        cell.customize()
        cell.setUpObserverForCommand(command: c, indexPath: indexPath, ref: self.ref);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commandList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = collectionView.cellForItem(at: indexPath) as! CommandViewCell
        let c: Command = commandList[indexPath.row];
        c.index = "\(indexPath.row)";
        c.current_status = !(c.current_status);
        cv.command = c;
        self.writeCommand(command: c, indexPath: indexPath);
    }
    
    func writeCommand(command: Command, indexPath: IndexPath) {
        command.lastSessionId = self.sessionId
        let dict = ["action": "\(!(command.current_status))", "details" : command.toJsonString()]
        LocalStorage.getInstance().persistString(string: command.commandHash, key: command.toJsonString());
        self.ref.child("command").setValue(dict);
    }

}
