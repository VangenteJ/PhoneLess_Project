//
//  PerformanceController.swift
//  PhoneLess_Project
//
//  Created by Joel Vangente on 25/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseAuth

class PerformanceController: UIViewController {
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var segMonthDay: UISegmentedControl!
    @IBOutlet weak var lblMonthToSearch: UILabel!
    @IBOutlet weak var overaltargetmettittle: UILabel!
    
    @IBOutlet weak var pie_chart_time: PieChartView!
    @IBOutlet weak var pie_chart_steps: PieChartView!
    @IBOutlet weak var pie_chart_main: PieChartView!
    
    var performanceTime = PieChartDataEntry(value: 0)
    var offTime = PieChartDataEntry(value: 0)
    
    var performanceStep = PieChartDataEntry(value: 0)
    var offStep = PieChartDataEntry(value: 0)
    
    var stepsTaken = PieChartDataEntry(value: 0)
    var timeOut = PieChartDataEntry(value: 0)
    
    var timeOFF = [PieChartDataEntry]()
    var steps = [PieChartDataEntry]()
    var time_Steps = [PieChartDataEntry]()
    
    var userID = Auth.auth().currentUser?.uid
    var ref:DatabaseReference!
    var handle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        get_chart_data_fromDB()

        // Do any additional setup after loading the view.
    }
    
    

    func firstChart(dataOn:Double, dataOff:Double){
        pie_chart_time.chartDescription?.text = "Steps"
        
        performanceTime.value = dataOn
        performanceTime.label = "On Target"
        
        offTime.value = dataOff
        offTime.label = "Off"
        
        timeOFF = [performanceTime, offTime]
        pie_chart_time.holeColor = UIColor.black
        updateChartData()
    }
    
    func secondChart(dataOn:Double, dataOff:Double){
        pie_chart_steps.chartDescription?.text = "Time OFF"
        
        performanceStep.value = dataOn
        performanceStep.label = "On Target"
        
        offStep.value = dataOff
        offStep.label = "Off"
        
        steps = [performanceStep, offStep]
        
        pie_chart_steps.holeColor = UIColor.black
        updateSecondChartData()
    }
    
    func thirdChart(dataS:Double, dataT:Double){
        pie_chart_main.chartDescription?.text = "Time and Steps"
        
        stepsTaken.value = dataS
        stepsTaken.label = "Steps Taken"
        
        timeOut.value = dataT
        timeOut.label = "Time Off"
        
        time_Steps = [stepsTaken, timeOut]
        
        pie_chart_main.holeColor = UIColor.black
        updateMainChartData()
    }
    
    func updateChartData(){
        let chartDataSet = PieChartDataSet(values: timeOFF, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.blue]
        chartDataSet.colors = colors
        
        pie_chart_time.data = chartData
    }
    
    func updateSecondChartData(){
        let chartDataSet = PieChartDataSet(values: steps, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.blue]
        chartDataSet.colors = colors
        
        pie_chart_steps.data = chartData
    }
    
    func updateMainChartData(){
        let chartDataSet = PieChartDataSet(values: time_Steps, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.blue]
        chartDataSet.colors = colors
        
        pie_chart_main.data = chartData
    }
    
    func get_chart_data_fromDB(){
        let time = "Time1"
        let steps = "Step1"
        handle = ref?.child(userID!).child(time).observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil{
                let timeData = snapshot.value as? Double
                
                self.handle = self.ref?.child(self.userID!).child("Daily Time OFF Goal").observe(.value, with: { (snapshot) in
                    if snapshot.value as? String != nil{
                        let timeGoal = snapshot.value as? Double
                        var off = Int(timeData! - timeGoal!)
                        if off < 0 {
                            off = 0
                            self.secondChart(dataOn: timeData!, dataOff: Double(off))
                            
                        }
                    }
                })
                
            self.handle = self.ref?.child(self.userID!).child(steps).observe(.value, with: { (snapshot) in
                if snapshot.value as? String != nil{
                    let stepsData = snapshot.value as? Double
                    
                    self.handle = self.ref?.child(self.userID!).child("Daily Steps Goal").observe(.value, with: { (snapshot) in
                        if snapshot.value as? String != nil{
                            let stepsGoal = snapshot.value as? Double
                            var off = Int(stepsData! - stepsGoal!)
                            if off < 0 {
                                off = 0
                                self.firstChart(dataOn: stepsData!, dataOff: Double(off))
                            }
                        }
                    })
                    self.thirdChart(dataS: stepsData!, dataT: timeData!)
                }
            })
            }else{
                self.firstChart(dataOn: 0, dataOff: 0)
                self.secondChart(dataOn: 0, dataOff: 0)
                self.thirdChart(dataS: 0, dataT: 0)
            }
        })
    }
}
