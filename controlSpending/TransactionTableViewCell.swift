//
//  TransactionTableViewCell.swift
//  controlSpending
//
//  Created by Sherry Chan on 4/26/18.
//  Copyright © 2018 Sherry Chan. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
