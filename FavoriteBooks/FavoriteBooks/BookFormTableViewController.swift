//
//  BookFormTableViewController.swift
//  FavoriteBooks
//
//  Created by Viktor Khotimchenko on 2021-02-09.
//

import UIKit

// can't connect a label in a prototype cell to an IBOutlet in a UIViewController subclass
// have to connect it to an IBOutlet in a UITableviewCell subclass.

class BookFormTableViewController: UITableViewController {
    @IBOutlet var titleField: UITextField!
    @IBOutlet var authorField: UITextField!
    @IBOutlet var genreField: UITextField!
    @IBOutlet var lengthField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func save(_ sender: UIButton) {
    }
}
