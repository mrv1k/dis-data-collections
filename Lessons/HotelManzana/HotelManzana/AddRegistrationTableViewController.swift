//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Viktor Khotimchenko on 2021-02-11.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday

        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }

    @IBAction func onDoneBarButtonTap(_ sender: UIBarButtonItem) {
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let email = emailField.text ?? ""
        let checkIn = checkInDatePicker.date
        let checkOut = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        let roomChoice = roomType?.name ?? "Not Set"

        print("Done tapped")
        print("firstName:", firstName)
        print("lastName:", lastName)
        print("email:", email)
        print("checkIn:", checkIn)
        print("checkOut:", checkOut)
        print("numberOfAdults:", numberOfAdults)
        print("numberOfChildren:", numberOfChildren)
        print("hasWifi:", hasWifi)
        print("roomChoice:", roomChoice)
    }

    @IBOutlet var checkInDateLabel: UILabel!
    @IBOutlet var checkInDatePicker: UIDatePicker!
    @IBOutlet var checkOutDateLabel: UILabel!
    @IBOutlet var checkOutDatePicker: UIDatePicker!

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }

    func updateDateViews() {
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
    }

    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)

    var isCheckInDatePickerVisible: Bool = false {
        didSet { checkInDatePicker.isHidden = !isCheckInDatePickerVisible }
    }

    var isCheckOutDatePickerVisible: Bool = false {
        didSet { checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where isCheckInDatePickerVisible == false:
            return 0
        case checkOutDatePickerCellIndexPath where isCheckOutDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath == checkInDateLabelCellIndexPath && isCheckOutDatePickerVisible == false {
            // check-in label selected, check-out picker is not
            // visible, toggle check-in picker”
            isCheckInDatePickerVisible.toggle()
        } else if indexPath == checkOutDateLabelCellIndexPath && isCheckInDatePickerVisible == false {
            // check-out label selected, check-in picker is not
            // visible, toggle check-out picker”
            isCheckOutDatePickerVisible.toggle()
        } else if indexPath == checkInDateLabelCellIndexPath || indexPath == checkOutDateLabelCellIndexPath {
            // either label was selected, previous conditions failed
            // meaning at least one picker is visible, toggle both”
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        } else {
            return
        }

        tableView.beginUpdates()
        tableView.endUpdates()
    }

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    @IBOutlet var numberOfAdultsLabel: UILabel!
    @IBOutlet var numberOfAdultsStepper: UIStepper!
    @IBOutlet var numberOfChildrenLabel: UILabel!
    @IBOutlet var numberOfChildrenStepper: UIStepper!

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
    }

    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = String(Int(numberOfAdultsStepper.value))
        numberOfChildrenLabel.text = String(Int(numberOfChildrenStepper.value))
    }

    @IBOutlet var wifiSwitch: UISwitch!
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        // TODO:
    }

    @IBOutlet var roomTypeLabel: UILabel!
    var roomType: RoomType?

    func updateRoomType() {
        roomTypeLabel.text = (roomType != nil) ? roomType!.name : "Not Set"
    }

    func selectRoomTypeTableViewController(_ controller: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }

    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType

        return selectRoomTypeController
    }
}
