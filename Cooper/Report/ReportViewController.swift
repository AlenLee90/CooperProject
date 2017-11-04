//
//  ReportViewController.swift
//  Cooper
//
//  Created by 李亚男 on 2017/10/18.
//  Copyright © 2017年 李亚男. All rights reserved.
//

import UIKit
import Charts

class ReportViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var paymentPie: PieChartView!
    @IBOutlet weak var incomePie: PieChartView!
    
    var inputDetailModel :InputDetail?
    
    let reportService = ReportService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        barChartUpdate()
//        pieChartUpdate()
//        selectResultData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pieChartUpdate()
        selectResultData()
    }

//    func barChartUpdate () {
//        let entry1 = BarChartDataEntry(x: 1.0, y: Double(19.0))
//        let entry2 = BarChartDataEntry(x: 2.0, y: Double(50.0))
//        let entry3 = BarChartDataEntry(x: 3.0, y: Double(88.7))
//        let dataSet = BarChartDataSet(values: [entry1, entry2, entry3], label: "Widgets Type")
//        let data = BarChartData(dataSets: [dataSet])
//        barChart.data = data
//        barChart.chartDescription?.text = "Number of Widgets by Type"
//
//        //All other additions to this function will go here
//        dataSet.colors = ChartColorTemplates.joyful()
//        dataSet.valueColors = [UIColor.black]
//        //This must stay at end of function
//        barChart.notifyDataSetChanged()
//    }
    
    func pieChartUpdate () {

        let paymentDataSet = PieChartDataSet(values: reportService.getPaymentData(), label: "Payments")
        let paymentData = PieChartData(dataSet: paymentDataSet)
        paymentPie.data = paymentData
        paymentPie.chartDescription?.text = "Today's Payments"
        if reportService.getPaymentData().isEmpty {
            paymentPie.chartDescription?.text = "Today's Payments\n(No data)"
        }

        //All other additions to this function will go here
        paymentDataSet.colors = ChartColorTemplates.joyful()
        paymentDataSet.valueColors = [UIColor.black]
        paymentPie.backgroundColor = UIColor.white
        paymentPie.holeColor = UIColor.clear
        paymentPie.chartDescription?.textColor = UIColor.blue
        paymentPie.legend.textColor = UIColor.darkGray

        paymentPie.legend.font = UIFont(name: "Futura", size: 10)!
        paymentPie.chartDescription?.font = UIFont(name: "Futura", size: 12)!
        paymentPie.chartDescription?.xOffset = paymentPie.frame.width * (3/4)
        paymentPie.chartDescription?.yOffset = paymentPie.frame.height * (2/3)
        paymentPie.chartDescription?.textAlign = NSTextAlignment.left

        //This must stay at end of function
        paymentPie.notifyDataSetChanged()

        let incomeDataSet = PieChartDataSet(values: reportService.getIncomeData(), label: "Incomes")
        let incomeData = PieChartData(dataSet: incomeDataSet)
        incomePie.data = incomeData
        incomePie.chartDescription?.text = "Today's Incomes"
        if reportService.getIncomeData().isEmpty {
            incomePie.chartDescription?.text = "Today's Incomes\n(No data)"
        }

        //All other additions to this function will go here
        incomeDataSet.colors = ChartColorTemplates.joyful()
        incomeDataSet.valueColors = [UIColor.black]
        incomePie.backgroundColor = UIColor.white
        incomePie.holeColor = UIColor.clear
        incomePie.chartDescription?.textColor = UIColor.blue
        incomePie.legend.textColor = UIColor.darkGray

        incomePie.legend.font = UIFont(name: "Futura", size: 10)!
        incomePie.chartDescription?.font = UIFont(name: "Futura", size: 12)!
        incomePie.chartDescription?.xOffset = incomePie.frame.width * (3/4)
        incomePie.chartDescription?.yOffset = incomePie.frame.height * (2/3)
        incomePie.chartDescription?.textAlign = NSTextAlignment.left

        //This must stay at end of function
        incomePie.notifyDataSetChanged()
    }
    
    func selectResultData() {
        resultLabel.attributedText = reportService.selectResultData()
    }
}
