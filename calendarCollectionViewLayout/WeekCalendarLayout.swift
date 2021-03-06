//
//  WeekCalendarLayout.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/18/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//

import UIKit

let DaysPerWeek: Int = 7
let HoursPerDay: Int = 24
let HorizontalSpacing: CGFloat = 10
let HeightPerHour: CGFloat = 50
let DayHeaderHeight: CGFloat = 40
let HourHeaderWidth: CGFloat = 100

class WeekCalendarLayout: UICollectionViewLayout {

    override var collectionViewContentSize: CGSize {
        let contentWidth = collectionView?.bounds.size.width
        let contentHeight = DayHeaderHeight + (HeightPerHour * CGFloat(HoursPerDay))
        let contentSize = CGSize(width: contentWidth!, height: contentHeight)

        return contentSize
    }

    // Creates layout attributes for day screen.
    override func layoutAttributesForElements(in inRect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes: [UICollectionViewLayoutAttributes] = []

        let visibleIndexPaths = indexPathOfDayGrid(inRect: inRect)
        for indexPath in visibleIndexPaths {
            let attributes: UICollectionViewLayoutAttributes = layoutAttributesForItem(at: indexPath)!
            layoutAttributes.append(attributes)
        }

        let dayHeaderViewIndexPaths = indexPathsOfDayHeaderViews(inRect: inRect)
        for indexPath in dayHeaderViewIndexPaths! {
            let attributes: UICollectionViewLayoutAttributes = layoutAttributesForSupplementaryView(ofKind: "DayHeaderView", at: indexPath)!
            layoutAttributes.append(attributes)
        }

        let hourHeaderViewIndexPaths = indexPathsOfHourHeaderViews(inRect: inRect)
        for indexPath in hourHeaderViewIndexPaths! {
            let attributes: UICollectionViewLayoutAttributes = layoutAttributesForSupplementaryView(ofKind: "HourHeaderView", at: indexPath)!
            layoutAttributes.append(attributes)

        }
        return layoutAttributes
    }

    // Creates viewlayout atributes for events.
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let dataSource: CalendarDataSource = collectionView!.dataSource as! CalendarDataSource
        let event: CalendarEvent = dataSource.eventAtIndexPath(indexPath: indexPath)
        let attributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attributes.frame = frameFor(event: event)

        return attributes
    }

    // Creates layout for day and hour header views.
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes: UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: elementKind, with: indexPath)

        let totalWidth: CGFloat = collectionViewContentSize.width
        if elementKind == "DayHeaderView" {
            let availableWidth: CGFloat = totalWidth - HourHeaderWidth
            let widthPerDay = availableWidth / CGFloat(DaysPerWeek)
            attributes.frame = CGRect(x: HourHeaderWidth + (widthPerDay * CGFloat(indexPath.item)), y: 0, width: widthPerDay, height: DayHeaderHeight)
            attributes.zIndex = -10
        } else if elementKind == "HourHeaderView" {
            attributes.frame = CGRect(x: 0, y: DayHeaderHeight + HeightPerHour * CGFloat(indexPath.item), width: totalWidth, height: CGFloat(HeightPerHour))
            attributes.zIndex = -10
        }
        return attributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // MARK: Helpers

    func indexPathOfDayGrid(inRect: CGRect) -> [IndexPath] {
        let minVisibleDay = dayIndexFrom(xCoordinate: inRect.minX)
        let maxVisibleDay = dayIndexFrom(xCoordinate: inRect.maxX)
        let minVisibleHour = dayIndexFrom(xCoordinate: inRect.minY)
        let maxVisibleHour = dayIndexFrom(xCoordinate: inRect.maxY)

        let dataSource: CalendarDataSource? = collectionView!.dataSource as! CalendarDataSource?
        let indexPaths: [IndexPath]? = dataSource?.indexPathsOfEventsBetweenMinDayIndex(minDayIndex: minVisibleDay, maxDayIndex: maxVisibleDay, minStartHour: minVisibleHour, maxStartHour: maxVisibleHour)

        return indexPaths!
    }

    func indexPathsOfDayHeaderViews(inRect: CGRect) -> [IndexPath]? {

        if inRect.minY > DayHeaderHeight {
            return []
        }

        let minDayIndex = dayIndexFrom(xCoordinate: inRect.minX)
        let maxDayIndex = dayIndexFrom(xCoordinate: inRect.maxX)

        var indexPaths: [IndexPath] = []
        let idx = minDayIndex
        for idx in idx..<maxDayIndex {
            let indexPath = IndexPath(indexes: [0,idx])
            indexPaths.append(indexPath)
        }

        return indexPaths
    }

    func dayIndexFrom(xCoordinate: CGFloat) -> Int {

        let contentWidth = collectionViewContentSize.width - CGFloat(HourHeaderWidth)
        let widthPerDay = contentWidth / CGFloat(DaysPerWeek)
        let dayIndex = max(0, Int((xCoordinate - HourHeaderWidth) / widthPerDay))

        return dayIndex
    }

    func indexPathsOfHourHeaderViews(inRect: CGRect) -> [IndexPath]? {

        if inRect.minX > HourHeaderWidth {
            return []
        }
        let minHourIndex = hourIndexFrom(yCoordinate: inRect.minY)
        let maxHourIndex = hourIndexFrom(yCoordinate: inRect.maxY)

        var indexPaths: [IndexPath] = []
        let idx = minHourIndex
        for idx in idx..<maxHourIndex {
            let indexPath = IndexPath(indexes: [0,idx])
            indexPaths.append(indexPath)
        }

        return indexPaths
        
    }

    func hourIndexFrom(yCoordinate: CGFloat) -> Int {

        let hourIndex = max(0, Int((yCoordinate - DayHeaderHeight) / HeightPerHour))
        return hourIndex
    }

    func frameFor(event: CalendarEvent) -> CGRect {

        let totalWidth: CGFloat = collectionViewContentSize.width - HourHeaderWidth
        let widthPerDay = totalWidth / CGFloat(DaysPerWeek)

        var frame = CGRect()
        frame.origin.x = HourHeaderWidth + widthPerDay * CGFloat(event.day)
        frame.origin.y = DayHeaderHeight + HeightPerHour * CGFloat(event.startHour)
        frame.size.width = widthPerDay
        frame.size.height = CGFloat(event.durationInHours) * HeightPerHour

        frame = frame.insetBy(dx: HorizontalSpacing/2.0, dy: 0)

        return frame
    }

}
