//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Jonathan T. Miles on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    func updateViews () {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        if book.hasBeenRead == true {
            isReadChecked.setImage(UIImage(named: "checked"), for: .normal)
        } else if book.hasBeenRead == false {
            isReadChecked.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @IBAction func checkIsRead(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    // MARK: - Properties
    
    var book: Book? {
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var isReadChecked: UIButton!
    
}
