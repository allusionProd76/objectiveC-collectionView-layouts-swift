//
//  CalendarDataSource.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/11/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//

import UIKit

typealias ConfigureCellClosure = (_ cell: CalendarEventCell?, _ indexPath: IndexPath?, _ event: CalendarEvent) -> Void
typealias ConfigureHeaderViewClosure = (_ headerView: HeaderView?, _ kind: String?, _ indexPath: IndexPath?) -> Void

class CalendarDataSource: NSObject, UICollectionViewDataSource {

    var configureCellClosure: ConfigureCellClosure?
    var configureHeaderViewClosure: ConfigureHeaderViewClosure?
    var events: [CalendarEvent]?

    override func awakeFromNib() {
        self.events = []
        self.generateSampleData()
    }

    func generateSampleData() {
        for _ in 0...20 {
            let event: SampleCalendarEvent = SampleCalendarEvent.randomEvent()
            self.events?.append(event)
        }
    }

    func eventAtIndexPath(indexPath: IndexPath) -> CalendarEvent {
        return self.events![indexPath.row]
    }

    func indexPathsOfEventsBetweenMinDayIndex(minDayIndex: Int, maxDayIndex: Int, minStartHour: Int, maxStartHour: Int) -> [IndexPath] {

        var indexPaths: [IndexPath] = []

        for (idx, event) in self.events!.enumerated() {
            if event.day >= minDayIndex && event.day <= maxDayIndex && event.startHour >= minStartHour && event.startHour <= maxStartHour {
                let indexPath = IndexPath(indexes: [0,idx])
                indexPaths.append(indexPath)
            }
        }
        print("\(indexPaths)")

        return indexPaths
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.events!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event: CalendarEvent = self.events![indexPath.item]
        let cell: CalendarEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarEventCell", for: indexPath) as! CalendarEventCell

        if self.configureCellClosure != nil {
            self.configureCellClosure!(cell, indexPath, event)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: HeaderView? = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView
        if self.configureHeaderViewClosure != nil {
            self.configureHeaderViewClosure!(headerView, kind, indexPath)
        }
        return headerView!
    }

}
