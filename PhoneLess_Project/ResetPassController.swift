//
//  ResetPassController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 17/04/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase

class ResetPassController: UIViewController {
    
    @IBOutlet weak var lblresetPass: UILabel!
    @IBOutlet weak var txtEmail_Input: UITextField!
    @IBOutlet weak var btnSend_Email: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblresetPass.textColor = UIColor.black

        // Do any additional setup after loading the view.
    }
    
    // Function that thats user's input and sends message to input email if correct
    @IBAction func btn_SendEmail(_ sender: Any) {
        if let email = txtEmail_Input.text {
            if email != ""{
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                }
                lblresetPass.textColor = UIColor.blue
                lblresetPass.text = "You will receive an email if your detail is correct."
                txtEmail_Input.isHidden = true
                btnSend_Email.isHidden = true
                btnBack.setTitle("Back", for: .normal)
            }else{
                lblresetPass.text = "Please enter email."
                lblresetPass.textColor = UIColor.red
            }
        }
    }
    
    // Return to login page
    @IBAction func btn_Back(_ sender: Any) {
        self.performSegue(withIdentifier: "Blogin", sender: self)
    }
    
}
