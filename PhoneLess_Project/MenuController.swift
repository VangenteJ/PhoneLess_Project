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
    
    @IBOutlet weak var txtminutesOFF: UILabel!
    @IBOutlet weak var txtMinutesQuotes: UILabel!
    @IBOutlet weak var txtSteps: UILabel!
    @IBOutlet weak var txtStepsQuote: UILabel!
    
    var steps_Taken:String?
    var time_OFF:String?
    
    @IBOutlet weak var stackFriends: UIStackView!
    
    let activity_Manager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    let current_user = Auth.auth().currentUser
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    @IBAction func poke(_ sender: Any) {
        btnName1.setTitle("Joel", for: .normal)
        btnName2.setTitle("Alisha", for: .normal)
    }
    @IBAction func name1Click(_ sender: Any) {
        btnName1.setTitle("", for: .normal)
        btnName2.setTitle("", for: .normal)
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
                    self.ref.child((self.current_user?.uid)!).child("Steps").setValue(self.steps_Taken)
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
        
    }
    
    func steps_label(){
        if steps_Taken == nil{
            self.txtStepsQuote.text = "You have walked: 0 steps today!"
        }
    }
}
