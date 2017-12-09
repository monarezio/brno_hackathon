//
//  TrashHistoryController.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 09/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseDatabase

class TrashHistoryController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: LineChartView!
    
    var uuid: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Filled Line Chart"
        
        chartView.delegate = self
        
        chartView.backgroundColor = .white
        chartView.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
        chartView.drawGridBackgroundEnabled = true
        
        chartView.drawBordersEnabled = true
        
        chartView.chartDescription?.enabled = false
        
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        chartView.legend.enabled = false
        
        chartView.xAxis.enabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.drawAxisLineEnabled = false
        
        chartView.rightAxis.enabled = false
        
        if let uuid = self.uuid {
            let ref = Database.database().reference()
            ref.child("reading/\(uuid)").queryOrdered(byChild: "timestamp").queryLimited(toLast: 10).observe(DataEventType.value, with: { (snapshot) in
                
                print("\(snapshot.value)")
                
                //updateChart()
            })
        }
        
        // Do any additional setup after loading the view.
    }
    
    func updateChart(data: [String]) {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<10 {
            let value = ChartDataEntry(x: Double(i), y: Double(i) * 2.0)
            
            lineChartEntry.append(value)
        }
        
        let line = LineChartDataSet(values: lineChartEntry, label: "Number xd")
        line.colors = [UIColor.red]
        
        let data = LineChartData()
        
        data.addDataSet(line)
        
        chartView.data = data
    }
}
