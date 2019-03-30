//
//  SettingController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit

class SettingController: UIViewController {

    @IBOutlet weak var viewSetGoals: UIView!
    @IBOutlet weak var uiviewViewGoals: UIView!
    @IBOutlet weak var uiviewChangeDetails: UIView!
    @IBOutlet weak var stckImageStack: UIStackView!
    @IBOutlet weak var btnSetGoals: UIButton!
    @IBOutlet weak var btnDisplayGoals: UIButton!
    @IBOutlet weak var btnChangeDetails: UIButton!
    @IBOutlet weak var btnUpdateImage: UIButton!
    @IBOutlet weak var imgimageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_up()

        // Do any additional setup after loading the view.
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

}
