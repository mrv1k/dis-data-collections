//
//  Registration.swift
//  HotelManzana
//
//  Created by Viktor Khotimchenko on 2021-02-11.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var email: String

    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int

    var wifi: Bool
    var roomType: RoomType
}
