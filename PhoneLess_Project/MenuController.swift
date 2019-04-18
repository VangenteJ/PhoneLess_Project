//
//  MenuController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import CoreMotion
import Firebase

class MenuController: UIViewController {

    @IBOutlet weak var btnName1: UIButton!
    @IBOutlet weak var btnName2: UIButton!
    @IBOutlet weak var btnName3: UIButton!
    @IBOutlet weak var btnName4: UIButton!
    @IBOutlet weak var btnFingerPoint: UIButton!
    
    @IBOutlet weak var txtminutesOFF: UILabel!
    @IBOutlet weak var txtMinutesQuotes: UILabel!
    @IBOutlet weak var txtSteps: UILabel!
    @IBOutlet weak var txtStepsQuote: UILabel!
    
    @IBOutlet weak var imgimageview: UIImageView!
    
    var steps_Taken:String?
    var time_OFF:String?
    
    @IBOutlet weak var stackFriends: UIStackView!
    
    let activity_Manager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    let current_user = Auth.auth().currentUser
    let userID = Auth.auth().currentUser?.uid
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        imgimageview.alpha = 0
        txtminutesOFF.alpha = 0
        txtMinutesQuotes.alpha = 0
        btnFingerPoint.alpha = 0
        txtSteps.alpha = 0
        txtStepsQuote.alpha = 0
        
        update_Steps()
        getTimefromDB()
        steps_label()
        chechImages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        beenNagged()
        
        // Start the animation chain
        UIView.animate(withDuration: 1, animations: {
            self.imgimageview.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 1, animations: {
                self.txtminutesOFF.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 1, animations: {
                    self.txtMinutesQuotes.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 1, animations: {
                        self.btnFingerPoint.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 1, animations: {
                            self.txtSteps.alpha = 1
                        }, completion: { (true) in
                            UIView.animate(withDuration: 1, animations: {
                                self.txtStepsQuote.alpha = 1
                            })
                        })
                    })
                })
            })
        }
    }
    
    // Poke action
    @IBAction func poke(_ sender: Any) {
        handle = ref?.child(userID!).child("New Friend1").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let friend1 = snpashot.value as! String
                self.handle = self.ref?.child(friend1).child("Name").observe(.value, with: { (snpashot) in
                    if snpashot.value as? String != nil{
                        let f1Name = snpashot.value as! String
                        
                        self.handle = self.ref?.child(friend1).child("Time5").observe(.value, with: { (snpashot) in
                            if snpashot.value as? String != nil{
                                let f1Time = snpashot.value as! String
                                
                                self.ref?.child(self.userID!).child("Time5").observe(.value, with: { (snpashot) in
                                    if snpashot.value as? String != nil{
                                        let userTime = snpashot.value as! String
                                        
                                        if let friendTime = Int(f1Time){
                                            if let userT = Int(userTime){
                                                if userT > friendTime{
                                                    self.btnName1.setTitle(f1Name, for: .normal)
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
    
    // Poke action background
    @IBAction func name1Click(_ sender: Any) {
        btnName1.setTitle("", for: .normal)
        btnName2.setTitle("", for: .normal)
        
        handle = ref?.child(userID!).child("New Friend1").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let friend1 = snpashot.value as! String
                self.ref.child(friend1).child("Nagged").setValue("1")
            }
        })
        
        
    }
    
    @IBAction func name2Click(_ sender: Any) {
        btnName1.setTitle("", for: .normal)
        btnName2.setTitle("", for: .normal)
    }
    
    //counts the steps
    func stepCounter(){
        
        pedometer.startUpdates(from: Date()) { (data, error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.steps_Taken = data?.numberOfSteps.stringValue
                    self.ref.child((self.current_user?.uid)!).child("Steps6").setValue(self.steps_Taken)
                    self.txtStepsQuote.text = "You have walked: \(String(describing: self.steps_Taken)) steps today!"
                }
            }else{return}
        }
    }
    
    func update_Steps(){
        //Check for user activity and call step counting function
        if CMPedometer.isStepCountingAvailable(){
            stepCounter()
        }
        steps_Taken = String(600)
        handle = ref.child(userID!).child("Daily Steps Goal").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil{
                let daily_Steps = snapshot.value as! String
                if let dSteps = Int(daily_Steps){
                    if let actualSteps = Int(self.steps_Taken!){
                        if actualSteps > 500 && actualSteps < dSteps{
                            if let my_steps = Int(self.steps_Taken!){
                                self.txtSteps.text = "You have walked: \(my_steps) steps today!"
                                self.txtStepsQuote.text = "Not on the goal yet but you will get there if you keep at it"
                            }
                            
                        }else if actualSteps > 1000 && actualSteps < dSteps{
                            if let my_steps = Int(self.steps_Taken!){
                                self.txtSteps.text = "You have walked: \(my_steps) steps today!"
                                self.txtStepsQuote.text = "You did not quite achieve it yet but you did better than yesterday!"
                            }
                            
                        }else if actualSteps > dSteps{
                            if let my_steps = Int(self.steps_Taken!){
                                self.txtSteps.text = "You have walked: \(my_steps) steps today!"
                                self.txtStepsQuote.text = "You should give yourself a pat in the back for reaching the goal, you can push that extra mile now!"
                            }
                        }
                    }
                }
            }
        })
    }
    
    // Check if there is any previous steps and reset display fields accordingly
    func steps_label(){
        if steps_Taken == nil || steps_Taken == "0"{
            self.txtSteps.text = "You have walked: 0 steps today!"
            self.txtStepsQuote.text = "A 1000 miles journey starts with a single step!"
            steps_Taken = "0"
        }
        
        handle = ref?.child(userID!).child("Time6A").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let time_from_DB = snpashot.value as! String
                if time_from_DB == "0"{
                    self.txtminutesOFF.text = "You have been off your phone for 0 secs today!"
                    self.txtMinutesQuotes.text = "Not worth spending your time here today!"
                }
            }
        })
    }
    
    // Fetch time  off screen from database
    func getTimefromDB(){
        handle = ref?.child(userID!).child("Time6").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let time_from_DB = snpashot.value as! String
                self.txtminutesOFF.text = "You have been off your phone for \(time_from_DB) secs today!"
                self.txtMinutesQuotes.text = "You have been doing great without the phone, try to keep it up!"
                
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
    
    // Poking background process
    func beenNagged(){
        handle = ref?.child(userID!).child("Nagged").observe(.value, with: { (snpashot) in
            if snpashot.value as? String != nil{
                let nag = snpashot.value as! String
                self.handle = self.ref?.child(self.userID!).child("New Friend1").observe(.value, with: { (snpashot) in
                    if snpashot.value as? String != nil{
                        let friend1 = snpashot.value as! String
                        self.handle = self.ref?.child(friend1).child("Name").observe(.value, with: { (snpashot) in
                            if snpashot.value as? String != nil{
                                let f1Name = snpashot.value as! String
                                if nag == "1"{
                                    self.createAlert(title: "Nagged", message: "\(f1Name) Believes that you cannot live without your device!")
                                }
                            }
                        })
                    }
                })
                
            }
        })
    }
    
    // Alert set up
    func createAlert (title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Guilty", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.ref.child(self.userID!).child("Nagged").setValue("0")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
