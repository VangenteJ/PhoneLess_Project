//
//  ViewController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import FirebaseDatabase
import FirebaseAuth

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
    var user:DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func LoginRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "LogReg", sender: self)
        if segLogReg.selectedSegmentIndex == 0{
            if let email = txtEmail.text, let password = txtPassword.text{
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if user != nil{
                        //Redirect to menu after succesful log in/Register
                        print (user!)
                        self.performSegue(withIdentifier: "LogReg", sender: self)
                    }else{
                        //Change sign in/register label color to red if wrong login/Register
                        self.lblLogin.textColor = UIColor.red
                        self.lblLogin.text = "Please make sure you are entering the right details!"
                    }
                }
                
            }
        }else{
            if let email = txtEmail.text, let password = txtPassword.text, let re_password = txtRePassword.text, let name = txtName.text{
                if email != "" && password != "" && re_password != "" && name != ""{
                    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                        self.performSegue(withIdentifier: "LogReg", sender: self)
                        if user != nil{
                            self.performSegue(withIdentifier: "LogReg", sender: self)
                        }else{
                            self.lblLogin.textColor = UIColor.red
                            self.lblLogin.text = "Check your email"
                        }
                    }
                }else{
                    //Change sign in/register label color to red if wrong login/Register
                    self.lblLogin.textColor = UIColor.red
                    self.lblLogin.text = "Check error bellow"
                    if name == ""{
                        txtName.placeholderColor = UIColor.red
                    }
                    if email == ""{
                        txtEmail.placeholderColor = UIColor.red
                    }
                    if password == ""{
                        txtPassword.placeholderColor = UIColor.red
                    }
                    if re_password == ""{
                        txtRePassword.placeholderColor = UIColor.red
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func segmentLoginRegister(_ sender: Any) {
        if segLogReg.selectedSegmentIndex == 0{
            login()
            clear_red()
            clear_text()
        }else{
            register()
            clear_red()
            clear_text()
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
    
    func clear_red(){
        lblLogin.textColor = UIColor.white
        txtName.placeholderColor = UIColor.white
        txtEmail.placeholderColor = UIColor.white
        txtPassword.placeholderColor = UIColor.white
        txtRePassword.placeholderColor = UIColor.white
    }
    
    func clear_text(){
        txtName.text = ""
        txtEmail.text = ""
        txtPassword.text = ""
        txtRePassword.text = ""
        txtActivityLevel.text = ""
        txtAddictionLevel.text = ""
    }
}

