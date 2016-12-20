//
//  CalendarEvent.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/11/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//

import UIKit

public protocol CalendarEvent: NSObjectProtocol {
    var title: String? {get set}
    var day: Int {get set}
    var startHour: Int {get set}
    var durationInHours: Int {get set}
}
