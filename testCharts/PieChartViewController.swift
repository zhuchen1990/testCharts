//
//  PieChartViewController.swift
//  testCharts
//
//  Created by 朱晨 on 16/6/16.
//  Copyright © 2016年 朱晨. All rights reserved.
//

import UIKit
import Charts
class PieChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bar Chart"
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = .None
        let pieChartView = PieChartView(frame: CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - 64))
        pieChartView.data = self.initData()
        pieChartView.drawHoleEnabled = true
        //设置中间hole的api
//        pieChartView.holeRadiusPercent = 0.2
//        pieChartView.holeColor = UIColor.clearColor()
        pieChartView.transparentCircleRadiusPercent = 0.24
//        pieChartView.drawSlicesUnderHoleEnabled = true
//        pieChartView.legend.enabled = true
        pieChartView.drawSliceTextEnabled = false
        pieChartView.rotationEnabled = false
        pieChartView.highlightPerTapEnabled = false
        pieChartView.animate(yAxisDuration: 1.5, easingOption: .EaseInOutBack)
        
        let legend = pieChartView.legend
        legend.position = .LeftOfChart
        
        self.view.addSubview(pieChartView)
        
        // Do any additional setup after loading the view.
    }
    
    func initData() -> PieChartData{
        //x轴标注必须是字符串的数组否则无法显示标注
        let xVals = ["PartA","PartB","PartC","PartD","PartE"]
        var yVals = Array<BarChartDataEntry>()
        for index in 0..<xVals.count {
            let val = Double(arc4random()%100)
            //注意这里是BarChartDataEntry
            let dataEntry = BarChartDataEntry(value: val, xIndex: index)
            
            yVals.append(dataEntry)
        }
        
        let set = PieChartDataSet(yVals: yVals, label: "Set")
        set.setColors(ChartColorTemplates.joyful(), alpha: 1)
//        数据间距
        set.sliceSpace = 2
        let dataSet = [set]
        let pieChartData = PieChartData(xVals: xVals, dataSets: dataSet)
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .PercentStyle
        formatter.multiplier = 1.0
        formatter.percentSymbol = " %"
        //最大分数比例
        formatter.maximumFractionDigits = 1;

        pieChartData.setValueFormatter(formatter)
        pieChartData.setValueTextColor(UIColor.blackColor())
        return pieChartData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
