//
//  ProfileController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userSurname: UILabel!
    @IBOutlet weak var userAddictionLevel: UILabel!
    @IBOutlet weak var userActivityLevel: UILabel!
    
    @IBOutlet weak var pbest_Daily_Timeoff: UILabel!
    @IBOutlet weak var pbest_Weekly_Timeoff: UILabel!
    @IBOutlet weak var pbest_Daily_Steps: UILabel!
    @IBOutlet weak var pbest_Weekly_Steps: UILabel!
    
    @IBOutlet weak var userImg: UIImageView!
    
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    var userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        get_data()
        chechImages()
    }
    
    // Get info from DB
    func get_data(){
        // Get name info from DB
        handle = ref?.child(userID!).child("Name").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uName = snpashot.value as! String
                if uName != ""{
                    print("Name got printed")
                    self.userName.text = uName
                }
            }
        })
        // Get addiction info from DB
        handle = ref?.child(userID!).child("Addiction Level").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uAddiction = snpashot.value as! String
                if uAddiction != ""{
                    print("Addiction got printed")
                    self.userAddictionLevel.text = uAddiction
                }
            }
        })
        // Get activity info from DB
        handle = ref?.child(userID!).child("Activity Level").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uActivity = snpashot.value as! String
                if uActivity != ""{
                    print("Activity got printed")
                    self.userActivityLevel.text = uActivity
                }
            }
        })
        // Get daily time off personal best info from DB
        handle = ref?.child(userID!).child("Best Daily Time OFF").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestDTimeOFF = snpashot.value as! String
                if uBestDTimeOFF != ""{
                    self.pbest_Daily_Timeoff.text = uBestDTimeOFF
                }
            }
        })
        // Get weekly time off personal best info from DB
        handle = ref?.child(userID!).child("Best Weekly Time OFF").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestWTimeOFF = snpashot.value as! String
                if uBestWTimeOFF != ""{
                    self.pbest_Weekly_Timeoff.text = uBestWTimeOFF
                }
            }
        })
        // Get daily steps personal best info from DB
        handle = ref?.child(userID!).child("Best Daily Steps").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestDSteps = snpashot.value as! String
                if uBestDSteps != ""{
                    self.pbest_Daily_Steps.text = uBestDSteps
                }
            }
        })
        // Get weekly steps personal best info from DB
        handle = ref?.child(userID!).child("Best Weekly Steps").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestWSteps = snpashot.value as! String
                if uBestWSteps != ""{
                    self.pbest_Weekly_Steps.text = uBestWSteps
                }
            }
        })
        personal_best()
    }
    
    // Check and set the personal best
    func personal_best(){
        // Get daily time off personal best info from DB
        handle = ref?.child(userID!).child("Best Daily Time OFF").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestDTimeOFF = snpashot.value as! String
                
                self.handle = self.ref?.child(self.userID!).child("Time5").observe(.value, with: { (snpashot) in
                    if snpashot.value as? String != nil{
                        let uTime = snpashot.value as! String
                        
                        if let actualUTime = Int(uTime){
                            if let bestTime = Int(uBestDTimeOFF){
                                if actualUTime > bestTime{
                                    self.pbest_Daily_Timeoff.text = String(actualUTime)
                                }
                            }
                        }
                    }
                })
                
            }
        })
        // Get weekly time off personal best info from DB
        handle = ref?.child(userID!).child("Best Weekly Time OFF").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestWTimeOFF = snpashot.value as! String
                
                self.handle = self.ref?.child(self.userID!).child("Week2Time").observe(.value, with: { (snpashot) in
                    if snpashot.value as? String != nil{
                        let uTime = snpashot.value as! String
                        
                        if let actualUTime = Int(uTime){
                            if let bestTime = Int(uBestWTimeOFF){
                                if actualUTime > bestTime{
                                    self.pbest_Weekly_Timeoff.text = String(actualUTime)
                                }
                            }
                        }
                    }
                })
            }
        })
        // Get daily steps personal best info from DB
        handle = ref?.child(userID!).child("Best Daily Steps").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestDSteps = snpashot.value as! String
                
                self.handle = self.ref?.child(self.userID!).child("Steps5").observe(.value, with: { (snpashot) in
                    if snpashot.value as? String != nil{
                        let uSteps = snpashot.value as! String
                        
                        if let actualUSteps = Int(uSteps){
                            if let bestSteps = Int(uBestDSteps){
                                if actualUSteps > bestSteps{
                                    self.pbest_Daily_Steps.text = String(actualUSteps)
                                }
                            }
                        }
                    }
                })
            }
        })
        // Get weekly steps personal best info from DB
        handle = ref?.child(userID!).child("Best Weekly Steps").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let uBestWSteps = snpashot.value as! String
                self.handle = self.ref?.child(self.userID!).child("Week2Steps").observe(.value, with: { (snpashot) in
                    if snpashot.value as? String != nil{
                        let uSteps = snpashot.value as! String
                        
                        if let actualUSteps = Int(uSteps){
                            if let bestSteps = Int(uBestWSteps){
                                if actualUSteps > bestSteps{
                                    self.pbest_Weekly_Steps.text = String(actualUSteps)
                                }
                            }
                        }
                    }
                })
            }
        })
    }
    
    
    //Get image from DB and add to the profile
    func chechImages(){
        let imagepath = userID
        let image1 = Storage.storage().reference(withPath: imagepath! + "/Profile Image")
        
        image1.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                print("We trhough")
                // Add logo image if no image found
                self.userImg.image = UIImage(named: "Logo")
            } else {
                // Data for "images"
                self.userImg.image = UIImage(data: data!)
                
            }
        }
    }
}
