//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jonathan T. Miles on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBook(_ sender: Any) {
        guard let title = book?.title,
            let reasonToRead = book?.reasonToRead else { return }
        if book != nil {
            guard let book = book else { return }
            bookController?.updateBookParameters(for: book, toTitle: title, reasonToRead: reasonToRead)
        } else {
            bookController?.createBook(withTitle: title, reasonToRead: reasonToRead)
        }
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Properties
    
    var bookController: BookController?
    
    var book: Book?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var reasonTextView: UITextView!
    
}
