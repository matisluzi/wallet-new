
//
//  CustomCell.swift
//  wallet-new
//
//  Created by Matis Luzi on 9/20/19.
//  Copyright © 2019 Matis Luzi. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var itemDate: UILabel!
    @IBOutlet var itemValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showCellData(name:String, date:String, amount:String) {
            itemTitle.text = name
            itemDate.text = date
        itemValue.text = amount + " " + ViewController().currency
    }

    
}
