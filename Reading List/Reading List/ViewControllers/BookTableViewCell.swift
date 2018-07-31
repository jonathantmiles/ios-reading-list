//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jonathan T. Miles on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell, BookTableViewCellDelegate {

    func updateViews () {
        guard let title = book?.title,
            let hasBeenRead = book?.hasBeenRead else { return }
        bookTitleLabel.text = title
        if hasBeenRead == true {
            isReadChecked.setImage(UIImage(named: "checked"), for: .normal)
        } else if hasBeenRead == false {
            isReadChecked.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBAction func checkIsRead(_ sender: Any) {
        toggleHasBeenRead(for: self) 
    }
    
    // MARK: - Properties
    
    var book: Book? {
        updateViews()
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var isReadChecked: UIButton!
    
}
