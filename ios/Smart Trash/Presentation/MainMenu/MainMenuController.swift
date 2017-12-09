//
//  MainMenuControllerViewController.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 08/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit
import Darwin

class MainMenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let typeOfAnalysis = [("", "Trash"), ("", "Water"),  ("", "Polution"), ("", "Machines")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeOfAnalysis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.icon.text = typeOfAnalysis[indexPath.item].0
        cell.text.text = typeOfAnalysis[indexPath.item].1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(typeOfAnalysis[indexPath.item].1 == "Trash") {
            performSegue(withIdentifier: "listCells", sender: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
    }

}
