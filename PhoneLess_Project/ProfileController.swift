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
        get_data()
        chechImages()
        
    }
    
    // Get info from DB
    func get_data(){
        // Get name info from DB
        handle = ref?.child(userID!).child("Name").observe(.value, with: { (snpashot) in
            let uName = snpashot.value as! String
            if uName != ""{
                self.userName.text = uName
            }
        })
        // Get addiction info from DB
        handle = ref?.child(userID!).child("Addiction Level").observe(.value, with: { (snpashot) in
            let uAddiction = snpashot.value as! String
            if uAddiction != ""{
                self.userAddictionLevel.text = uAddiction
            }
        })
        // Get activity info from DB
        handle = ref?.child(userID!).child("Activity Level").observe(.value, with: { (snpashot) in
            let uActivity = snpashot.value as! String
            if uActivity != ""{
                self.userActivityLevel.text = uActivity
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
