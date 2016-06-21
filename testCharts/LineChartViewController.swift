//
//  ViewController.swift
//  testCharts
//
//  Created by 朱晨 on 16/6/14.
//  Copyright © 2016年 朱晨. All rights reserved.
//

import UIKit
import Charts
class LineChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Line Chart"
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = .None
        
        let lineChatView = LineChartView(frame: CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - 64))
        lineChatView.delegate = self
        lineChatView.descriptionText = "none"
        //支持手势👍
        lineChatView.dragEnabled = true
        //scale 和 gesture 要配合使用
        lineChatView.pinchZoomEnabled = true
        lineChatView.setScaleEnabled(true)
        //栅格背景色
        lineChatView.drawGridBackgroundEnabled = true
       //数据标签
        let marker = BalloonMarker(color: UIColor.brownColor(), font: UIFont.systemFontOfSize(12), insets: UIEdgeInsetsMake(8, 8, 8, 8))
        marker.minimumSize = CGSizeMake(60, 40)
        lineChatView.marker = marker
        

        lineChatView.rightAxis.enabled = false
        
        //图表下方的标注样式 dataLable的标签
        lineChatView.legend.form = .Line
        //animation
        lineChatView.animate(xAxisDuration: 2.5, easingOption: .EaseInOutQuart)
        
        let lineChatData = self.initData()
        lineChatView.data = lineChatData
        self.view.addSubview(lineChatView)

        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() -> LineChartData{
        //x轴标注必须是字符串的数组否则无法显示标注
        let xVals = ["5","10","15","20","25","30","35","40","45","50","55"]
        var yVals = Array<ChartDataEntry>()
        for index in 0..<xVals.count {
            let val = Double(arc4random()%100)
            let dataEntry = ChartDataEntry(value: val, xIndex: index)
            
            yVals.append(dataEntry)
        }
        
        let set = LineChartDataSet(yVals: yVals, label: "Set")
        //绘制虚线
        set.lineDashLengths = [5.0,2.5]
        set.highlightLineDashLengths = [5.0,2.5]
        
        set.lineWidth = 1
        set.setColor(UIColor.blackColor())
        set.circleRadius = 3.0
        set.drawCircleHoleEnabled = false
        set.setCircleColor(UIColor.cyanColor())
        
        //渐进色填充
        let gradientColors = [ChartColorTemplates .colorFromString("#00ff0000").CGColor,ChartColorTemplates .colorFromString("#ffff0000").CGColor]
        let gradient = CGGradientCreateWithColors(nil, gradientColors as CFArray, nil)
        set.fill = ChartFill.fillWithLinearGradient(gradient!, angle: 90.0)
        set.fillAlpha = 0.8
        set.drawFilledEnabled = true
        //在swift自动管理内存无需释放
        //只有一组数据
        let dataSet = [set]
        let lineChatData = LineChartData(xVals: xVals, dataSets: dataSet)
        return lineChatData
    }
}



extension LineChartViewController : ChartViewDelegate{
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("点击数据点")
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("点击数据点以外的地方")
    }

}

