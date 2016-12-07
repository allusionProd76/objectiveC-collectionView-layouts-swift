//
//  SampleCalendarEvent.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/11/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//

import UIKit

class SampleCalendarEvent: NSObject, CalendarEvent {

    var title: String?
    var day: Int = 0
    var startHour: Int = 0
    var durationInHours: Int = 0

    class func randomEvent() -> SampleCalendarEvent {
        let randomID: UInt32 = arc4random_uniform(10000)
        let title: String? = "Event \(randomID)"

        let randomDay: UInt32 = arc4random_uniform(7)
        let randomStartHour: UInt32 = arc4random_uniform(20)
        let randomDuration: UInt32 = arc4random_uniform(5) + 1

        return eventWithTitle(title: title, day: Int(randomDay), startHour: Int(randomStartHour), durationInHours: Int(randomDuration))
    }

    class func eventWithTitle(title: String?, day: Int, startHour: Int, durationInHours: Int) -> SampleCalendarEvent {
        return self.init(title: title, day: day, startHour: startHour, durationInHours: durationInHours)
    }

    required init(title: String?, day: Int, startHour: Int, durationInHours: Int) {
        super.init()
        self.title = title
        self.day = day
        self.startHour = startHour
        self.durationInHours = durationInHours
    }

    func descript() -> String? {
        return "\(title): Day \(day) - Hour \(startHour) - Duration \(durationInHours)"
    }
}
