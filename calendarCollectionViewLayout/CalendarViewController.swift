//
//  CalendarViewController.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/11/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CalendarViewController: UICollectionViewController {

    @IBOutlet var calendarDataSource: CalendarDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerViewNib = UINib.init(nibName: "HeaderView", bundle: nil)
        collectionView?.register(headerViewNib, forSupplementaryViewOfKind: "DayHeaderView", withReuseIdentifier: "HeaderView")
        collectionView?.register(headerViewNib, forSupplementaryViewOfKind: "HourHeaderView", withReuseIdentifier: "HeaderView")

        let dataSource: CalendarDataSource? = collectionView?.dataSource as? CalendarDataSource
        dataSource?.configureCellClosure =  {(cell: CalendarEventCell?, indexPath: IndexPath?, event: CalendarEvent) in
            cell!.titleLabel?.text = event.title
        }
        dataSource?.configureHeaderViewClosure = {(headerView: HeaderView?, kind: String?, indexPath: IndexPath?) in
            if kind == "DayHeaderView" {
                headerView?.titleLabel?.text = "Day \(indexPath!.item + 1)"
            }
            else if kind == "HourHeaderView" {
                headerView?.titleLabel?.text = "\(indexPath!.item + 1):00"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
