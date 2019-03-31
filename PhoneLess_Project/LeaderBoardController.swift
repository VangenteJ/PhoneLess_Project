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
        chechImages()
        
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
