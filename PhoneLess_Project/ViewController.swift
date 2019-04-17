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
    //var user:DatabaseReference!
    var ref:DatabaseReference!
    
    @IBOutlet weak var btnForgot_Password: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        segLogReg.alpha = 0
        lblLogin.alpha = 0
        txtName.alpha = 0
        txtEmail.alpha = 0
        txtPassword.alpha = 0
        txtRePassword.alpha = 0
        txtActivityLevel.alpha = 0
        txtAddictionLevel.alpha = 0
        btnLoginRegister.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        check_User()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.segLogReg.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                self.lblLogin.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.txtName.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.txtEmail.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.2, animations: {
                            self.txtPassword.alpha = 1
                        }, completion: { (true) in
                            UIView.animate(withDuration: 0.2, animations: {
                                self.txtRePassword.alpha = 1
                            }, completion: { (true) in
                                UIView.animate(withDuration: 0.2, animations: {
                                    self.txtActivityLevel.alpha = 1
                                }, completion: { (true) in
                                    UIView.animate(withDuration: 0.2, animations: {
                                        self.txtAddictionLevel.alpha = 1
                                    }, completion: { (true) in
                                        UIView.animate(withDuration: 0.2, animations: {
                                            self.btnLoginRegister.alpha = 1
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        }
        
    }
    
// Login or register users
    @IBAction func LoginRegister(_ sender: Any) {
        //Login users
        // Remove all red labels from screen
        clear_red()
        if segLogReg.selectedSegmentIndex == 0{
            if let email = txtEmail.text, let password = txtPassword.text{
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if user != nil{
                        //Redirect to menu after succesful log in
                        self.performSegue(withIdentifier: "LogReg", sender: self)
                    }else{
                        //Change sign in/register label color to red if wrong login/Register
                        self.lblLogin.textColor = UIColor.red
                        self.lblLogin.text = "Please make sure you are entering the right details!"
                    }
                }
                
            }
        }else{
            //Register users
            if let email = txtEmail.text, let password = txtPassword.text, let re_password = txtRePassword.text, let name = txtName.text{
                if email != "" && password != "" && re_password != "" && name != ""{
                    if password.count > 8{
                        if password == re_password{
                            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                                if user != nil{
                                    let userID = Auth.auth().currentUser?.uid
                                    //Store name detail into DB
                                    if self.txtName.text != ""{
                                        self.ref.child(userID!).child("Name").setValue(self.txtName.text)
                                    }
                                    //Call in a function that will store activity level details and addiction details if the input are numbers or discard them if otherwise
                                    self.only_numbers(userid: userID!)
                                    //Redirect to menu after succesful Register
                                    self.performSegue(withIdentifier: "LogReg", sender: self)
                                }else{
                                    self.lblLogin.textColor = UIColor.red
                                    self.txtEmail.placeholderColor = UIColor.red
                                    self.lblLogin.text = "Check email field"
                                }
                            }
                        }else{
                            self.lblLogin.textColor = UIColor.red
                            self.lblLogin.text = "Password unmatched"
                            txtRePassword.placeholderColor = UIColor.red
                        }
                    }else{
                        self.lblLogin.textColor = UIColor.red
                        self.lblLogin.text = "Password must be more than 8 characters!"
                        txtRePassword.placeholderColor = UIColor.red
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
    //Set all input field to empty
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
    
    
    @IBAction func forgot_password(_ sender: Any) {
        self.performSegue(withIdentifier: "forgot", sender: self)
    }
    
    func login(){
        btnLoginRegister.setTitle("Login", for: .normal)
        lblLogin.text = "Login"
        txtName.isHidden = true
        txtRePassword.isHidden = true
        txtActivityLevel.isHidden = true
        txtAddictionLevel.isHidden = true
        btnForgot_Password.isHidden = false
    }
    
    func register(){
        btnLoginRegister.setTitle("Register", for: .normal)
        lblLogin.text = "Register"
        txtName.isHidden = false
        txtRePassword.isHidden = false
        txtActivityLevel.isHidden = false
        txtAddictionLevel.isHidden = false
        btnForgot_Password.isHidden = true
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
    
    func check_User(){
        print ("Before")
        let actual_user = Auth.auth().currentUser
        if actual_user != nil{
            self.performSegue(withIdentifier: "LogReg", sender: self)
            print ("here")
        }
    }
    
    func only_numbers(userid:String){
        if txtActivityLevel.text != ""{
            if let activity = Int(txtActivityLevel.text!){
               ref.child(userid).child("Activity Level").setValue(String(activity))
            }else{
                txtActivityLevel.text = ""
            }
        }
        if txtAddictionLevel.text != ""{
            if let addiction = Int(txtAddictionLevel.text!){
               ref.child(userid).child("Addiction Level").setValue(String(addiction))
            }else{
                txtAddictionLevel.text = ""
            }
        }
    }
}

