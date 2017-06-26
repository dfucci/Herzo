//
//  ViewController.swift
//  Herzo
//
//  Created by Davide Fucci on 18/04/2017.
//  Copyright © 2017 Davide Fucci. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ViewController: UIViewController {

    

    
    override func viewDidLoad() {
             
        var ref: DatabaseReference!
        ref = Database.database().reference()
      
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let hkm = HealthKitManager()
        if hkm.authorize() {
            print("Authorized!")
            hkm.queryHeartRate(db: ref)
            
        
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

