//
//  RoomType.swift
//  HotelManzana
//
//  Created by Viktor Khotimchenko on 2021-02-11.
//

import Foundation

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int

    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        lhs.id == rhs.id
    }
}
