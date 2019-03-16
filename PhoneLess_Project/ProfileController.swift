//
//  ProfileController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
   
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        

        // Do any additional setup after loading the view.
    }
    
}
