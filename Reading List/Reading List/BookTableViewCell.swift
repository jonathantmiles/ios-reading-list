//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jonathan T. Miles on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checkIsRead(_ sender: Any) {
    }
    
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var isReadChecked: UIButton!
    
}
