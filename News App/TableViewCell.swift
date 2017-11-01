//
//  TableViewCell.swift
//  News App
//
//  Created by Ammy Pandey on 24/07/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var newsImg: UIImageView!

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var discriptionLbl: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
