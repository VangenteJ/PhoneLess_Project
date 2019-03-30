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
    
    
    @IBOutlet weak var btnSet_D_TimeOFF: UIButton!
    @IBOutlet weak var btnSet_W_TimeOFF: UIButton!
    @IBOutlet weak var btnSet_D_Steps: UIButton!
    
    @IBOutlet weak var imgimageview: UIImageView!
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    var userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_up()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func set_up_daily_timeoff_Goal(_ sender: Any) {
        if txtDailyTimeOFF.text != ""{
            ref.child(userID!).child("Daily Time OFF Goal").setValue(txtDailyTimeOFF.text)
            txtDailyTimeOFF.text = ""
        }
    }
    @IBAction func set_up_weekly_timeoff_Goal(_ sender: Any) {
        if txtWeeklyTimeOff.text != ""{
            ref.child(userID!).child("Weekly Time OFF Goal").setValue(txtWeeklyTimeOff.text)
            txtWeeklyTimeOff.text = ""
        }
    }
    
    @IBAction func set_up_daily_steps(_ sender: Any) {
        if txtDailySteps.text != ""{
            ref.child(userID!).child("Daily Steps Goal").setValue(txtDailySteps.text)
            txtDailySteps.text = ""
        }
    }
    
    @IBAction func update_Activity_Level(_ sender: Any) {
        if txtActivityLevel.text != ""{
            ref.child(userID!).child("Activity Level").setValue(txtActivityLevel.text)
            txtActivityLevel.text = ""
        }
    }
    
    @IBAction func update_Device_addiction(_ sender: Any) {
        if txtAddictionLevel.text != ""{
            ref.child(userID!).child("Addiction Level").setValue(txtAddictionLevel.text)
            txtAddictionLevel.text = ""
        }
    }
    
    @IBAction func add_friend(_ sender: Any) {
        let actual_User = Auth.auth().currentUser
        if actual_User != nil{
            try? Auth.auth().signOut()
        }
    }
    
    @IBAction func addImage(_ sender: Any) {
        addImage()
    }
    
    @IBAction func logOut(_ sender: Any) {
        log_register()
    }
    
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
    
    
    func set_up(){
        viewSetGoals.isHidden = true
        btnSetGoals.setImage(UIImage.init(named: "expand"), for: .normal)
        uiviewViewGoals.isHidden = true
        btnDisplayGoals.setImage(UIImage.init(named: "expand"), for: .normal)
        uiviewChangeDetails.isHidden = true
        btnChangeDetails.setImage(UIImage.init(named: "expand"), for: .normal)
        stckImageStack.isHidden = true
        btnUpdateImage.setImage(UIImage.init(named: "expamd"), for: .normal)
    }
    
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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func chechImages(){
        let imagepath = userID
        print (imagepath! + "/Images/Number1")
        let image1 = Storage.storage().reference(withPath: imagepath! + "Profile Image")
        
        image1.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Add logo image if no image found
                self.imgimageview.image = UIImage(named: "Logo")
            } else {
                // Data for "images"
                self.imgimageview.image = UIImage(data: data!)
                
            }
        }
    }
    
    func log_register(){
        let log_out = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(log_out, animated: true, completion: nil)
    }
}
