//
//  LeaderBoardController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderBoardController: UIViewController {

    @IBOutlet weak var imgimageview: UIImageView!
    
    @IBOutlet weak var txt_top1: UILabel!
    @IBOutlet weak var txt_top1_name: UILabel!
    @IBOutlet weak var txt_top1_min: UILabel!
    @IBOutlet weak var txt_top1_steps: UILabel!
    @IBOutlet weak var txt_top2: UILabel!
    @IBOutlet weak var txt_top2_name: UILabel!
    @IBOutlet weak var txt_top2_min: UILabel!
    @IBOutlet weak var txt_top2_steps: UILabel!
    @IBOutlet weak var txt_top3: UILabel!
    @IBOutlet weak var txt_top3_name: UILabel!
    @IBOutlet weak var txt_top3_min: UILabel!
    @IBOutlet weak var txt_top3_steps: UILabel!
    @IBOutlet weak var txt_top4: UILabel!
    @IBOutlet weak var txt_top4_name: UILabel!
    @IBOutlet weak var txt_top4_min: UILabel!
    @IBOutlet weak var txt_top4_steps: UILabel!
    
    
    let userID = Auth.auth().currentUser?.uid
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    var dbData:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        populateboard()
        chechImages()
        
    }
    
    func populateboard(){
        handle = ref?.child(userID!).child("New Friend1").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                self.friend1Name()
            }
        })
        if txt_top1_name.text == ""{
            self.handle = self.ref?.child(self.userID!).child("Name").observe(.value, with: { (snpashot) in
                if snpashot.value as? String != nil{
                    let userName = snpashot.value as! String
                    self.handle = self.ref?.child(self.userID!).child("Steps5").observe(.value, with: { (snpashot) in
                        if snpashot.value as? String != nil{
                            let userSteps = snpashot.value as! String
                            self.handle = self.ref?.child(self.userID!).child("Time5").observe(.value, with: { (snpashot) in
                                if snpashot.value as? String != nil{
                                    let userTime = snpashot.value as! String
                                    self.txt_top1_name.text = userName
                                    self.txt_top1_min.text = "\(userTime) Mins"
                                    self.txt_top1_steps.text = userSteps
                                }
                            })
                        }
                    })
                }
            })
        }
    }
    
    func friend1Name(){
        handle = ref?.child(userID!).child("New Friend1").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let friend1 = snpashot.value as! String
                self.handle = self.ref?.child(friend1).child("Name").observe(.value, with: { (snpashot) in
                    if snpashot.value as? String != nil{
                        let f1Name = snpashot.value as! String
                        self.handle = self.ref?.child(friend1).child("Steps5").observe(.value, with: { (snpashot) in
                            if snpashot.value as? String != nil{
                                let f1Steps = snpashot.value as! String
                                self.handle = self.ref?.child(friend1).child("Time5").observe(.value, with: { (snpashot) in
                                    if snpashot.value as? String != nil{
                                        let f1Time = snpashot.value as! String
                                        self.handle = self.ref?.child(self.userID!).child("Name").observe(.value, with: { (snpashot) in
                                            if snpashot.value as? String != nil{
                                                let userName = snpashot.value as! String
                                                self.handle = self.ref?.child(self.userID!).child("Steps5").observe(.value, with: { (snpashot) in
                                                    if snpashot.value as? String != nil{
                                                        let userSteps = snpashot.value as! String
                                                        self.handle = self.ref?.child(self.userID!).child("Time5").observe(.value, with: { (snpashot) in
                                                            if snpashot.value as? String != nil{
                                                                let userTime = snpashot.value as! String
                                                                if let uSteps = Int(userSteps){
                                                                    if let friendS = Int(f1Steps){
                                                                        self.txt_top2.isHidden = false
                                                                        if uSteps > friendS{
                                                                            self.txt_top1_name.text = userName
                                                                            self.txt_top1_min.text = "\(userTime) Mins"
                                                                            self.txt_top1_steps.text = userSteps
                                                                            self.txt_top2_name.text = f1Name
                                                                            self.txt_top2_min.text = "\(f1Time) Mins"
                                                                            self.txt_top2_steps.text = f1Steps
                                                                        }else{
                                                                            self.txt_top2_name.text = userName
                                                                            self.txt_top2_min.text = "\(userTime) Mins"
                                                                            self.txt_top2_steps.text = userSteps
                                                                            self.txt_top1_name.text = f1Name
                                                                            self.txt_top1_min.text = "\(f1Time) Mins"
                                                                            self.txt_top1_steps.text = f1Steps
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        })
                                                    }
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                        })
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
                self.imgimageview.image = UIImage(named: "Logo")
            } else {
                // Data for "images"
                self.imgimageview.image = UIImage(data: data!)
                
            }
        }
    }
}
