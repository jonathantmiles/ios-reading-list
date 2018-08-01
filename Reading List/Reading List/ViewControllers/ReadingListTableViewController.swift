//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jonathan T. Miles on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return bookController.readBooks.count
        } else { // for section == 1; written this way to be exhaustive and satisfy the compiler
            return bookController.unreadBooks.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        guard let bookCell = cell as? BookTableViewCell else { return cell }
        bookCell.book = bookFor(indexPath: indexPath)
            
        bookCell.delegate = self
        
        return bookCell
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if segue.identifier == "AddNewBook" {
            guard let destVC = segue.destination as? BookDetailViewController else { return }
            destVC.bookController = bookController
        } else if segue.identifier == "ShowBookDetail" {
            guard let destVC = segue.destination as? BookDetailViewController else { return }
            destVC.bookController = bookController
            guard let index = tableView.indexPathForSelectedRow else { return }
            destVC.book = bookFor(indexPath: index)
        }
        
        // Pass the selected object to the new view controller.
    }
    

    // MARK: - Original Functions
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: index)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    // MARK: - Properties
    
    var bookController = BookController()
    
}
