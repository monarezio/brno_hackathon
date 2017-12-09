//
//  TableViewCell.swift
//  Smart Trash
//
//  Created by Samuel Kodytek on 09/12/2017.
//  Copyright © 2017 Samuel Kodytek. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    @IBOutlet weak var bacgkroundStatus: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
