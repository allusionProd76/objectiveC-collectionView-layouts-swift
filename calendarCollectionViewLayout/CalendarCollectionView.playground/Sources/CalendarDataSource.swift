//
//  CalendarDataSource.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/11/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//

import UIKit

public typealias ConfigureCellClosure = (_ cell: CalendarEventCell?, _ indexPath: IndexPath?, _ event: CalendarEvent) -> Void
public typealias ConfigureHeaderViewClosure = (_ headerView: HeaderView?, _ kind: String?, _ indexPath: IndexPath?) -> Void

public class CalendarDataSource: NSObject, UICollectionViewDataSource {

    public var configureCellClosure: ConfigureCellClosure?
    public var configureHeaderViewClosure: ConfigureHeaderViewClosure?
    public var events: [CalendarEvent]?

    public override func awakeFromNib() {
        events = []
        generateSampleData()
    }

    public func generateSampleData() {
        for _ in 0...20 {
            let event: SampleCalendarEvent = SampleCalendarEvent.randomEvent()
            events?.append(event)
        }
    }

    func eventAtIndexPath(indexPath: IndexPath) -> CalendarEvent {
        return events![indexPath.row]
    }

    public func indexPathsOfEventsBetweenMinDayIndex(minDayIndex: Int, maxDayIndex: Int, minStartHour: Int, maxStartHour: Int) -> [IndexPath] {

        var indexPaths: [IndexPath] = []

        for (idx, event) in events!.enumerated() {
            if event.day >= minDayIndex && event.day <= maxDayIndex && event.startHour >= minStartHour && event.startHour <= maxStartHour {
                let indexPath = IndexPath(indexes: [0,idx])
                indexPaths.append(indexPath)
            }
        }

        return indexPaths
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events!.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event: CalendarEvent = events![indexPath.item]
        let cell: CalendarEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarEventCell", for: indexPath) as! CalendarEventCell

        if configureCellClosure != nil {
            configureCellClosure!(cell, indexPath, event)
        }

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: HeaderView? = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView
        if configureHeaderViewClosure != nil {
            configureHeaderViewClosure!(headerView, kind, indexPath)
        }
        return headerView!
    }

}
