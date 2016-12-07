# objectiveC-collectionView-Layouts-Swift
Migrating objcio-issue3-collectionView-layout example to swift

Hellow and welcome to this effort. I loved the [example](https://github.com/objcio/issue-3-collection-view-layouts) provided by Ole Begemann and obc.io about UICollectionViewLayout.

Please view the [article](https://www.objc.io/issues/3-views/collection-view-layouts/) for additional information.

The project is not yet complete as I am getting an error in the CalendarDataSource.

The following method creates the error below:

    func eventAtIndexPath(indexPath: IndexPath) -> CalendarEvent {
        return self.events![indexPath.item]
    }

error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
The process has been returned to the state before expression evaluation.

Any help towards this effort will be appreciated.
