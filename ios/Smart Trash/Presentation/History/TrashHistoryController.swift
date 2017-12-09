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
        chartView.gridBackgroundColor = UIColor.white
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
            ref.child("reading/\(uuid)")
                .observe(DataEventType.value, with: { (snapshot) in
                
                
                
                let almostData = snapshot.value as! [String: Any]
                var arr: [(Double, String)] = []
                almostData.forEach({ (i) in
                    
                    let val = i.value as! [String : Any]
                    arr.append((Double(val["percentage"] as! String)!, val["timestamp"] as! String))
                    arr = arr.sorted(by: { (i, j) -> Bool in
                        i.1 >= j.1
                    })
                })
                
                    var boundaries = 30
                    
                    if(arr.count < 30) {
                        boundaries = arr.count
                    }
                    
                    let finalArr: [Double] = arr[0..<boundaries].map { i in
                        i.0
                    }.reversed()
                    
                    self.updateChart(data: finalArr)
            })
        }
        
        // Do any additional setup after loading the view.
    }
    
    func updateChart(data: [Double]) {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<data.count {
            let value = ChartDataEntry(x: Double(i), y: data[i])
            
            lineChartEntry.append(value)
        }
        
        let line = LineChartDataSet(values: lineChartEntry, label: "")
        line.colors = [UIColor.red]
        line.circleColors = [UIColor.black]
        line.circleRadius = 1.0
        
        let data = LineChartData()
        
        data.addDataSet(line)
        
        chartView.data = data
    }
}
