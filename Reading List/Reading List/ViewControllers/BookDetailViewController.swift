//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jonathan T. Miles on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    @IBAction func saveBook(_ sender: Any) {
        guard let bookTitle = titleTextField.text,
            let reasonToRead = reasonTextView.text else { return }
        
        if book == nil {
            bookController?.createBook(withTitle: bookTitle, reasonToRead: reasonToRead)
        } else {
            guard let book = book else { return }
            bookController?.updateBookParameters(for: book, toTitle: bookTitle, reasonToRead: reasonToRead)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        if book != nil {
            guard let title = book?.title,
                let reasonToRead = book?.reasonToRead else { return }
            titleTextField.text = title
            reasonTextView.text = reasonToRead
            self.title = title
        } else {
            self.title = "Add a new book"
        }
    }

    // MARK: - Properties
    
    var bookController: BookController?
    
    var book: Book? 
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var reasonTextView: UITextView!
    
}
