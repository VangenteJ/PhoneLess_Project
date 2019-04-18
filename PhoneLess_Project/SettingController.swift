//
//  SettingController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase


class SettingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var viewSetGoals: UIView!
    @IBOutlet weak var uiviewViewGoals: UIView!
    @IBOutlet weak var uiviewChangeDetails: UIView!
    @IBOutlet weak var stckImageStack: UIStackView!
    @IBOutlet weak var btnSetGoals: UIButton!
    @IBOutlet weak var btnDisplayGoals: UIButton!
    @IBOutlet weak var btnChangeDetails: UIButton!
    @IBOutlet weak var btnUpdateImage: UIButton!
    
    @IBOutlet weak var txtDailyTimeOFF: UITextField!
    @IBOutlet weak var txtWeeklyTimeOff: UITextField!
    @IBOutlet weak var txtDailySteps: UITextField!
    
    @IBOutlet weak var txtActivityLevel: UITextField!
    @IBOutlet weak var txtAddictionLevel: UITextField!
    @IBOutlet weak var txtAddFriend: UITextField!
    
    
    @IBOutlet weak var lblDaily_TimeOFF_Goal: UILabel!
    @IBOutlet weak var lblWeekly_TimeOFF_Goal: UILabel!
    @IBOutlet weak var lblDaily_Steps_Goal: UILabel!
    @IBOutlet weak var lblUserUID: UILabel!
    
    
    @IBOutlet weak var btnSet_D_TimeOFF: UIButton!
    @IBOutlet weak var btnSet_W_TimeOFF: UIButton!
    @IBOutlet weak var btnSet_D_Steps: UIButton!
    
    @IBOutlet weak var imgimageview: UIImageView!
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    var userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        set_up()
        retrieve_Goal_From_DB()
        chechImages()
        lblUserUID.text = userID
    }
    
    // Function that adds users goal input
    @IBAction func set_up_daily_timeoff_Goal(_ sender: Any) {
        if txtDailyTimeOFF.text != ""{
            if let dTime = Int(txtDailyTimeOFF.text!){
                ref.child(userID!).child("Daily Time OFF Goal").setValue(String(dTime))
                txtDailyTimeOFF.text = ""
            }
            handle = ref.child(userID!).child("Daily Time OFF Goal").observe(.value, with: { (snapshot) in
                if snapshot.value as? String != nil{
                    let time_OFF = snapshot.value as! String
                    if time_OFF != ""{
                        self.lblDaily_TimeOFF_Goal.text = "\(time_OFF) Mins"
                    }
                }
            })
        }
    }
    
    // Function that adds users goal input
    @IBAction func set_up_weekly_timeoff_Goal(_ sender: Any) {
        if txtWeeklyTimeOff.text != ""{
            if let wTime = Int(txtWeeklyTimeOff.text!){
                ref.child(userID!).child("Weekly Time OFF Goal").setValue(String(wTime))
                txtWeeklyTimeOff.text = ""
            }
            handle = ref.child(userID!).child("Weekly Time OFF Goal").observe(.value, with: { (snapshot) in
                if snapshot.value as? String != nil{
                    let time_OFF = snapshot.value as! String
                    if time_OFF != ""{
                        self.lblWeekly_TimeOFF_Goal.text = "\(time_OFF) Mins"
                    }
                }
            })
        }
    }
    
    // Function that adds users goal input
    @IBAction func set_up_daily_steps(_ sender: Any) {
        if txtDailySteps.text != ""{
            if let dSteps = Int(txtDailySteps.text!){
                ref.child(userID!).child("Daily Steps Goal").setValue(String(dSteps))
                txtDailySteps.text = ""
            }
            handle = ref.child(userID!).child("Daily Steps Goal").observe(.value, with: { (snapshot) in
                if snapshot.value as? String != nil{
                    let daily_Steps = snapshot.value as! String
                    if daily_Steps != ""{
                        self.lblDaily_Steps_Goal.text = "\(daily_Steps) Steps"
                    }
                }
            })
        }
    }
    
    // Function that allows user to rate their phone addictiviness
    @IBAction func update_Activity_Level(_ sender: Any) {
        if txtActivityLevel.text != ""{
            if let activity = Int(txtActivityLevel.text!){
                ref.child(userID!).child("Activity Level").setValue(String(activity))
                txtActivityLevel.text = ""
            }
        }
    }
    
    // Function that allows users to rate their phone addiction
    @IBAction func update_Device_addiction(_ sender: Any) {
        if txtAddictionLevel.text != ""{
            if let addiction = Int(txtAddictionLevel.text!){
                ref.child(userID!).child("Addiction Level").setValue(String(addiction))
                txtAddictionLevel.text = ""
            }
        }
    }
    
    // Allows user to add friends into their leaderboard
    @IBAction func add_friend(_ sender: Any) {
        handle = ref.child(userID!).child("New Friend1").observe(.value, with: { (snapshot) in
            if snapshot.value as? String == "New"{
                if self.txtAddFriend.text != ""{
                    let new_friend = self.txtAddFriend.text
                    self.ref.child(self.userID!).child("New Friend1").setValue(new_friend)
                    self.txtAddFriend.text = ""
                }else{
                    self.handle = self.ref.child(self.userID!).child("New Friend1").observe(.value, with: { (snapshot) in
                        if snapshot.value as? String == nil{
                            if self.txtAddFriend.text != ""{
                                let new_friend = self.txtAddFriend.text
                                self.ref.child(self.userID!).child("New Friend2").setValue(new_friend)
                                self.txtAddFriend.text = ""
                            }
                        }
                    })
                }
            }
        })
    }
    
    // Delete friend from user's leaderboard
    @IBAction func delete_Friend(_ sender: Any) {
        if txtAddFriend.text != ""{
           self.ref.child(self.userID!).child("New Friend1").setValue("New")
            self.txtAddFriend.text = ""
        }
    }
    
    // Add image
    @IBAction func addImage(_ sender: Any) {
        addImage()
    }
    
    //Log out function
    @IBAction func logOut(_ sender: Any) {
        let actual_User = Auth.auth().currentUser
        if actual_User != nil{
            try? Auth.auth().signOut()
            log_register()
        }
    }
    
    //Button that drings dropdown option that allow users to set their goals
    @IBAction func setGoals(_ sender: Any) {
        if viewSetGoals.isHidden == true{
            viewSetGoals.isHidden = false
            btnSetGoals.setImage(UIImage.init(named: "colapse"), for: .normal)
            if uiviewViewGoals.isHidden == false || uiviewChangeDetails.isHidden == false || stckImageStack.isHidden == false{
                uiviewViewGoals.isHidden = true
                uiviewChangeDetails.isHidden = true
                stckImageStack.isHidden = true
                btnDisplayGoals.setImage(UIImage.init(named: "expand"), for: .normal)
                btnChangeDetails.setImage(UIImage.init(named: "expand"), for: .normal)
                btnUpdateImage.setImage(UIImage.init(named: "expand"), for: .normal)
            }
        }else{
            viewSetGoals.isHidden = true
            btnSetGoals.setImage(UIImage.init(named: "expand"), for: .normal)
        }
    }
    
    //Button that brings drop down option that allow users to see goals
    @IBAction func viewGoals(_ sender: Any) {
        if uiviewViewGoals.isHidden == true{
            uiviewViewGoals.isHidden = false
            btnDisplayGoals.setImage(UIImage.init(named: "colapse"), for: .normal)
            if viewSetGoals.isHidden == false || uiviewChangeDetails.isHidden == false || stckImageStack.isHidden == false{
                viewSetGoals.isHidden = true
                uiviewChangeDetails.isHidden = true
                stckImageStack.isHidden = true
                btnChangeDetails.setImage(UIImage.init(named: "expand"), for: .normal)
                btnSetGoals.setImage(UIImage.init(named: "expand"), for: .normal)
                btnUpdateImage.setImage(UIImage.init(named: "expand"), for: .normal)
            }
        }else{
            uiviewViewGoals.isHidden = true
            btnDisplayGoals.setImage(UIImage.init(named: "expand"), for: .normal)
        }
    }
    
    //Button that brings drop down option to change user details
    @IBAction func changeDetails(_ sender: Any) {
        if uiviewChangeDetails.isHidden == true{
            uiviewChangeDetails.isHidden = false
            btnChangeDetails.setImage(UIImage.init(named: "colapse"), for: .normal)
            if uiviewViewGoals.isHidden == false || viewSetGoals.isHidden == false || stckImageStack.isHidden == false{
                uiviewViewGoals.isHidden = true
                viewSetGoals.isHidden = true
                stckImageStack.isHidden = true
                btnDisplayGoals.setImage(UIImage.init(named: "expand"), for: .normal)
                btnSetGoals.setImage(UIImage.init(named: "expand"), for: .normal)
                btnUpdateImage.setImage(UIImage.init(named: "expand"), for: .normal)
            }
        }else{
            uiviewChangeDetails.isHidden = true
            btnChangeDetails.setImage(UIImage.init(named: "expand"), for: .normal)
        }
    }
    
    //Button that brings drop down option to add image
    @IBAction func updateImage(_ sender: Any) {
        if stckImageStack.isHidden == true{
            stckImageStack.isHidden = false
            btnUpdateImage.setImage(UIImage.init(named: "colapse"), for: .normal)
            if uiviewViewGoals.isHidden == false || viewSetGoals.isHidden == false || uiviewChangeDetails.isHidden == false{
                uiviewViewGoals.isHidden = true
                viewSetGoals.isHidden = true
                uiviewChangeDetails.isHidden = true
                btnChangeDetails.setImage(UIImage.init(named: "expand"), for: .normal)
                btnDisplayGoals.setImage(UIImage.init(named: "expand"), for: .normal)
                btnSetGoals.setImage(UIImage.init(named: "expand"), for: .normal)
            }
        }else{
            stckImageStack.isHidden = true
            btnUpdateImage.setImage(UIImage.init(named: "expand"), for: .normal)
        }
    }
    
    //A function that hiddes objects and change arrow buttons to look the same
    func set_up(){
        viewSetGoals.isHidden = true
        btnSetGoals.setImage(UIImage.init(named: "expand"), for: .normal)
        uiviewViewGoals.isHidden = true
        btnDisplayGoals.setImage(UIImage.init(named: "expand"), for: .normal)
        uiviewChangeDetails.isHidden = true
        btnChangeDetails.setImage(UIImage.init(named: "expand"), for: .normal)
        stckImageStack.isHidden = true
        btnUpdateImage.setImage(UIImage.init(named: "expand"), for: .normal)
    }
    
    // Display help woindow
    @IBAction func btnSeeHelp(_ sender: Any) {
        self.performSegue(withIdentifier: "show_help", sender: self)
    }
    
    
    //A function that allows users to add image into the application through the phone library or camera
    func addImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //Default function
    //Storing picked image into DB
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        picker.dismiss(animated: true, completion: nil)
        var data = Data()
        data = image.jpegData(compressionQuality: 0.5)!
        
        let imageRef = Storage.storage().reference().child(userID!).child("Profile Image")

        _ = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                return
            }
        }
        
        chechImages()
    }
    
    // Dismiss image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Get image from DB and add to the profile
    func chechImages(){
        let imagepath = userID
        let image1 = Storage.storage().reference(withPath: imagepath! + "/Profile Image")
        
        image1.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("We trhough")
                // Add logo image if no image found
                self.imgimageview.image = UIImage(named: "Logo")
            } else {
                // Data for "images"
                self.imgimageview.image = UIImage(data: data!)
                
            }
        }
    }
    //A function that call out the very first page of the application
    func log_register(){
        let log_out = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(log_out, animated: true, completion: nil)
    }
    //Retrieve goal data from DB
    func retrieve_Goal_From_DB(){
        //Retrieve daily time off goal from DB
        handle = ref.child(userID!).child("Daily Time OFF Goal").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil{
                let time_OFF = snapshot.value as! String
                if time_OFF != ""{
                    self.lblDaily_TimeOFF_Goal.text = "\(time_OFF) Mins"
                }
            }
        })
        //Retrieve weekly time off goal from DB
        handle = ref.child(userID!).child("Weekly Time OFF Goal").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil{
                let time_OFF = snapshot.value as! String
                if time_OFF != ""{
                    self.lblWeekly_TimeOFF_Goal.text = "\(time_OFF) Mins"
                }
            }
        })
        //Retrieve daily steps goal from DB
        handle = ref.child(userID!).child("Daily Steps Goal").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil{
                let daily_Steps = snapshot.value as! String
                if daily_Steps != ""{
                    self.lblDaily_Steps_Goal.text = "\(daily_Steps) Steps"
                }
            }
        })
    }
}
