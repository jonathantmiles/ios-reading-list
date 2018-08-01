//
//  BookController.swift
//  Reading List
//
//  Created by Jonathan T. Miles on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            NSLog("Books not encoded: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("Books not decoded: \(error)")
        }
    }
    
    // Create
    
    func createBook(withTitle title: String, reasonToRead: String) {
        let book = Book(withTitle: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore() // saves the newly created book to persistent memory
    }
    
    // Update
    
    func updateHasBeenRead(for book: Book) { // toggles hasBeenRead
        var book = book
        guard let index = books.index(of: book) else { return }
        book.hasBeenRead = !book.hasBeenRead
        books.remove(at: index)
        books.insert(book, at: index)
        
        saveToPersistentStore() // saves toggled status to memory
    }
    
    func updateBookParameters(for book: Book, toTitle title: String, reasonToRead: String) {
        var book = book
        guard let index = books.index(of: book) else { return }
        book.title = title
        book.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(book, at: index)
        
        saveToPersistentStore() // saves new parameters to memory
    }
    
    // Delete
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore() // saves the deletion to memory
    }
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent("ReadingList.plist")
    }
    
    // MARK: - Properties
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true } // $0 is the item being checked in the filter loop
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false } // so as above, the .hasBeenRead value can be checked
    }
    
    // Read
    var books: [Book] = []
}
