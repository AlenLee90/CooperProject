//
//  TwoWeeksViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/11/4.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import Charts

class TwoWeeksViewController: UIViewController {
    
    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        barChartUpdate ()
    }
    

    func barChartUpdate () {
        let entry1 = BarChartDataEntry(x: 1.0, y: Double(19.0))
        let entry2 = BarChartDataEntry(x: 2.0, y: Double(50.0))
        let entry3 = BarChartDataEntry(x: 3.0, y: Double(100.7))
        let entry4 = BarChartDataEntry(x: 4.0, y: Double(19.0))
        let entry5 = BarChartDataEntry(x: 5.0, y: Double(50.0))
        let entry6 = BarChartDataEntry(x: 6.0, y: Double(80.7))
        let entry7 = BarChartDataEntry(x: 7.0, y: Double(19.0))
        let entry8 = BarChartDataEntry(x: 8.0, y: Double(50.0))
        let entry9 = BarChartDataEntry(x: 9.0, y: Double(100.7))
        let entry10 = BarChartDataEntry(x: 10.0, y: Double(19.0))
        let entry11 = BarChartDataEntry(x: 11.0, y: Double(50.0))
        let entry12 = BarChartDataEntry(x: 12.0, y: Double(80.7))
        let entry13 = BarChartDataEntry(x: 13.0, y: Double(50.0))
        let entry14 = BarChartDataEntry(x: 14.0, y: Double(80.7))
        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3,entry4,entry5,entry6,entry7,entry8,entry9,entry10,entry11,entry12,entry13,entry14], label: "")
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        let months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13","14"]
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:months)
        barChart.chartDescription?.text = ""
    
        //All other additions to this function will go here
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueColors = [UIColor.black]
        //This must stay at end of function
        barChart.notifyDataSetChanged()
    }
    
}
