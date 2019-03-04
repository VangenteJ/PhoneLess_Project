//
//  MenuController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    @IBOutlet weak var stackFriends: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func poke(_ sender: Any) {
        stackFriends.isHidden = false
        print("Naniiii???!!")
    }
    
}
