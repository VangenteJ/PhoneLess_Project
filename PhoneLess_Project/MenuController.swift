//
//  MenuController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    @IBOutlet weak var btnName1: UIButton!
    @IBOutlet weak var btnName2: UIButton!
    @IBOutlet weak var btnName3: UIButton!
    @IBOutlet weak var btnName4: UIButton!
    @IBOutlet weak var stackFriends: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func poke(_ sender: Any) {
        btnName1.setTitle("Joel", for: .normal)
        btnName2.setTitle("Alisha", for: .normal)
    }
    @IBAction func name1Click(_ sender: Any) {
        btnName1.setTitle("", for: .normal)
        btnName2.setTitle("", for: .normal)
    }
    
    @IBAction func name2Click(_ sender: Any) {
        btnName1.setTitle("", for: .normal)
        btnName2.setTitle("", for: .normal)
    }
}
