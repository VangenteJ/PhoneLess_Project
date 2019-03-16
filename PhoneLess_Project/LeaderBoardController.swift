//
//  LeaderBoardController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderBoardController: UIViewController {

    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    var dbData:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
    }
    
    
}
