//
//  Booking.swift
//  Tasty
//
//  Created by Marko Ilic on 14.9.23..
//

import SwiftUI

//data: {
//    [
//    "17/07/2023": {
//        [
//            "16:00",
//            "16:30",
//            "17:00"
//        ]
//    }
//]
//}

struct BookingDates {
    var availableDates: [String: [String]]
}

class Booking {
    let dates = BookingDates(availableDates: ["9/14/2023": ["16:00", "16:30", "17:00"], "9/15/2023": ["12:00", "13:00"]])
    
    func has(date: Date) -> Bool {
        dates.availableDates.contains(where: { $0.key == date.formatted(date: .numeric, time: .omitted)})
    }
    
    func get(date: Date) -> Dictionary<String, [String]>.Element? {
        dates.availableDates.first(where: { $0.key == date.formatted(date: .numeric, time: .omitted)})
    }
}
