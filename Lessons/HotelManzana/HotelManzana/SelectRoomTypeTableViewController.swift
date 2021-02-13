//
//  SelectRoomTypeTableViewController.swift
//  HotelManzana
//
//  Created by Viktor Khotimchenko on 2021-02-12.
//

import UIKit

protocol SelectRoomTypeTableViewControllerDelegate: AnyObject {
    func selectRoomTypeTableViewController(
        _ controller: SelectRoomTypeTableViewController,
        didSelect roomType: RoomType)
}

class SelectRoomTypeTableViewController: UITableViewController {
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?

    var roomType: RoomType?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        let roomType = RoomType.all[indexPath.row]

        cell.accessoryType = roomType == self.roomType ? .checkmark : .none

        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$ \(roomType.price)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let roomType = RoomType.all[indexPath.row]
        self.roomType = roomType
        delegate?.selectRoomTypeTableViewController(self, didSelect: roomType)
        tableView.reloadData()
    }
}
