//
//  BarChartViewController.swift
//  testCharts
//
//  Created by 朱晨 on 16/6/15.
//  Copyright © 2016年 朱晨. All rights reserved.
//

import UIKit
import Charts
class BarChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bar Chart"
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = .None
        let barChartView = BarChartView(frame: CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - 64))
        barChartView.data = self.initData()
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = true
        barChartView.maxVisibleValueCount = 12
        
        let xAxis = barChartView.xAxis;
        xAxis.labelPosition = .Bottom
        xAxis.labelFont = UIFont.systemFontOfSize(10)
        xAxis.drawGridLinesEnabled = false;
        xAxis.spaceBetweenLabels = 2;
//        xAxis.labelRotationAngle = 45
        
        let leftYAxis = barChartView.leftAxis
        leftYAxis.axisMinValue = 0
        leftYAxis.spaceTop = 0.15
        leftYAxis.valueFormatter = NSNumberFormatter()
        leftYAxis.valueFormatter?.positiveSuffix = " ¥"
        leftYAxis.valueFormatter?.maximumFractionDigits = 1
        barChartView.rightAxis.enabled = false
        self.view.addSubview(barChartView)
    }
    
    
    func initData() -> BarChartData{
        //x轴标注必须是字符串的数组否则无法显示标注
        let xVals = ["5","10","15","20","25","30","35","40","45","50","55"]
        var yVals = Array<BarChartDataEntry>()
        for index in 0..<xVals.count {
            let val = Double(arc4random()%100)
            let dataEntry = BarChartDataEntry(value: val, xIndex: index)
            
            yVals.append(dataEntry)
        }
        
        let set = BarChartDataSet(yVals: yVals, label: "Set")
        set.barSpace = 0.35
        set.setColors(ChartColorTemplates.material(), alpha: 1)
        let dataSet = [set]
        let barChartData = BarChartData(xVals: xVals, dataSets: dataSet)
        return barChartData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
