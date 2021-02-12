//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Viktor Khotimchenko on 2021-02-11.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!

    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday

        updateDateViews()
    }

    @IBAction func onDoneBarButtonTap(_ sender: UIBarButtonItem) {
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let email = emailField.text ?? ""
        let checkIn = checkInDatePicker.date
        let checkOut = checkOutDatePicker.date

        print("Done tapped")
        print("firstName:", firstName)
        print("lastName:", lastName)
        print("email:", email)
        print("checkIn:", checkIn)
        print("checkOut:", checkOut)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where
            isCheckInDatePickerVisible == false:
            print("a")
            return 0
        case checkOutDatePickerCellIndexPath where
            isCheckOutDatePickerVisible == false:
            print("b")
            return 0
        default:
            return UITableView.automaticDimension
        }
    }

    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)

    var isCheckInDatePickerVisible: Bool = false {
        didSet { checkInDatePicker.isHidden = !isCheckInDatePickerVisible }
    }

    var isCheckOutDatePickerVisible: Bool = false {
        didSet { checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible }
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    func updateDateViews() {
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }
}
