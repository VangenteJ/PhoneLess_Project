//
//  HelpController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit

class HelpController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Go back to settings page
    @IBAction func btngoBack(_ sender: Any) {
        self.performSegue(withIdentifier: "back_setting", sender: self)
    }
}

