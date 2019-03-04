//
//  ViewController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {

    @IBOutlet weak var segLogReg: UISegmentedControl!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var txtName: YokoTextField!
    @IBOutlet weak var txtEmail: YokoTextField!
    @IBOutlet weak var txtPassword: YokoTextField!
    @IBOutlet weak var txtRePassword: YokoTextField!
    @IBOutlet weak var txtActivityLevel: YokoTextField!
    @IBOutlet weak var txtAddictionLevel: YokoTextField!
    @IBOutlet weak var btnLoginRegister: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func LoginRegister(_ sender: Any) {
        performSegue(withIdentifier: "LogReg", sender: self)
    }
    
    @IBAction func segmentLoginRegister(_ sender: Any) {
        if segLogReg.selectedSegmentIndex == 0{
            login()
        }else{
            register()
        }
    }
    
    func initial_state(){
        if segLogReg.selectedSegmentIndex == 0{
            login()
        }
    }
    
    func login(){
        btnLoginRegister.setTitle("Login", for: .normal)
        lblLogin.text = "Login"
        txtName.isHidden = true
        txtRePassword.isHidden = true
        txtActivityLevel.isHidden = true
        txtAddictionLevel.isHidden = true
    }
    
    func register(){
        btnLoginRegister.setTitle("Register", for: .normal)
        lblLogin.text = "Register"
        txtName.isHidden = false
        txtRePassword.isHidden = false
        txtActivityLevel.isHidden = false
        txtAddictionLevel.isHidden = false
    }
    
}

