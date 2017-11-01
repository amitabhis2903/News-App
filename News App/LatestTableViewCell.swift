//
//  LatestTableViewCell.swift
//  News App
//
//  Created by Ammy Pandey on 06/08/17.
//  Copyright © 2017 Ammy Pandey. All rights reserved.
//

import UIKit

class LatestTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var discriptionLbl: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
}
