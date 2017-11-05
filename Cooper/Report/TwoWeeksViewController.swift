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
    
    let reportService = ReportService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        barChartUpdate ()
    }
    

    func barChartUpdate () {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        var xAxis = [String]()
        var calcuDate = Calendar.current.date(byAdding: .day, value: -13, to: Date())
        for _ in 1...14 {
            let calculDate = formatter.string(from: calcuDate!)
            xAxis.append(calculDate)
            calcuDate = Calendar.current.date(byAdding: .day, value: +1, to: calcuDate!)
        }
        let dataSet = BarChartDataSet(values: reportService.getTwoWeeks(), label: "")
        barChart.chartDescription?.text = "Expenditure"
        if reportService.getPaymentData().isEmpty {
            barChart.chartDescription?.text = "Expenditure\n(No data)"
        }
        barChart.chartDescription?.font = UIFont(name: "Futura", size: 15)!
        barChart.chartDescription?.xOffset = barChart.frame.width * (1/4)
        barChart.chartDescription?.yOffset = barChart.frame.height * (7/10)
        barChart.chartDescription?.textAlign = NSTextAlignment.left
//        barChart.chartDescription?.text = "test"
//        barChart.chartDescription?.position?.x = 10
//        barChart.chartDescription?.position?.y = 10
        barChart.xAxis.labelPosition = .bottom
        barChart.rightAxis.enabled = false
        barChart.xAxis.axisMinimum = 0.0
        barChart.xAxis.axisMaximum = 13.0
        barChart.xAxis.granularity = 2.0
        barChart.xAxis.granularityEnabled = true
        barChart.xAxis.labelCount = 14
        barChart.fitBars = true
        let data = BarChartData(dataSets: [dataSet])
        barChart.data = data
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:xAxis)
//        barChart.drawValueAboveBarEnabled = false
    
        //All other additions to this function will go here
        dataSet.colors = ChartColorTemplates.joyful()
        dataSet.valueColors = [UIColor.black]
        //This must stay at end of function
        barChart.notifyDataSetChanged()
    }
    
}
