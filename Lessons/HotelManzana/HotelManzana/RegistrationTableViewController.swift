//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Viktor Khotimchenko on 2021-02-13.
//

import UIKit

class RegistrationTableViewController: UITableViewController {
    var registrations = [Registration]()

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        let registration = registrations[indexPath.row]
        let checkInDate = dateFormatter.string(from: registration.checkInDate)
        let checkOutDate = dateFormatter.string(from: registration.checkOutDate)

        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)"
        cell.detailTextLabel?.text = "\(checkInDate) - \(checkOutDate): \(registration.roomType.name)"

        return cell
    }

    @IBAction func unwindFromAddRegistration(_ unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
              let registration = addRegistrationTableViewController.registration
        else { return }

        registrations.append(registration)
        tableView.reloadData()
    }
}
