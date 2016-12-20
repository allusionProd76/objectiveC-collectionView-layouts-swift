//
//  CalendarViewController.swift
//  calendarCollectionViewLayout
//
//  Created by chrismart laptop on 11/11/16.
//  Copyright © 2016 Allusion Productions. All rights reserved.
//
/*
import UIKit

private let reuseIdentifier = "Cell"

public class CalendarViewController: UICollectionViewController {

    @IBOutlet var calendarDataSource: CalendarDataSource?

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)

        let headerViewNib = UINib.init(nibName: "HeaderView", bundle: nil)

        let layout = WeekCalendarLayout()

        self.collectionView = UICollectionView.init(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView?.register(headerViewNib, forSupplementaryViewOfKind: "DayHeaderView", withReuseIdentifier: "HeaderView")
        self.collectionView?.register(headerViewNib, forSupplementaryViewOfKind: "HourHeaderView", withReuseIdentifier: "HeaderView")

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

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
*/
