//
//  PerformanceController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Charts

class PerformanceController: UIViewController {
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var segMonthDay: UISegmentedControl!
    @IBOutlet weak var lblMonthToSearch: UILabel!
    @IBOutlet weak var overaltargetmettittle: UILabel!
    
    @IBOutlet weak var pie_chart_time: PieChartView!
    @IBOutlet weak var pie_chart_steps: PieChartView!
    @IBOutlet weak var pie_main_chart: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

}
