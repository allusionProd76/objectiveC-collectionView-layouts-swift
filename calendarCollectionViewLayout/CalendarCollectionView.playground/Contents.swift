//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

private let reuseIdentifier = "Cell"

public class CalendarViewController: UICollectionViewController {

    public var calendarDataSource: CalendarDataSource?

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        print("\(self.collectionView)")

        let headerViewNib = UINib.init(nibName: "HeaderView", bundle: nil)

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

let test = CalendarViewController(collectionViewLayout: WeekCalendarLayout())

PlaygroundPage.current.liveView = test.view

/*
class CustomCollectionViewCell: UICollectionViewCell{

    override init(frame: CGRect){
        super.init(frame: frame)

        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        label.text = "test"
        label.backgroundColor = UIColor.white
        self.contentView.addSubview(label)
    }

    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
}

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView: UICollectionView!
    let items = ["Item 1", "Item 2", "Item 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 5.0
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.itemSize = CGSize(width: 40, height: 40)

        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        self.collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.red
        return cell
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
}

var ctrl2 = CollectionViewController()
PlaygroundPage.current.liveView = ctrl2.view
 */