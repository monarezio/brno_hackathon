//
//  TrashesViewController.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 09/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class TrashesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var ref: DatabaseReference!
    
    private var arr: [(String, String)] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        row.uuidLabel.text = arr[indexPath.item].0
        row.statusLabel.text = "\(arr[indexPath.item].1)%"
        
        let status = Int(arr[indexPath.item].1)
        if(status! > 40 && status! < 60) {
            row.bacgkroundStatus.backgroundColor = UIColor(red: 100.0 / 255, green: 76.0 / 255, blue: 3.0 / 255, alpha: 0.75)
        }
        else if(status! > 50) {
            row.bacgkroundStatus.backgroundColor = UIColor(red: 16.0 / 255, green: 65.0 / 255, blue: 27.0 / 255, alpha: 0.75)
        } else {
            row.bacgkroundStatus.backgroundColor = UIColor(red: 86.0 / 255, green: 21.0 / 255, blue: 27.0 / 255, alpha: 0.75)
        }
        
        return row
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        ref.child("/analysis/sorted").observe(DataEventType.value) { (snapshot) in
            let newData = snapshot.value as? [String : AnyObject] ?? [:]
            
            self.arr = []
            
            newData.forEach({ i in
                let a = i.value as! [String: Any]
                let b = Int(Float("\(a["percentage"]!)")!)
                
                self.arr.append((i.key, "\(b)"))
            })
            
            self.tableView.reloadData()
        }
    
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
}
