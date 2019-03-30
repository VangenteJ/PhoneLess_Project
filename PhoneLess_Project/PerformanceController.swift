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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstChart()
        secondChart()
        thirdChart()

        // Do any additional setup after loading the view.
    }
    
    

    func firstChart(){
        pie_chart_time.chartDescription?.text = ""
        
        performanceTime.value = 20.2
        performanceTime.label = "On Target"
        
        offTime.value = 10.3
        offTime.label = "Off"
        
        timeOFF = [performanceTime, offTime]
        pie_chart_time.holeColor = UIColor.black
        updateChartData()
    }
    
    func secondChart(){
        pie_chart_steps.chartDescription?.text = ""
        
        performanceStep.value = 90.5
        performanceStep.label = "On Target"
        
        offStep.value = 9.5
        offStep.label = "Off"
        
        steps = [performanceStep, offStep]
        
        pie_chart_steps.holeColor = UIColor.black
        updateSecondChartData()
    }
    
    func thirdChart(){
        pie_chart_main.chartDescription?.text = ""
        
        stepsTaken.value = 90.5
        stepsTaken.label = "Steps Taken"
        
        timeOut.value = 9.5
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
}
