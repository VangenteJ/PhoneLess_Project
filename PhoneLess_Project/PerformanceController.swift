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
    
    // setting up variables
    @IBOutlet weak var segMonthDay: UISegmentedControl!
    @IBOutlet weak var lblMonthToSearch: UILabel!
    @IBOutlet weak var overaltargetmettittle: UILabel!
    @IBOutlet weak var btnGoBack: UIButton!
    @IBOutlet weak var btnGoForth: UIButton!
    
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
    
    var timeDA = "Time1"
    var stepsDA = "Steps1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        get_chart_data_fromDB()
        
    }
    
    // Setting up the first chart
    func firstChart(dataOn:Double, dataOff:Double){
        pie_chart_time.chartDescription?.text = "Steps"
        
        performanceTime.value = dataOn
        performanceTime.label = ""
        
        offTime.value = dataOff
        offTime.label = ""
        
        timeOFF = [performanceTime, offTime]
        pie_chart_time.holeColor = UIColor.black
        updateChartData()
    }
    
    // Setting up the second chart
    func secondChart(dataOn:Double, dataOff:Double){
        pie_chart_steps.chartDescription?.text = "Time OFF"
        
        performanceStep.value = dataOn
        performanceStep.label = ""
        
        offStep.value = dataOff
        offStep.label = ""
        
        steps = [performanceStep, offStep]
        
        pie_chart_steps.holeColor = UIColor.black
        updateSecondChartData()
    }
    
    // Setting up the third chart
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
    
    // Updating the first chart data
    func updateChartData(){
        let chartDataSet = PieChartDataSet(values: timeOFF, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.blue]
        chartDataSet.colors = colors
        
        pie_chart_time.data = chartData
    }
    
    // Updating the second chart data
    func updateSecondChartData(){
        let chartDataSet = PieChartDataSet(values: steps, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.blue]
        chartDataSet.colors = colors
        
        pie_chart_steps.data = chartData
    }
    
    // Updating the third chart data
    func updateMainChartData(){
        let chartDataSet = PieChartDataSet(values: time_Steps, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.blue]
        chartDataSet.colors = colors
        
        pie_chart_main.data = chartData
    }
    
    // Getting details from DB to later populate the charts
    func get_chart_data_fromDB(){
        handle = ref?.child(userID!).child(timeDA).observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil{
                let timeData = snapshot.value as! String
                let timeDa = Int(timeData)
                
                self.handle = self.ref?.child(self.userID!).child("Daily Time OFF Goal").observe(.value, with: { (snapshot) in
                    if snapshot.value as? String != nil{
                        let timeGoal = snapshot.value as! String
                        let timeGo = Int(timeGoal)
                        let off = Double(timeGo! - timeDa!)
                        self.secondChart(dataOn: Double(timeDa!), dataOff: Double(off))
                    }
                })
                
                self.handle = self.ref?.child(self.userID!).child(self.stepsDA).observe(.value, with: { (snapshot) in
                if snapshot.value as? String != nil{
                    let stepsData = snapshot.value as! String
                    let stepsDa = Int(stepsData)
                    
                    self.handle = self.ref?.child(self.userID!).child("Daily Steps Goal").observe(.value, with: { (snapshot) in
                        if snapshot.value as? String != nil{
                            let stepsGoal = snapshot.value as! String
                            let stepsGo = Int(stepsGoal)
                            print("stepgo")
                            print(stepsGo!)
                            let off = Double(stepsGo! - stepsDa!)
                            self.firstChart(dataOn: Double(stepsDa!), dataOff: Double(off))
                        }
                    })
                    self.thirdChart(dataS: Double(stepsDa!), dataT: Double(timeDa!))
                }
            })
            }else{
                // Populate the chart with 0 if no data found in database
                self.firstChart(dataOn: 0, dataOff: 0)
                self.secondChart(dataOn: 0, dataOff: 0)
                self.thirdChart(dataS: 0, dataT: 0)
            }
        })
    }
    
    // Function that allows user to navigate backwards
    @IBAction func search_back(_ sender: Any) {
        if segMonthDay.selectedSegmentIndex == 0{
            if stepsDA == "Steps5" && timeDA == "Time5"{
                stepsDA = "Steps4"
                timeDA = "Time4"
                lblMonthToSearch.text = "05-02-19"
                get_chart_data_fromDB()
                
            }else if stepsDA == "Steps4" && timeDA == "Time4"{
                stepsDA = "Steps3"
                timeDA = "Time3"
                lblMonthToSearch.text = "04-02-19"
                get_chart_data_fromDB()
                
            }else if stepsDA == "Steps3" && timeDA == "Time3"{
                stepsDA = "Steps2"
                timeDA = "Time2"
                lblMonthToSearch.text = "03-02-19"
                get_chart_data_fromDB()
                
            }else if stepsDA == "Steps2" && timeDA == "Time2"{
                stepsDA = "Steps1"
                timeDA = "Time1"
                lblMonthToSearch.text = "02-02-19"
                get_chart_data_fromDB()
            }
        }else{
            if stepsDA == "Week2Steps" && timeDA == "Week2Time"{
                stepsDA = "Week1Steps"
                timeDA = "Week1Time"
                lblMonthToSearch.text = "March"
                get_chart_data_fromDB()
            }
        }
    }
    
    // Function that allows users navigate forward
    @IBAction func search_forward(_ sender: Any) {
        if segMonthDay.selectedSegmentIndex == 0{
            if stepsDA == "Steps1" && timeDA == "Time1"{
                stepsDA = "Steps2"
                timeDA = "Time2"
                lblMonthToSearch.text = "03-02-19"
                get_chart_data_fromDB()
            }else if stepsDA == "Steps2" && timeDA == "Time2"{
                stepsDA = "Steps3"
                timeDA = "Time3"
                lblMonthToSearch.text = "04-02-19"
                get_chart_data_fromDB()
                
            }else if stepsDA == "Steps3" && timeDA == "Time3"{
                stepsDA = "Steps4"
                timeDA = "Time4"
                lblMonthToSearch.text = "05-02-19"
                get_chart_data_fromDB()
                
            }else if stepsDA == "Steps4" && timeDA == "Time4"{
                stepsDA = "Steps5"
                timeDA = "Time5"
                lblMonthToSearch.text = "20-02-19"
                get_chart_data_fromDB()
            }
        }else{
            if stepsDA == "Week1Steps" && timeDA == "Week1Time"{
                stepsDA = "Week2Steps"
                timeDA = "Week2Time"
                lblMonthToSearch.text = "April"
                get_chart_data_fromDB()
            }
        }
    }
    
    // Function that changes display from days to months
    @IBAction func segueDay_Month(_ sender: Any) {
        if segMonthDay.selectedSegmentIndex == 0{
            stepsDA = "Steps5"
            timeDA = "Time5"
            lblMonthToSearch.text = "20-02-19"
            get_chart_data_fromDB()
        }else{
            stepsDA = "Week2Steps"
            timeDA = "Week2Time"
            lblMonthToSearch.text = "April"
            get_chart_data_fromDB()
        }
    }
}
